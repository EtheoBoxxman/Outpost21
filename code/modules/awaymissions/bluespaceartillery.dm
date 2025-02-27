
/obj/machinery/artillerycontrol
	var/reloadmax = 60
	var/reload = 60
	name = "bluespace artillery control"
	icon_state = "control_boxp1"
	icon = 'icons/obj/machines/particle_accelerator2.dmi'
	density = TRUE
	anchored = TRUE

/obj/machinery/artillerycontrol/process()
	if(src.reload<reloadmax)
		src.reload++

/obj/structure/artilleryplaceholder
	name = "artillery"
	icon = 'icons/obj/machines/artillery.dmi'
	anchored = TRUE
	density = TRUE

/obj/structure/artilleryplaceholder/decorative
	density = FALSE

/obj/machinery/artillerycontrol/attack_hand(mob/user as mob)
	user.set_machine(src)
	var/dat = "<B>Bluespace Artillery Control:</B><BR>"
	dat += "Locked on<BR>"
	dat += "<B>Charge progress: [reload]/[reloadmax]:</B><BR>"
	dat += "<A href='byond://?src=\ref[src];fire=1'>Open Fire</A><BR>"
	dat += "Deployment of weapon authorized by <br>[using_map.company_name] <br><br>Remember, friendly fire is grounds for termination of your contract and life.<HR>"
	user << browse(dat, "window=scroll")
	onclose(user, "scroll")
	return

/obj/machinery/artillerycontrol/Topic(href, href_list)
	..()
	if (usr.stat || usr.restrained())
		return
	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || issilicon(usr))
		var/A = tgui_input_list(usr, "Area to jump bombard", "Open Fire", teleportlocs)
		var/area/thearea = teleportlocs[A]
		if (usr.stat || usr.restrained()) return
		if(src.reload < reloadmax) return
		if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || issilicon(usr))
			command_announcement.Announce("Bluespace artillery fire detected. Brace for impact.")
			message_admins("[key_name_admin(usr)] has launched an artillery strike.", 1)
			var/list/L = list()
			for(var/turf/T in get_area_turfs(thearea.type))
				L+=T
			var/loc = pick(L)
			explosion(loc,2,5,11)
			reload = 0
