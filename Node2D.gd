extends Node2D


var TILE_SIZE = 16


var sea_noise = FastNoiseLite.new()
var terrain_noise = FastNoiseLite.new()
var tiles: Dictionary = {}
var time: float = 0
var sea_level = 0.55


@onready var tile_scene = load("res://tile.tscn")


func _ready():
	sea_noise.noise_type = 5
	sea_noise.frequency = 0.08
	
	terrain_noise.noise_type = 3
	terrain_noise.frequency = 0.1
	
	refresh_seed()


func _process(delta):
	if Input.is_action_pressed("ui_up"):
		sea_level += 0.01
		
	if Input.is_action_pressed("ui_down"):
		sea_level -= 0.01

	if Input.is_action_just_pressed("ui_accept"):
		refresh_seed()
	
	var mouse_pos = get_global_mouse_position()
	time += delta
	sea_noise.offset = Vector3.ONE * time

	var size = (get_viewport_rect().size / TILE_SIZE).ceil()
	for x in range(0, size.x):
		for y in range(0, size.y):
			var tile_coords = Vector2(x, y)
			
			var terrain_value = (terrain_noise.get_noise_2dv(tile_coords) + 1) / 2
			if terrain_value >= sea_level:
				var v = (terrain_value - sea_level) * 2
				var green = 0.2 + v * 0.6
				var red = v * green
				var color = Color(red, green, 0)
				generate_or_update_tile(tile_coords, color)
			else:
				var sea_value = (sea_noise.get_noise_2dv(tile_coords) + 1) / 2
				var color = Color(sea_value * 1.0, sea_value * 1.0, 1, 1)
				generate_or_update_tile(tile_coords, color)


func generate_or_update_tile(tile_coords: Vector2, color: Color):
	if tile_coords.x not in tiles:
		tiles[tile_coords.x] = {}

	if tile_coords.y in tiles[tile_coords.x]:
		tiles[tile_coords.x][tile_coords.y].modulate = color
	else:
		var tile: Sprite2D = tile_scene.instantiate()
		tile.modulate = color
		add_child(tile)
		tile.global_position = tile_coords * TILE_SIZE + Vector2.ONE * (TILE_SIZE / 2)
		tile.scale = Vector2.ONE * TILE_SIZE
		
		tiles[tile_coords.x][tile_coords.y] = tile
	
	
func refresh_seed():
	sea_noise.seed = Time.get_unix_time_from_system()
	terrain_noise.seed = Time.get_unix_time_from_system()
