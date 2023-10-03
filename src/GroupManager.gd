extends Node

onready var tree: SceneTree = get_tree()

func get_single_node(group_name: String) -> Node:
	if not tree.has_group(group_name):
		return null
	return tree.get_nodes_in_group(group_name)[0]

func get_all_nodes(group_name: String) -> Array:
	if not tree.has_group(group_name):
		return []
	return tree.get_nodes_in_group(group_name)
