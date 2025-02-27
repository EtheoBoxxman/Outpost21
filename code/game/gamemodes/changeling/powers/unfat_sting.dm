/datum/power/changeling/unfat_sting
	name = "Unfat Sting"
	desc = "We silently sting a human, forcing them to rapidly metabolize their fat."
	genomecost = 1
	verbpath = /mob/proc/changeling_unfat_sting

/mob/proc/changeling_unfat_sting()
	set category = VERBTAB_POWERS
	set name = "Unfat sting (5)"
	set desc = "Sting target"

	var/mob/living/carbon/T = changeling_sting(5,/mob/proc/changeling_unfat_sting)
	if(!T)	return 0
	add_attack_logs(src,T,"Unfat sting (changeling)")
	to_chat(T, "<span class='danger'>you feel a small prick as stomach churns violently and you become to feel skinnier.</span>")
	T.adjust_nutrition(-100)
	feedback_add_details("changeling_powers","US")
	return 1
