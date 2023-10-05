extends "res://damageable.gd"
class_name Structure


@export var team: String


@onready var spawners = $spawners


func _ready():
	super()
	var children = spawners.get_children()
	for spawner in children:
		setup_spawner(spawner)


func _on_area_2d_area_entered(area: Area2D):
	if "team" in area.owner and area.owner.is_in_group("unit") and area.owner.team != team:
		area.owner.damage(100)


func _on_spawners_child_entered_tree(node):
	setup_spawner(node)


func setup_spawner(spawner: Node2D):
	spawner.source_structure = self
	spawner.team = team
