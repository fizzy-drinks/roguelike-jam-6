extends Node2D
class_name Spawner


@export var unit: Resource
@export var unit_type: String
@export var spawn_rate: float = 5
@export var source_structure: Node2D


var spawn_cooldown: float = 0


func _process(delta):
	spawn_cooldown -= delta
	if unit and spawn_cooldown <= 0:
		print('spawning for team ', source_structure.team)
		spawn()


func spawn():
	var new_unit: Node2D = unit.instantiate()
	new_unit.global_position = global_position + Vector2(randi_range(-1, 1), randi_range(-1, 1))
	new_unit.source_structure = source_structure
	get_tree().get_root().add_child(new_unit)
	spawn_cooldown = spawn_rate
