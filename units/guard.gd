extends "res://units/sentinel.gd"
class_name Guard


var targets: Array[Unit]


func _ready():
	super()
	
	guard_area.area_entered.connect(target_enemies)


func _physics_process(delta):
	super(delta)

	for collision in collisions:
		if not collision.owner.is_in_group("targetable"):
			continue

		if collision.owner.team != team and attack_cooldown <= 0:
			attack_unit(collision.owner)
			break
	
	for target in targets:
		if weakref(target).get_ref() and not colliding:
			walk_toward(target.position, delta)
			break


func target_enemies(area: Area2D):
	if area.owner is Unit and area.owner.team != team:
		targets.append(area.owner)


func on_team_changed():
	super()
	
	pick_walk_target()
	targets = targets.filter(func (t): return weakref(t).get_ref() and t.team != team)
