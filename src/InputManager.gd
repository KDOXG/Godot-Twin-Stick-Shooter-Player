extends Node

class_name InputManagerClass

onready var disabled_move: bool = false
onready var disabled_action: bool = false

func get_move_vector() -> Vector2:
	var move: Vector2 = Vector2.ZERO
	if disabled_move:
		return move
	if Input.is_action_pressed("move_down"):
		move.y += 1
	if Input.is_action_pressed("move_up"):
		move.y += -1
	if Input.is_action_pressed("move_right"):
		move.x += 1
	if Input.is_action_pressed("move_left"):
		move.x += -1
	return move
	
func _is_action_pressed(action: String) -> bool:
	if disabled_action:
		return false
	return Input.is_action_pressed(action)
	
func _is_action_just_pressed(action: String) -> bool:
	if disabled_action:
		return false
	return Input.is_action_just_pressed(action)

func set_move(value: bool):
	disabled_move = value

func set_action(value: bool):
	disabled_action = value
