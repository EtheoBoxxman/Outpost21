/*
**	For now, these are just neutral traits for Xenochimera only to take.
*/
/datum/trait/positive/weaver/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Weaver"
	desc = "You've evolved your body to produce silk that you can fashion into articles of clothing and other objects."
	cost = 0
	category = 0

/datum/trait/positive/hardfeet/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Hard Feet"
	desc = "Your body has adapted to make your feet immune to glass shards, whether by developing hooves, chitin, or just horrible callous."
	cost = 0
	category = 0

// Why put this on Xenochimera of all species? I have no idea, but someone may be enough of a lunatic to take it.
/datum/trait/negative/neural_hypersensitivity/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Neural Hypersensitivity"
	desc = "Despite your evolutionary efforts, you are unusually sensitive to pain. \
	Given your species' typical reactions to pain, this can only end well for you!"
	cost = 0
	category = 0

/datum/trait/positive/melee_attack_fangs/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Sharp Melee & Numbing Fangs"
	desc = "Your hunting instincts manifest in earnest! You have grown numbing fangs alongside your naturally grown hunting weapons."
	cost = 0
	category = 0

/datum/trait/positive/snowwalker/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Snow Walker"
	desc = "You've adapted to traversing snowy terrain. Snow does not slow you down!"
	cost = 0
	category = 0

/datum/trait/positive/aquatic/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Aquatic"
	desc = "You can breathe under water and can traverse water more efficiently. Additionally, you can eat others in the water."
	cost = 0
	category = 0
	excludes = list(/datum/trait/positive/winged_flight/xenochimera)

/datum/trait/positive/winged_flight/xenochimera
	name = "Xenochhimera: Winged Flight"
	desc = "Allows you to fly by using your wings. Don't forget to bring them!"
	cost = 0
	excludes = list(/datum/trait/positive/aquatic/xenochimera)

/* // Commented out in lieu of finding a better solution.
/datum/trait/neutral/coldadapt/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Temp. Adapted, Cold"
	desc = "You have adapted to withstand much colder temperatures than other species, and can even be comfortable in extremely cold environments. You are also more vulnerable to hot environments, and have a lower body temperature as a consequence of these adaptations, thanks to your evolutionary efforts."
	cost = 0
	category = 0
	can_take = ORGANICS // (Not sure if this is needed for Xenochimera-specific sub-version.)
	excludes = list(/datum/trait/neutral/hotadapt, /datum/trait/neutral/hotadapt/xenochimera)

/datum/trait/neutral/hotadapt/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Temp. Adapted, Heat"
	desc = "You have adapted to withstand much hotter temperatures than other species, and can even be comfortable in extremely hot environments. You are also more vulnerable to cold environments, and have a higher body temperature as a consequence of these adaptations, thanks to your evolutionary efforts."
	cost = 0
	category = 0
	can_take = ORGANICS // negates the need for suit coolers entirely for synths, so no. (Not sure if this is needed for Xenochimera-specific sub-version.)
	excludes = list(/datum/trait/neutral/coldadapt, /datum/trait/neutral/coldadapt/xenochimera)
*/

/datum/trait/neutral/autohiss_unathi/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Autohiss (Unathi)"
	desc = "You roll your S's and x's"
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"s" = list("ss", "sss", "ssss")
		),
	autohiss_extra_map = list(
			"x" = list("ks", "kss", "ksss")
		),
	autohiss_exempt = list("Sinta'unathi"))
	excludes = list(/datum/trait/neutral/autohiss_tajaran)

/datum/trait/neutral/autohiss_tajaran/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Autohiss (Tajaran)"
	desc = "You roll your R's."
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"r" = list("rr", "rrr", "rrrr")
		),
	autohiss_exempt = list("Siik"))
	excludes = list(/datum/trait/neutral/autohiss_unathi)

/datum/trait/positive/cocoon_tf/xenochimera
	sort = TRAIT_SORT_SPECIES
	allowed_species = list(SPECIES_XENOCHIMERA)
	name = "Xenochimera: Cocoon Spinner"
	desc = "Allows you to build a cocoon around yourself, using it to transform your body if you desire."
	cost = 0
	category = 0
