extends Node2D


enum SpawnerShopUnits {
	GUARD,
	SOLDIER,
}


@onready var upgrade_menu: Control = $upgrade_menu
@onready var dungeon: Structure = $dungeon


func _unhandled_input(ev: InputEvent):
	if ev is InputEventMouseButton and ev.is_pressed():
		var is_within_sprite = (get_global_mouse_position() - global_position).length() < Global.TILE_SIZE
		upgrade_menu.visible = ev.button_index == MouseButton.MOUSE_BUTTON_RIGHT and is_within_sprite


func _on_spawner_shop_item_selected(index: int):
	var unit: Resource
	if index == SpawnerShopUnits.GUARD:
		unit = load('res://units/guard.tscn')
	elif index == SpawnerShopUnits.SOLDIER:
		unit = load('res://units/soldier.tscn')
	else:
		print("Spawn unit index not implemented: %s" % index)
		return

	var spawner: Spawner = load('res://structures/spawners/spawner.tscn').instantiate()
	spawner.unit = unit
	spawner.source_structure = dungeon
	spawner.team = 'player'
	dungeon.spawners.add_child(spawner)
