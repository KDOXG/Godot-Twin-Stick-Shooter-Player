extends KinematicBody2D

class_name Player

enum ANIMATION_STATES {
	ATTACKING
	ATTACKING_WALKING
	IDLE
	WALKING
}

onready var player_state: int = ANIMATION_STATES.IDLE

onready var movement: Vector2 = Vector2.ZERO

onready var is_attacking: bool = false
onready var facing_left: bool = false

func _ready():
	$AttackingTimer.call("connect", "timeout", self, "timeout_attacking")

func _physics_process(delta):
	
	movement = InputManager.get_move_vector()
	movement *= Constants.WALK_SPEED
	var final_movement = Constants.normalize_pixel_per_frame(movement, delta)
	movement = move_and_slide(final_movement, Vector2.UP)
	
	if InputManager._is_action_pressed("attack"):
		$Shooter.shoot(delta)
		is_attacking = true
		$AttackingTimer.set_timer(Constants.ATTACKING_FRAMES)
	
	set_state()
	set_animation()

func set_state():
	var idle: bool = movement == Vector2.ZERO
	player_state = ANIMATION_STATES.IDLE if idle else ANIMATION_STATES.WALKING
	
	if is_attacking:
		player_state = set_attacking_animation()
		
	if movement.x < 0:
		facing_left = true
	elif movement.x > 0:
		facing_left = false

func set_animation():
	$AnimatedSprite.set_flip_h(facing_left)
	$AnimatedSprite.play_by_index(player_state)

func set_attacking_animation():
	match player_state:
		ANIMATION_STATES.IDLE:
			return ANIMATION_STATES.ATTACKING
		ANIMATION_STATES.WALKING:
			return ANIMATION_STATES.ATTACKING_WALKING
	return player_state

func timeout_attacking():
	is_attacking = false
