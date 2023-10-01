extends Node2D
class_name World


const TILE_SIZE = 32
const STRUCTURE_MAX_GEN_CHANCE = 0.05
const STRUCTURE_TYPES_WEIGHTED = {
	0.75: preload("res://dungeon.tscn"),
	1: preload("res://village.tscn")
}


var structure_noise = FastNoiseLite.new()
var terrain_noise = FastNoiseLite.new()
var tiles = {}
var structures = {}
var time: float = 0


@onready var tile_scene = load("res://tile.tscn")
@onready var terrain = $terrain


func _ready():
	terrain_noise.noise_type = 3
	terrain_noise.frequency = 0.07
	
	structure_noise.noise_type = 3
	structure_noise.frequency = 1
	structure_noise.domain_warp_frequency = 0.5

	generate_tiles(Vector2(-10, -10), Vector2(10, 10))


func generate_tiles(start: Vector2, end: Vector2):
	for x in range(start.x, end.x):
		for y in range(start.y, end.y):
			generate_or_update_tile(x, y)
			generate_structures(x, y)


func get_terrain_value(x: int, y: int):
	var tile_value = terrain_noise.get_noise_2d(x, y)
	return (tile_value + 1) / 2


func get_structure_value(x: int, y: int):
	var tile_value = structure_noise.get_noise_2d(x, y)
	return (tile_value + 1) / 2


func generate_or_update_tile(x: int, y: int):
	var terrain_value = get_terrain_value(x, y)
	var green = 0.2 + terrain_value * 0.6
	var red = terrain_value * green
	var color = Color(red, green, 0)

	if x not in tiles:
		tiles[x] = {}

	if y in tiles[x]:
		tiles[x][y].modulate = color
		return
	
	var tile: Sprite2D = tile_scene.instantiate()
	tile.modulate = color
	terrain.add_child(tile)
	tile.global_position = Vector2(x, y) * TILE_SIZE
	tile.scale = Vector2.ONE * TILE_SIZE
	
	tiles[x][y] = tile
	
	
func generate_structures(x: int, y: int):
	if x == 0 and y == 0:
		return
	
	var structure_value = get_structure_value(x, y)
	
	if randf() >= structure_value * STRUCTURE_MAX_GEN_CHANCE:
		return

	var structure_type = randf()
	var structure: Dungeon
	for chance in STRUCTURE_TYPES_WEIGHTED.keys():
		if structure_type < chance:
			structure = STRUCTURE_TYPES_WEIGHTED[chance].instantiate()
			break

	if not structure:
		return

	add_child(structure)
	structure.global_position = Vector2(x, y) * TILE_SIZE
	structure.world = self
	
	if x not in structures:
		structures[x] = {}
		
	if y not in structures[x]:
		structures[x][y] = structure
