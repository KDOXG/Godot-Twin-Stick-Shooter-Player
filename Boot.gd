extends Node


func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	get_tree().call("change_scene", "res://Stages/Stage0.tscn")
