/datum/power/changeling/bioelectrogenesis
	name = "Bioelectrogenesis"
	desc = "We reconfigure a large number of cells in our body to generate an electric charge.  \
	On demand, we can attempt to recharge anything in our active hand, or we can touch someone with an electrified hand, shocking them."
	helptext = "We can shock someone by grabbing them and using this ability, or using the ability with an empty hand and touching them.  \
	Shocking someone costs ten chemicals per use."
	enhancedtext = "Shocking biologicals without grabbing only requires five chemicals, and has more disabling power."
	ability_icon_state = "ling_bioelectrogenesis"
	genomecost = 2
	verbpath = /mob/living/carbon/human/proc/changeling_bioelectrogenesis

//Recharge whatever's in our hand, or shock people.
/mob/living/carbon/human/proc/changeling_bioelectrogenesis()
	set category = VERBTAB_POWERS
	set name = "Bioelectrogenesis (20 + 10/shock)"
	set desc = "Recharges anything in your hand, or shocks people."

	var/datum/changeling/changeling = changeling_power(20,0,100,CONSCIOUS)

	var/obj/held_item = get_active_hand()

	if(!changeling)
		return 0

	if(held_item == null)
		if(src.mind.changeling.recursive_enhancement)
			if(changeling_generic_weapon(/obj/item/weapon/electric_hand/efficent,0))
				to_chat(src, "<span class='notice'>We will shock others more efficently.</span>")
				return 1
		else
			if(changeling_generic_weapon(/obj/item/weapon/electric_hand,0))  //Chemical cost is handled in the equip proc.
				return 1
		return 0

	else
		// Handle glove conductivity.
		var/obj/item/clothing/gloves/gloves = src.gloves
		var/siemens = 1
		if(gloves)
			siemens = gloves.siemens_coefficient

		//If we're grabbing someone, electrocute them.
		if(istype(held_item,/obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = held_item
			if(G.affecting)
				G.affecting.electrocute_act(10 * siemens, src, 1.0, BP_TORSO, 0)
				var/agony = 80 * siemens //Does more than if hit with an electric hand, since grabbing is slower.
				G.affecting.stun_effect_act(0, agony, BP_TORSO, src)

				add_attack_logs(src,G.affecting,"Changeling shocked")

				if(siemens)
					visible_message("<span class='warning'>Arcs of electricity strike [G.affecting]!</span>",
					"<span class='warning'>Our hand channels raw electricity into [G.affecting].</span>",
					"<span class='italics'>You hear sparks!</span>")
				else
					to_chat(src, "<span class='warning'>Our gloves block us from shocking \the [G.affecting].</span>")
				src.mind.changeling.chem_charges -= 10
				return 1

		//Otherwise, charge up whatever's in their hand.
		else
			//This checks both the active hand, and the contents of the active hand's held item.
			var/success = 0
			var/list/L = new() //We make a new list to avoid copypasta.

			//Check our hand.
			if(istype(held_item,/obj/item/weapon/cell))
				L.Add(held_item)

			//Now check our hand's item's contents, so we can recharge guns and other stuff.
			for(var/obj/item/weapon/cell/cell in held_item.contents)
				L.Add(cell)

			//Now for the actual recharging.
			for(var/obj/item/weapon/cell/cell in L)
				visible_message("<span class='warning'>Some sparks fall out from \the [src.name]\'s [held_item]!</span>",
				"<span class='warning'>Our hand channels raw electricity into \the [held_item].</span>",
				"<span class='italics'>You hear sparks!</span>")
				var/i = 10
				if(siemens)
					while(i)
						cell.charge += 100 * siemens //This should be a nice compromise between recharging guns and other batteries.
						if(cell.charge > cell.maxcharge)
							cell.charge = cell.maxcharge
							break
						if(siemens)
							var/T = get_turf(src)
							new /obj/effect/effect/sparks(T)
							held_item.update_icon()
						i--
						sleep(1 SECOND)
					success = 1
			if(success == 0) //If we couldn't do anything with the ability, don't deduct the chemicals.
				to_chat(src, "<span class='warning'>We are unable to affect \the [held_item].</span>")
			else
				src.mind.changeling.chem_charges -= 10
			return success

/obj/item/weapon/electric_hand
	name = "electrified hand"
	desc = "You could probably shock someone badly if you touched them, or recharge something."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "electric_hand"
	show_examine = FALSE

	var/shock_cost = 10
	var/agony_amount = 60
	var/electrocute_amount = 10

/obj/item/weapon/electric_hand/efficent
	shock_cost = 5
	agony_amount = 80
	electrocute_amount = 20

/obj/item/weapon/electric_hand/New()
	if(ismob(loc))
		visible_message("<span class='warning'>Electrical arcs form around [loc.name]\'s hand!</span>",
		"<span class='warning'>We store a charge of electricity in our hand.</span>",
		"<span class='italics'>You hear crackling electricity!</span>")
		var/T = get_turf(src)
		new /obj/effect/effect/sparks(T)

/obj/item/weapon/electric_hand/dropped(mob/user)
	spawn(1)
		if(src)
			qdel(src)

/obj/item/weapon/electric_hand/afterattack(var/atom/target, var/mob/living/carbon/human/user, proximity)
	if(!target)
		return
	if(!proximity)
		return

	// Handle glove conductivity.
	var/obj/item/clothing/gloves/gloves = user.gloves
	var/siemens = 1
	if(gloves)
		siemens = gloves.siemens_coefficient

	//Excuse the copypasta.
	if(istype(target,/mob/living/carbon))
		var/mob/living/carbon/C = target

		if(user.mind.changeling.chem_charges < shock_cost)
			to_chat(src, "<span class='warning'>We require more chemicals to electrocute [C]!</span>")
			return 0

		C.electrocute_act(electrocute_amount * siemens,src,1.0,BP_TORSO)
		C.stun_effect_act(0, agony_amount * siemens, BP_TORSO, src)

		add_attack_logs(user,C,"Shocked with [src]")

		if(siemens)
			visible_message("<span class='warning'>Arcs of electricity strike [C]!</span>",
			"<span class='warning'>Our hand channels raw electricity into [C]</span>",
			"<span class='italics'>You hear sparks!</span>")
		else
			to_chat(src, "<span class='warning'>Our gloves block us from shocking \the [C].</span>")
		//qdel(src)  //Since we're no longer a one hit stun, we need to stick around.
		user.mind.changeling.chem_charges -= shock_cost
		return 1

	else if(issilicon(target))
		var/mob/living/silicon/S = target

		if(user.mind.changeling.chem_charges < 10)
			to_chat(src, "<span class='warning'>We require more chemicals to electrocute [S]!</span>")
			return 0

		S.electrocute_act(60,src,0.75) //If only they had surge protectors.
		if(siemens)
			visible_message("<span class='warning'>Arcs of electricity strike [S]!</span>",
			"<span class='warning'>Our hand channels raw electricity into [S]</span>",
			"<span class='italics'>You hear sparks!</span>")
			to_chat(S, "<span class='danger'>Warning: Electrical surge detected!</span>")
		//qdel(src)
		user.mind.changeling.chem_charges -= 10
		return 1

	else
		if(istype(target,/obj/))
			var/success = 0
			var/obj/T = target
			//We can also recharge things we touch, such as APCs or hardsuits.
			for(var/obj/item/weapon/cell/cell in T.contents)
				visible_message("<span class='warning'>Some sparks fall out from \the [target]!</span>",
				"<span class='warning'>Our hand channels raw electricity into \the [target].</span>",
				"<span class='italics'>You hear sparks!</span>")
				var/i = 10
				if(siemens)
					while(i)
						cell.charge += 100 * siemens //This should be a nice compromise between recharging guns and other batteries.
						if(cell.charge > cell.maxcharge)
							cell.charge = cell.maxcharge
							break //No point making sparks if the cell's full.
	//					if(!Adjacent(T))
	//						break
						if(siemens)
							var/Turf = get_turf(src)
							new /obj/effect/effect/sparks(Turf)
							T.update_icon()
						i--
						sleep(1 SECOND)
					success = 1
					break
			if(success == 0)
				to_chat(src, "<span class='warning'>We are unable to affect \the [target].</span>")
			else
				qdel(src)
			return 1
