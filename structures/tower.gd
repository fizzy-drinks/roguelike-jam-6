extends Node2D


const SpawnerShopUnits = {
	0: {
		"name": "guard",
		"path": 'res://units/guard.tscn'
	},
	1: {
		"name": "soldier",
		"path": 'res://units/soldier.tscn'
	}
}


@onready var upgrade_menu: Control = $upgrade_menu
@onready var spawner_shop: OptionButton = $upgrade_menu/spawner_shop/select
@onready var spawner_list: OptionButton = $upgrade_menu/spawner_list/select
@onready var dungeon: Structure = $dungeon


func _ready():
	update_spawner_list()


func _unhandled_input(ev: InputEvent):
	if not (ev is InputEventMouseButton) or not ev.is_pressed():
		return

	var is_within_sprite = (get_global_mouse_position() - global_position).length() < Global.TILE_SIZE
	upgrade_menu.visible = ev.button_index == MouseButton.MOUSE_BUTTON_RIGHT and is_within_sprite


func _on_spawner_shop_item_selected(index: int):
	spawner_shop.select(-1)
	close_menu()

	if index not in SpawnerShopUnits:
		print("Spawn unit index not implemented: %s" % index)
		return

	var selection = SpawnerShopUnits[index]
	var unit: Resource = load(selection.path)
	var unit_type: String = selection.name

	var spawner: Spawner = load('res://structures/spawners/spawner.tscn').instantiate()
	spawner.unit = unit
	spawner.unit_type = unit_type
	spawner.source_structure = dungeon
	dungeon.spawners.add_child(spawner)
	update_spawner_list()


func _on_sell_item_selected(index):
	close_menu()
	var item = dungeon.spawners.get_child(index)
	dungeon.spawners.remove_child(item)
	item.queue_free()
	update_spawner_list()


func update_spawner_list():
	spawner_list.clear()
	for spawner in dungeon.spawners.get_children():
		if spawner.unit_type == 'guard':
			spawner_list.add_item('Guard')
		elif spawner.unit_type == 'soldier':
			spawner_list.add_item('Soldier')
	spawner_list.select(-1)


func close_menu():
	upgrade_menu.visible = false
