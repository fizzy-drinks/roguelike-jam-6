extends Node2D
class_name Damageable


signal hp_depleted


@export var max_hp: float = 5


@onready var label = load("res://labels/damage_label.tscn")


var hp: float = max_hp
var last_hit: Node2D


func _ready():
	hp = max_hp


func damage(value: float, from: Node2D):
	print(self, " taking ", value, " damage")
	var t: RichTextLabel = label.instantiate()
	get_tree().current_scene.add_child(t)
	t.clear()
	t.add_text(str(value))
	t.global_position = global_position
	hp -= value
	last_hit = from


func _process(_delta):
	if hp <= 0:
		hp_depleted.emit()
		on_hp_depleted()


func on_hp_depleted():
	queue_free()
