extends Node

class_name Constants

const FRAMERATE = 60

const FRAMERATE_FRAC = 1/FRAMERATE

const FALL_SPEED = 1
const WALK_SPEED = 1

static func normalize_pixel_per_frame(velocity: Vector2, delta: float):
	return velocity / delta
