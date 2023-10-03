extends Node

class_name FrameTimer

signal timeout

export(bool) var is_waiting: bool = false
export(int) var duration: int = false

onready var remaining: int = 0
onready var count: int = 0

func _ready():
	set_physics_process(false)

func _physics_process(_delta):
	count += 1
	if count == duration:
		emit_signal("timeout")
		count = 0
		set_physics_process(false)

func set_timer(time: int):
	if is_waiting and is_physics_processing():
		return
	if time > 0:
		duration = time
	count = 0
	set_physics_process(true)

func is_playing():
	return is_physics_processing() and count < duration
