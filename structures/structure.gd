extends "res://damageable.gd"
class_name Structure


signal team_changed


@export var team: String


@onready var spawners = $spawners


func _ready():
	super()
	var children = spawners.get_children()
	for spawner in children:
		setup_spawner(spawner)


func _on_area_2d_area_entered(area: Area2D):
	if "team" in area.owner and area.owner.is_in_group("unit") and area.owner.team != team:
		area.owner.damage(100, self)


func _on_spawners_child_entered_tree(node):
	setup_spawner(node)


func setup_spawner(spawner: Node2D):
	spawner.source_structure = self
	
	
func on_hp_depleted():
	hp = max_hp
	team = last_hit.team
	print(self, " changed teams! It is now ", team)
	modulate = last_hit.source_structure.modulate
	team_changed.emit()
