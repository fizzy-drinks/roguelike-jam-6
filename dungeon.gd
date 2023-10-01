extends "res://damageable.gd"
class_name Dungeon


@export var team: String
@export var units_per_second: float = 0.5
@export var world: Node2D


@onready var spawner = [
	load("res://soldier.tscn"),
	load("res://guard.tscn")
]
@onready var spawn_cooldown: float = 0


func _process(delta):
	super(delta)
	spawn_cooldown -= delta
	if spawn_cooldown <= 0:
		spawn()


func spawn():
	var new_unit: Unit = spawner.pick_random().instantiate()
	new_unit.position = position + Vector2(randi_range(-1, 1), randi_range(-1, 1))
	new_unit.source_structure = self
	new_unit.team = team
	new_unit.world = world
	world.add_child(new_unit)
	spawn_cooldown = 1 / units_per_second


func _on_area_2d_area_entered(area):
	if area.owner is Unit and area.owner.team != team:
		area.owner.damage(100)
