extends "res://units/unit.gd"
class_name Guard


var targets: Array[Unit]
var walk_target: Vector2
var walk_target_interest: float = 5


@onready var guard_area: Area2D = source_structure.get_node("guard_range")


func _ready():
	super()
	
	guard_area.area_entered.connect(target_enemies)


func _process(delta):
	super(delta)

	if not walk_target:
		pick_walk_target()


func _physics_process(delta):
	super(delta)

	for collision in collisions:
		if not collision.owner.is_in_group("targetable"):
			continue

		if collision.owner.team != team and attack_cooldown <= 0:
			attack_unit(collision.owner)
	
	for target in targets:
		if weakref(target).get_ref() and not colliding:
			walk_toward(target.position, delta)
			return

	if walk_target_interest <= 0:
		pick_walk_target()

	if walk_target and not colliding:
		walk_target_interest -= delta
		
		walk_toward(walk_target, delta)


func pick_walk_target():
	if not weakref(guard_area).get_ref():
		return
		
	var area: CollisionShape2D = guard_area.get_node("shape")
	var shape: CircleShape2D = area.shape
	var c: Vector2 = area.global_position
	walk_target = Vector2(
		randf_range(c.x - shape.radius, c.x + shape.radius),
		randf_range(c.y - shape.radius, c.y + shape.radius),
	)
	walk_target_interest = 5
	

func target_enemies(area: Area2D):
	if area.owner is Unit and area.owner.team != team:
		targets.append(area.owner)
		
		
func on_team_changed():
	super()
	
	pick_walk_target()
	targets = targets.filter(func (t): return weakref(t).get_ref() and t.team != team)
