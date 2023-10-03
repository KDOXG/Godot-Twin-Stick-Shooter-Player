extends Position2D

export(PackedScene) var projectile_scene: PackedScene

onready var player: Player = get_parent()
onready var main_scene: Stage = GroupManager.get_single_node("stage")

func shoot(delta: float):
	var direction = InputManager.get_attack_vector()
	var projectile = projectile_scene.instance()
	projectile.global_position = $Left.global_position if player.facing_left else $Right.global_position
	projectile.linear_velocity = Constants.normalize_pixel_per_frame(direction * 2, delta)
	main_scene.add_child(projectile)
