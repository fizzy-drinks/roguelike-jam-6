extends Node


const TILE_SIZE = 32
const STRUCTURE_MAX_GEN_CHANCE = 0.025


var terrain_noise = FastNoiseLite.new()


func setup():
	terrain_noise.noise_type = 3
	terrain_noise.frequency = 0.07


func get_terrain_value(x: int, y: int):
	var tile_value = terrain_noise.get_noise_2d(x, y)
	return (tile_value + 1) / 2
