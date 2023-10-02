extends "res://units/unit.gd"


var target: Node2D


func _process(delta):
	super(delta)
	attack_cooldown -= delta
	
	if not weakref(target).get_ref():
		pick_target()


func _physics_process(delta):
	super(delta)

	var colliding = false
	for collision in collisions:
		if not collision.is_in_group("solid"):
			continue
		
		colliding = true
		if collision.owner.team != team and attack_cooldown <= 0:
			attack_unit(collision.owner)

	if weakref(target).get_ref() and not colliding:
		walk_toward(target.global_position, delta)


func pick_target():
	var targets = get_tree().get_nodes_in_group("targetable")
	
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
