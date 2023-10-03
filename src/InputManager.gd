extends Node

class_name InputManagerClass

const attack_group: Array = ["Up", "Down", "Left", "Right"]
const groups: Dictionary = {
	"attack": ["attack_left", "attack_right", "attack_up", "attack_down"]
}

onready var disabled_move: bool = false
onready var disabled_action: bool = false

onready var previous_move: Vector2 = Vector2.ZERO
onready var previous_move_valid: Vector2 = Constants.DEFAULT_DIRECTION
onready var previous_attack: Vector2 = Vector2.ZERO
onready var previous_attack_valid: Vector2 = Constants.DEFAULT_DIRECTION

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
	move = _get_direction_vector(previous_move, previous_move_valid, ["move_down", "move_up", "move_left", "move_right"])
	previous_move = move
	previous_move_valid.y = 0 if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_up") else 1
	previous_move_valid.x = 0 if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right") else 1
	return move
	

func get_attack_vector() -> Vector2:
	var attack: Vector2 = Vector2.ZERO
	if disabled_action:
		return attack
	if mouse_active:
		var player_position = GroupManager.get_single_node("player").global_position
		var mouse_position = get_viewport().get_mouse_position()
		return player_position.direction_to(mouse_position)
	
	attack = _get_direction_vector(previous_attack, previous_attack_valid, ["attack_down", "attack_up", "attack_left", "attack_right"])
	previous_attack = attack
	previous_attack_valid.y = 0 if Input.is_action_pressed("attack_down") and Input.is_action_pressed("attack_up") else 1
	previous_attack_valid.x = 0 if Input.is_action_pressed("attack_left") and Input.is_action_pressed("attack_right") else 1
	return attack
	

func _get_direction_vector(previous: Vector2, previous_valid: Vector2, directions: Array):
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_pressed(directions[0]) and Input.is_action_pressed(directions[1]):
		direction.y = Constants.DEFAULT_DIRECTION.y if previous.y == 0 \
		else -previous.y if previous_valid.y \
		else previous.y
	else:
		if Input.is_action_pressed(directions[0]):
			direction.y += Constants.DIRECTION.DOWN
		if Input.is_action_pressed(directions[1]):
			direction.y += Constants.DIRECTION.UP
	if Input.is_action_pressed(directions[2]) and Input.is_action_pressed(directions[3]):
		direction.x = Constants.DEFAULT_DIRECTION.x if previous.x == 0 \
		else -previous.x if previous_valid.x \
		else previous.x
	else:
		if Input.is_action_pressed(directions[2]):
			direction.x += Constants.DIRECTION.LEFT
		if Input.is_action_pressed(directions[3]):
			direction.x += Constants.DIRECTION.RIGHT
	previous = direction
	return direction

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
