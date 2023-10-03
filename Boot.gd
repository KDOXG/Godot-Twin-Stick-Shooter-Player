extends Node

func _physics_process(_delta):
	get_tree().call("change_scene", "res://Stages/Stage0.tscn")
