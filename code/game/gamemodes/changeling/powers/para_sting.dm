/datum/power/changeling/paralysis_sting
	name = "Paralysis Sting"
	desc = "We silently sting a human, paralyzing them for a short time."
	ability_icon_state = "ling_sting_para"
	genomecost = 3
	verbpath = /mob/proc/changeling_paralysis_sting

/mob/proc/changeling_paralysis_sting()
	set category = VERBTAB_POWERS
	set name = "Paralysis sting (30)"
	set desc="Sting target"

	var/mob/living/carbon/T = changeling_sting(30,/mob/proc/changeling_paralysis_sting)
	if(!T)
		return 0
	add_attack_logs(src,T,"Paralysis sting (changeling)")
	to_chat(T, "<span class='danger'>Your muscles begin to painfully tighten.</span>")
	T.Weaken(20)
	feedback_add_details("changeling_powers","PS")
	return 1
