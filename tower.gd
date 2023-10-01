extends Node2D


@export var world: World


@onready var dungeon: Dungeon = $dungeon


func _ready():
	dungeon.world = world
