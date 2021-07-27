/*
	These are simple defaults for your project.
 */

//"fancy" math for calculating time in ms from tick_usage percentage and the length of ticks
//percent_of_tick_used * (ticklag * 100(to convert to ms)) / 100(percent ratio)
//collapsed to percent_of_tick_used * tick_lag
/// for general usage of tick_usage
#define TICK_USAGE world.tick_usage
/// to be used where the result isn't checked
#define TICK_USAGE_REAL world.tick_usage
#define TICK_DELTA_TO_MS(percent_of_tick_used) ((percent_of_tick_used) * world.tick_lag)
#define TICK_USAGE_TO_MS(starting_tickusage) (TICK_DELTA_TO_MS(TICK_USAGE_REAL - starting_tickusage))

world
	fps = 20		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)


// Make objects move 8 pixels per tick when walking

mob
	step_size = 8

obj
	step_size = 8
	screen_loc = "CENTER"
	icon = 'lighting_object_big.dmi'
	icon_state = "light_big"
	plane = 12
	mouse_opacity = 0
	layer = 13
	//invisibility = 70
	blend_mode = BLEND_ADD
	appearance_flags = KEEP_TOGETHER|RESET_TRANSFORM

/obj/New()
	..()
	filters += filter(type="alpha", render_source = "*shadow_target", flags = MASK_INVERSE)
	var/mutable_appearance/MA = new()
	MA.plane = 16
	MA.icon = src.icon
	MA.icon_state = "triangle"
	//MA.transform = MA.transform.Scale(32,32).Turn(45)
	overlays += MA


/atom/movable/plane_master
	screen_loc = "CENTER"
	icon_state = "blank"
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_OVERLAY
	plane = 11
	color = "#000"

/atom/movable/plane_master/lighting
	plane = 12
	blend_mode = BLEND_MULTIPLY

/atom/movable/plane_master/shadows
	name = "Shadow alpha mask plane master"
	plane = 16
	render_target = "*shadow_target"
	blend_mode = BLEND_ADD



/turf/floor
	name = "floor"
	icon = 'light_64.dmi'
	icon_state = "floor"
	plane = 10

var/icon/thing = null

/client/New()
	..()
	screen += new/atom/movable/plane_master/shadows
	screen += new/atom/movable/plane_master/lighting
	spawn(10)
		new /obj(mob.loc)
