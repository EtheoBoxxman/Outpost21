/obj/item/weapon/rig/attackby(obj/item/W as obj, mob/living/user as mob)
	if(!istype(user))
		return 0

	if(electrified != 0)
		if(shock(user)) //Handles removing charge from the cell, as well. No need to do that here.
			return

	// Pass repair items on to the chestpiece.
	if(chest && (istype(W,/obj/item/stack/material) || istype(W, /obj/item/weapon/weldingtool)))
		return chest.attackby(W,user)

	// Lock or unlock the access panel.
	if(W.GetID())
		if(subverted)
			locked = 0
			to_chat(user, "<span class='danger'>It looks like the locking system has been shorted out.</span>")
			return

		if(!LAZYLEN(req_access) && !LAZYLEN(req_one_access))
			locked = 0
			to_chat(user, "<span class='danger'>\The [src] doesn't seem to have a locking mechanism.</span>")
			return

		if(security_check_enabled && !src.allowed(user))
			to_chat(user, "<span class='danger'>Access denied.</span>")
			return

		locked = !locked
		to_chat(user, "You [locked ? "lock" : "unlock"] \the [src] access panel.")
		return

	else if(W.is_crowbar())
		if(!open && locked)
			to_chat(user, "The access panel is locked shut.")
			return

		open = !open
		to_chat(user, "You [open ? "open" : "close"] the access panel.")
		return

	if(open)
		// Hacking.
		if(W.is_wirecutter() || istype(W, /obj/item/device/multitool))
			if(open)
				wires.Interact(user)
			else
				to_chat(user, "You can't reach the wiring.")
			return
		// Air tank.
		if(istype(W,/obj/item/weapon/tank)) //Todo, some kind of check for suits without integrated air supplies.

			if(air_supply)
				to_chat(user, "\The [src] already has a tank installed.")
				return

			if(!user.unEquip(W))
				return

			air_supply = W
			W.forceMove(src)
			to_chat(user, "You slot [W] into [src] and tighten the connecting valve.")
			return

		// Check if this is a hardsuit upgrade or a modification.
		else if(istype(W,/obj/item/rig_module))
			if(ishuman(src.loc))
				var/mob/living/carbon/human/H = src.loc
				if(H.back == src || H.belt == src)
					to_chat(user, "<span class='danger'>You can't install a hardsuit module while the suit is being worn.</span>")
					return 1

			if(!installed_modules)
				installed_modules = list()
			if(installed_modules.len)
				for(var/obj/item/rig_module/installed_mod in installed_modules)
					if(!installed_mod.redundant && istype(installed_mod,W))
						to_chat(user, "The hardsuit already has a module of that class installed.")
						return 1

			var/obj/item/rig_module/mod = W
			to_chat(user, "You begin installing \the [mod] into \the [src].")
			if(!do_after(user,40))
				return
			if(!user || !W)
				return
			if(!user.unEquip(mod))
				return
			to_chat(user, "You install \the [mod] into \the [src].")
			installed_modules |= mod
			mod.forceMove(src)
			mod.installed(src)
			update_icon()
			return 1

		else if(!cell && istype(W,/obj/item/weapon/cell))

			if(!user.unEquip(W))
				return
			to_chat(user, "You jack \the [W] into \the [src]'s battery mount.")
			W.forceMove(src)
			src.cell = W
			return

		else if(W.is_wrench())

			if(!air_supply)
				to_chat(user, "There is no tank to remove.")
				return

			if(user.r_hand && user.l_hand)
				air_supply.forceMove(get_turf(user))
			else
				user.put_in_hands(air_supply)
			to_chat(user, "You detach and remove \the [air_supply].")
			air_supply = null
			return

		else if(W.is_screwdriver())

			var/list/current_mounts = list()
			if(cell) current_mounts   += "cell"
			if(installed_modules && installed_modules.len) current_mounts += "system module"

			var/to_remove = tgui_input_list(usr, "Which would you like to modify?", "Removal Choice", current_mounts)
			if(!to_remove)
				return

			if(ishuman(src.loc) && to_remove != "cell")
				var/mob/living/carbon/human/H = src.loc
				if(H.back == src || H.belt == src)
					to_chat(user, "You can't remove an installed device while the hardsuit is being worn.")
					return

			switch(to_remove)

				if("cell")

					if(cell)
						to_chat(user, "You detach \the [cell] from \the [src]'s battery mount.")
						for(var/obj/item/rig_module/module in installed_modules)
							module.deactivate()
						if(user.r_hand && user.l_hand)
							cell.forceMove(get_turf(user))
						else
							cell.forceMove(user.put_in_hands(cell))
						cell = null
					else
						to_chat(user, "There is nothing loaded in that mount.")

				if("system module")

					var/list/possible_removals = list()
					for(var/obj/item/rig_module/module in installed_modules)
						if(module.permanent)
							continue
						possible_removals[module.name] = module

					if(!possible_removals.len)
						to_chat(user, "There are no installed modules to remove.")
						return

					var/removal_choice = tgui_input_list(usr, "Which module would you like to remove?", "Removal Choice", possible_removals)
					if(!removal_choice)
						return

					var/obj/item/rig_module/removed = possible_removals[removal_choice]
					to_chat(user, "You detach \the [removed] from \the [src].")
					removed.forceMove(get_turf(src))
					removed.removed()
					installed_modules -= removed
					update_icon()

		return

	// If we've gotten this far, all we have left to do before we pass off to root procs
	// is check if any of the loaded modules want to use the item we've been given.
	for(var/obj/item/rig_module/module in installed_modules)
		if(module.accepts_item(W,user)) //Item is handled in this proc
			return
	..()


/obj/item/weapon/rig/attack_hand(var/mob/user)

	if(electrified != 0)
		if(shock(user)) //Handles removing charge from the cell, as well. No need to do that here.
			return
	..()

/obj/item/weapon/rig/emag_act(var/remaining_charges, var/mob/user)
	if(!subverted)
		LAZYCLEARLIST(req_access)
		LAZYCLEARLIST(req_one_access)
		locked = 0
		subverted = 1
		to_chat(user, "<span class='danger'>You short out the access protocol for the suit.</span>")
		return 1
