/datum/power/changeling/blind_sting
	name = "Blind Sting"
	desc = "We silently sting a human, completely blinding them for a short time."
	enhancedtext = "Duration is extended."
	ability_icon_state = "ling_sting_blind"
	genomecost = 2
	allowduringlesserform = 1
	verbpath = /mob/proc/changeling_blind_sting

/mob/proc/changeling_blind_sting()
	set category = VERBTAB_POWERS
	set name = "Blind sting (20)"
	set desc="Sting target"

	var/mob/living/carbon/T = changeling_sting(20,/mob/proc/changeling_blind_sting)
	if(!T)
		return 0
	add_attack_logs(src,T,"Blind sting (changeling)")
	to_chat(T, "<span class='danger'>Your eyes burn horrificly!</span>")
	T.disabilities |= NEARSIGHTED
	var/duration = 300
	if(src.mind.changeling.recursive_enhancement)
		duration = duration + 150
		to_chat(src, "<span class='notice'>They will be deprived of sight for longer.</span>")
	spawn(duration)
		T.disabilities &= ~NEARSIGHTED
	T.Blind(10)
	T.eye_blurry = 20
	feedback_add_details("changeling_powers","BS")
	return 1
