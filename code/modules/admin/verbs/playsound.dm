var/list/sounds_cache = list()

/client/proc/play_sound(S as sound)
	set category = VERBTAB_SPECIAL
	set name = "Play Global Sound"
	if(!check_rights(R_SOUNDS))	return

	var/sound/uploaded_sound = sound(S, volume = 50, repeat = 0, wait = 1, channel = 777)
	uploaded_sound.priority = 250

	sounds_cache += S

	if(tgui_alert(usr, "Do you ready?\nSong: [S]\nNow you can also play this sound using \"Play Server Sound\".", "Confirmation request", list("Play","Cancel")) == "Cancel")
		return

	log_admin("[key_name(src)] played sound [S]")
	message_admins("[key_name_admin(src)] played sound [S]", 1)
	for(var/mob/M in player_list)
		if(M.is_preference_enabled(/datum/client_preference/play_admin_midis))
			M << uploaded_sound

	feedback_add_details("admin_verb","PGS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/play_local_sound(S as sound)
	set category = VERBTAB_SPECIAL
	set name = "Play Local Sound"
	if(!check_rights(R_SOUNDS))	return

	log_admin("[key_name(src)] played a local sound [S]")
	message_admins("[key_name_admin(src)] played a local sound [S]", 1)
	playsound(src.mob, S, 50, 0, 0)
	feedback_add_details("admin_verb","PLS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/play_z_sound(S as sound)
	set category = VERBTAB_SPECIAL
	set name = "Play Z Sound"
	if(!check_rights(R_SOUNDS))	return
	var/target_z = mob.z
	var/sound/uploaded_sound = sound(S, repeat = 0, wait = 1, channel = 777)
	uploaded_sound.priority = 250

	sounds_cache += S

	if(tgui_alert(usr, "Do you ready?\nSong: [S]\nNow you can also play this sound using \"Play Server Sound\".", "Confirmation request", list("Play","Cancel")) == "Cancel")
		return

	log_admin("[key_name(src)] played sound [S] on Z[target_z]")
	message_admins("[key_name_admin(src)] played sound [S] on Z[target_z]", 1)
	for(var/mob/M in player_list)
		if(M.is_preference_enabled(/datum/client_preference/play_admin_midis) && M.z == target_z)
			M << uploaded_sound

	feedback_add_details("admin_verb","PZS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/play_server_sound()
	set category = VERBTAB_SPECIAL
	set name = "Play Server Sound"
	if(!check_rights(R_SOUNDS))	return

	var/list/sounds = file2list("sound/serversound_list.txt");
	sounds += "--CANCEL--"
	sounds += sounds_cache

	var/melody = tgui_input_list(usr, "Select a sound from the server to play", "Server sound list", sounds, "--CANCEL--")

	if(melody == "--CANCEL--")	return

	play_sound(melody)
	feedback_add_details("admin_verb","PSS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/*
/client/proc/cuban_pete()
	set category = VERBTAB_SPECIAL
	set name = "Cuban Pete Time"

	message_admins("[key_name_admin(usr)] has declared Cuban Pete Time!", 1)
	for(var/mob/M in player_list)
		if(M.client)
			if(M.client.midis)
				M << 'cubanpetetime.ogg'

	for(var/mob/living/carbon/human/CP in human_mob_list)
		if(CP.real_name=="Cuban Pete" && CP.key!="Rosham")
			to_chat(CP, "Your body can't contain the rhumba beat")
			CP.gib()


/client/proc/bananaphone()
	set category = VERBTAB_SPECIAL
	set name = "Banana Phone"

	message_admins("[key_name_admin(usr)] has activated Banana Phone!", 1)
	for(var/mob/M in player_list)
		if(M.client)
			if(M.client.midis)
				M << 'bananaphone.ogg'


/client/proc/space_asshole()
	set category = VERBTAB_SPECIAL
	set name = "Space Asshole"

	message_admins("[key_name_admin(usr)] has played the Space Asshole Hymn.", 1)
	for(var/mob/M in player_list)
		if(M.client)
			if(M.client.midis)
				M << 'sound/music/space_asshole.ogg'


/client/proc/honk_theme()
	set category = VERBTAB_SPECIAL
	set name = "Honk"

	message_admins("[key_name_admin(usr)] has creeped everyone out with Blackest Honks.", 1)
	for(var/mob/M in player_list)
		if(M.client)
			if(M.client.midis)
				M << 'honk_theme.ogg'*/
