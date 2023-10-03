extends Node

class_name FrameTimer

signal timeout

onready var remaining: int = 0
onready var count: int = 0

func _ready():
	set_physics_process(false)

func _physics_process(_delta):
	count += 1
	if count == remaining:
		emit_signal("timeout")
		count = 0
		set_physics_process(false)

func set_timer(time: int):
	#if is_physics_processing() or time <= 0:
	#	return
	count = 0
	remaining = time
	set_physics_process(true)
