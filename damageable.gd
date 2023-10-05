extends Node2D
class_name Damageable


@export var max_hp: float = 5


@onready var label = load("res://labels/damage_label.tscn")


var hp: float = max_hp


func _ready():
	hp = max_hp


func damage(value: float):
	print(self, " taking ", value, " damage")
	var t: RichTextLabel = label.instantiate()
	get_tree().current_scene.add_child(t)
	t.clear()
	t.add_text(str(value))
	t.global_position = global_position
	hp -= value


func _process(_delta):
	if hp <= 0:
		queue_free()
