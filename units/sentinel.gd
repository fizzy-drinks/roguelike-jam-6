extends "res://units/unit.gd"
class_name Sentinel


var walk_target: Vector2
var walk_target_interest: float = 5


@onready var guard_area: Area2D = source_structure.get_node("guard_range")


func _physics_process(delta):
	super(delta)

	if not walk_target or walk_target_interest <= 0:
		pick_walk_target()

	if walk_target and not colliding:
		walk_target_interest -= delta
		walk_toward(walk_target, delta)


func pick_walk_target():
	if not weakref(guard_area).get_ref():
		print('no guard area!')
		return
		
	var area: CollisionShape2D = guard_area.get_node("shape")
	var shape: CircleShape2D = area.shape
	var c: Vector2 = area.global_position
	walk_target = Vector2(
		randf_range(c.x - shape.radius, c.x + shape.radius),
		randf_range(c.y - shape.radius, c.y + shape.radius),
	)
	walk_target_interest = 5
