extends Node2D


@export var world: Node2D


@onready var dungeon: Node2D = $dungeon


func _ready():
	dungeon.world = world
