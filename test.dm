/*
	These are simple defaults for your project.
 */

world
	fps = 20		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)


//underlay object, dark blue
obj
	step_size = 8
	screen_loc = "CENTER"
	icon = 'lighting_object_big.dmi'
	icon_state = "light_big"
	plane = 12
	blend_mode = BLEND_ADD

/obj/New()
	..()
	filters += filter(type="alpha", render_source = "shadow_target", flags = MASK_INVERSE)
	//white triangle overlay
	var/mutable_appearance/MA = new()
	MA.plane = 16
	MA.icon = src.icon
	MA.icon_state = "triangle"
	MA.blend_mode = BLEND_OVERLAY
	overlays += MA
	alpha = 100


/atom/movable/plane_master
	screen_loc = "CENTER"
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY
	plane = 11
	color = "#000"  //comment this out to have two overlays of which one moves as in https://streamable.com/mt7mus

/atom/movable/plane_master/lighting
	plane = 12
	blend_mode = BLEND_MULTIPLY

/atom/movable/plane_master/shadows
	plane = 16
	render_target = "shadow_target"
	blend_mode = BLEND_ADD




///misc


mob
	step_size = 8
	icon = 'mob.dmi'
	icon_state = "mob"
	plane = 20

/turf/floor
	name = "floor"
	icon = 'light_64.dmi'
	icon_state = "floor"
	plane = 10

/client/New()
	..()
	screen += new/atom/movable/plane_master/shadows
	screen += new/atom/movable/plane_master/lighting
	var/obj/marker = new(locate(15,15,1))
	mob.loc = marker.loc