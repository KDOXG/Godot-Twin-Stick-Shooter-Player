extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if global_position.x < 0 or get_viewport().get_visible_rect().size.x < global_position.x or global_position.y < 0 or get_viewport().get_visible_rect().size.y < global_position.y:
		clear()

func clear():
	queue_free()
