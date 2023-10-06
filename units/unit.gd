extends "res://damageable.gd"
class_name Unit


@export var team: String
@export var source_structure: Node2D
@export var max_ms: float
@export var min_ms: float
@export var dps: float


@onready var sprite: Sprite2D = $Sprite2D
@onready var job_indicator: Sprite2D = $job_indicator
@onready var hitbox: Area2D = $Area2D


var collisions: Array[Area2D]
var attack_cooldown: float = 0
var colliding = false


func _ready():
	super()
	sprite.modulate = source_structure.modulate
	
	
func _physics_process(delta):
	colliding = false
	for collision in collisions:
		if not collision.owner.is_in_group("solid") or collision.owner.team == team:
			continue

		colliding = true

		var dir = (collision.global_position - global_position).normalized()
		if dir == Vector2.ZERO:
			global_position += Vector2.DOWN
			return
			
		global_position -= dir
		
	attack_cooldown -= delta


func _on_area_2d_area_entered(area: Area2D):
	collisions.append(area)


func _on_area_2d_area_exited(area):
	collisions.remove_at(collisions.find(area))


func walk_toward(point: Vector2, delta: float):
	var walk_target_delta = point - global_position

	var tile_size = Global.TILE_SIZE
	var terrain_value = Global.get_terrain_value(round(global_position.x / tile_size), round(global_position.y / tile_size))
	var ms_multiplier = min_ms + ((max_ms - min_ms) * terrain_value)
	var movement = walk_target_delta.normalized() * ms_multiplier * delta
	
	if walk_target_delta.length() >= movement.length():
		global_position += movement
	
	
func attack_unit(unit: Damageable):
	attack_cooldown = 1
	unit.damage(dps, self)
