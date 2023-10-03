extends Node

class_name InputManagerClass

const attack_group: Array = ["Up", "Down", "Left", "Right"]
const groups: Dictionary = {
	"attack": ["attack_left", "attack_right", "attack_up", "attack_down"]
}

onready var disabled_move: bool = false
onready var disabled_action: bool = false

onready var previous_move: Vector2 = Vector2.ZERO
onready var previous_move_valid: Vector2 = Vector2.ZERO
onready var previous_attack: Vector2 = Vector2.ZERO
onready var previous_attack_valid: Vector2 = Vector2.ZERO

var mouse_active: bool = false

func _input(event):
	if event.as_text() in attack_group:
		mouse_active = false
	elif event is InputEventMouse:
		mouse_active = true

func get_move_vector() -> Vector2:
	var move: Vector2 = Vector2.ZERO
	if disabled_move:
		return move
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_up"):
		move.y = -previous_move.y if previous_move_valid.y else previous_move.y
		previous_move_valid.y = 0
	else:
		previous_move_valid.y = 1
		if Input.is_action_pressed("move_down"):
			move.y += Constants.DIRECTION.DOWN
		if Input.is_action_pressed("move_up"):
			move.y += Constants.DIRECTION.UP
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		move.x = -previous_move.x if previous_move_valid.x else previous_move.x
		previous_move_valid.x = 0
	else:
		previous_move_valid.x = 1
		if Input.is_action_pressed("move_right"):
			move.x += Constants.DIRECTION.RIGHT
		if Input.is_action_pressed("move_left"):
			move.x += Constants.DIRECTION.LEFT
	previous_move = move
	return move

func get_attack_vector() -> Vector2:
	var attack: Vector2 = Vector2.ZERO
	if disabled_action:
		return attack
	if mouse_active:
		var player_position = GroupManager.get_single_node("player").global_position
		var mouse_position = get_viewport().get_mouse_position()
		return player_position.direction_to(mouse_position)
	if Input.is_action_pressed("attack_down") and Input.is_action_pressed("attack_up"):
		attack.y = -previous_attack.y if previous_attack_valid.y else previous_attack.y
		previous_attack_valid.y = 0
	else:
		previous_attack_valid.y = 1
		if Input.is_action_pressed("attack_down"):
			attack.y += Constants.DIRECTION.DOWN
		if Input.is_action_pressed("attack_up"):
			attack.y += Constants.DIRECTION.UP
	if Input.is_action_pressed("attack_left") and Input.is_action_pressed("attack_right"):
		attack.x = -previous_attack.x if previous_attack_valid.x else previous_attack.x
		previous_attack_valid.x = 0
	else:
		previous_attack_valid.x = 1
		if Input.is_action_pressed("attack_right"):
			attack.x += Constants.DIRECTION.RIGHT
		if Input.is_action_pressed("attack_left"):
			attack.x += Constants.DIRECTION.LEFT
	previous_attack = attack
	return attack

func _is_action_pressed(action: String) -> bool:
	if disabled_action:
		return false
	return Input.is_action_pressed(action)

func is_action_group_single_pressed(group_name: String) -> bool:
	if disabled_action:
		return false
	for action in groups[group_name]:
		if Input.is_action_pressed(action):
			return true
	return false

func is_action_group_all_pressed(group_name: String) -> bool:
	if disabled_action:
		return false
	for action in groups[group_name]:
		if not Input.is_action_pressed(action):
			return false
	return true

func _is_action_just_pressed(action: String) -> bool:
	if disabled_action:
		return false
	return Input.is_action_just_pressed(action)

func set_move(value: bool):
	disabled_move = value

func set_action(value: bool):
	disabled_action = value
