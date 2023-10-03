extends Node

class_name Constants

enum DIRECTION {
	LEFT = -1
	UP = -1
	RIGHT = 1
	DOWN = 1
	STOP = 0
}

const FRAMERATE = 60

const FRAMERATE_FRAC = 1/FRAMERATE

const WALK_SPEED = 1

const ATTACKING_FRAMES = 20

static func normalize_pixel_per_frame(velocity: Vector2, delta: float):
	return velocity / delta
