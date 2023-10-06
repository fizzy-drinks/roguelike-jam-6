extends "res://units/unit.gd"
class_name Soldier


var target: Node2D


func _process(delta):
	super(delta)
	
	if not weakref(target).get_ref() or target.team == team:
		pick_target()


func _physics_process(delta):
	super(delta)

	for collision in collisions:
		if not collision.owner.is_in_group("targetable"):
			continue
		
		if collision.owner.team != team and attack_cooldown <= 0:
			attack_unit(collision.owner)

	if weakref(target).get_ref() and not colliding:
		walk_toward(target.global_position, delta)


func pick_target():
	var targets = get_tree().get_nodes_in_group("structures")
	
	var nearest: Node2D
	for t in targets:
		if t.team == team:
			continue
			
		if not nearest:
			nearest = t
			continue

		if t.global_position.distance_to(global_position) < nearest.global_position.distance_to(global_position):
			nearest = t
	
	target = nearest
		
		
func on_team_changed():
	super()
	
	pick_target()
