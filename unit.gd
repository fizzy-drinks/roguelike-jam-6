extends "res://damageable.gd"
class_name Unit


@export var team: String
@export var source_structure: Node2D
@export var world: World
@export var max_ms: float
@export var min_ms: float
@export var dps: float


@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $Area2D


var target: Node2D
var collision: Area2D
var attack_cooldown: float = 0


func _ready():
	sprite.modulate = source_structure.get_node("tile").modulate
	
	
func _process(delta):
	super(delta)
	attack_cooldown -= delta
	
	if collision:
		var dir = (collision.global_position - global_position).normalized()
		if dir == Vector2.ZERO:
			global_position += Vector2.DOWN
			return
			
		global_position -= dir
	
	if not weakref(target).get_ref():
		pick_target()
		return


func _physics_process(delta):
	if weakref(target).get_ref():
		var target_delta = target.global_position - global_position
		
		var tile_size = world.TILE_SIZE
		var terrain_value = world.get_terrain_value(round(global_position.x / tile_size), round(global_position.y / tile_size))
		var ms_multiplier = min_ms + ((max_ms - min_ms) * terrain_value)
		global_position += target_delta.normalized() * ms_multiplier * delta


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
	
	
func attack_unit(unit: Damageable):
	attack_cooldown = 1
	unit.damage(dps)


func _on_area_2d_area_entered(area: Area2D):
	collision = area
	
	if not area.owner.team == team and attack_cooldown <= 0:
		attack_unit(area.owner)


func _on_area_2d_area_exited(area):
	collision = null
