var/datum/announcement/minor/captain_announcement = new(do_newscast = 1)

//////////////////////////////////
//			Captain
//////////////////////////////////

/datum/job/captain
	title = "Site Manager"
	flag = CAPTAIN
	departments = list(DEPARTMENT_COMMAND)
	sorting_order = 3 // Above everyone.
	departments_managed = list(DEPARTMENT_COMMAND)
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#2F2F7F"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 31
	economic_modifier = 20

	minimum_character_age = 25
	min_age_by_species = list() //SPECIES_HUMAN_VATBORN = 14) outpost 21 race removal
	ideal_character_age = 70 // Old geezer captains ftw
	ideal_age_by_species = list() //SPECIES_HUMAN_VATBORN = 55) /// Vatborn live shorter, no other race eligible for captain besides human/skrell 
	banned_job_species = list(SPECIES_UNATHI, SPECIES_TAJ, SPECIES_DIONA, SPECIES_PROMETHEAN/*, SPECIES_ZADDAT*/, "mechanical", "digital")// outpost 21 - race removal

	outfit_type = /decl/hierarchy/outfit/job/captain
	job_description = "The Site Manager manages the other Command Staff, and through them the rest of the station. Though they have access to everything, \
						they do not understand everything, and are expected to delegate tasks to the appropriate crew member. The Site Manager is expected to \
						have an understanding of Standard Operating Procedure, and is subject to it, and legal action, in the same way as every other crew member."
	alt_titles = list("Overseer"= /datum/alt_title/overseer)


/* outpost 21 edit - commenting out again~
// YW UNCOMMENTINGSTART: REINSTATE LOYALTY IMPLANT
/datum/job/captain/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(src)
// YW UNCOMMENTING END
*/

/datum/job/captain/get_access()
	return get_all_station_access().Copy()


// Captain Alt Titles
/datum/alt_title/overseer
	title = "Overseer"

//////////////////////////////////
//		Head of Personnel
//////////////////////////////////
/datum/job/hop
	title = "Head of Personnel"
	flag = HOP
	departments = list(DEPARTMENT_COMMAND, DEPARTMENT_CIVILIAN, DEPARTMENT_CARGO)
	sorting_order = 2 // Above the QM, below captain.
	departments_managed = list(DEPARTMENT_CIVILIAN, DEPARTMENT_CARGO)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Site Manager"
	selection_color = "#1D1D4F"
	req_admin_notify = 1
	minimal_player_age = 10
	economic_modifier = 10

	minimum_character_age = 25
	min_age_by_species = list(SPECIES_UNATHI = 70, SPECIES_TESHARI = 20, "mechanical" = 10) //, SPECIES_HUMAN_VATBORN = 14) outpost 21 race removal
	ideal_character_age = 50
	ideal_age_by_species = list(SPECIES_UNATHI = 140, SPECIES_TESHARI = 27, "mechanical" = 20)//, SPECIES_HUMAN_VATBORN = 20) outpost 21 race removal
	banned_job_species = list(SPECIES_PROMETHEAN/*, SPECIES_ZADDAT*/, "digital", SPECIES_DIONA)// outpost 21 - race removal

	outfit_type = /decl/hierarchy/outfit/job/hop
	job_description = "The Head of Personnel manages the Service department and most other civilians. They also \
						manage the Supply department, through the Quartermaster. In addition, the Head of Personnel oversees the personal accounts \
						of the crew, including their money and access. If necessary, the Head of Personnel is first in line to assume Acting Command." //YW EDIT
	alt_titles = list("Crew Resources Officer" = /datum/alt_title/cro)

	access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)

// HOP Alt Titles
/datum/alt_title/cro
	title = "Crew Resources Officer"

//////////////////////////////////
//		Command Secretary
//////////////////////////////////

/datum/job/secretary
	title = "Command Secretary"
	flag = BRIDGE
	departments = list(DEPARTMENT_COMMAND)
	department_accounts = list(DEPARTMENT_COMMAND)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "command staff"
	selection_color = "#1D1D4F"
	minimal_player_age = 5
	economic_modifier = 7

	access = list(access_heads, access_keycard_auth, access_RC_announce) //YAWN EDIT
	minimal_access = list(access_heads, access_keycard_auth, access_RC_announce)//YAWN EDIT

	outfit_type = /decl/hierarchy/outfit/job/secretary
	job_description = "A Command Secretary handles paperwork duty for the Heads of Staff, so they can better focus on managing their departments. \
						They are not Heads of Staff, and have no real authority."

