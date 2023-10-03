extends KinematicBody2D

onready var movement: Vector2 = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	movement = InputManager.get_move_vector()
	movement *= Constants.WALK_SPEED
	movement = move_and_slide(Constants.normalize_pixel_per_frame(movement, delta), Vector2.UP)
	print(movement)
	
