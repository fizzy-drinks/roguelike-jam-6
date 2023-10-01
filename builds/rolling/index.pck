GDPC                P	                                                                         X   res://.godot/exported/133200997/export-49bb12de931c4d61741b6c3a500a45fe-damage_label.scn�      �      ~X�٨zc&4�퐧i?    T   res://.godot/exported/133200997/export-5c09e85635f813d46991c6ac84e0b372-village.scn �-      �       >^�iQI����1wK�    T   res://.godot/exported/133200997/export-76e0adcbc83681695885bae615f516ae-world.scn   �:      G      -<h���6ګ�����    T   res://.godot/exported/133200997/export-881a8a99042672016260a1f24326859a-dungeon.scn        �      )xN�*������<    P   res://.godot/exported/133200997/export-b20e5b9a6a36c90835598587a6632344-unit.scn�(            ��B��n�@��]xC    P   res://.godot/exported/133200997/export-dfbaa3b728ad779f93c7149c2a9a8326-tile.scn�      �      ��+��&���z�.��al    T   res://.godot/exported/133200997/export-fe48af1464cf80c485166bfee9afe484-tower.scn   P      :      ˵C�֊��C/9�S    ,   res://.godot/global_script_class_cache.cfg  A      �      ���ۓ�a��;S�·    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�      �      �̛�*$q�*�́     H   res://.godot/imported/white.png-d8533361663a5f8fe5200e5b5262a62d.ctex   �0      ^       ��@ԫ4��5��       res://.godot/uid_cache.bin  �F      �      J���#�R�c��GҲ        res://damage_label.tscn.remap    >      i       p���.o#?;.�?O       res://damageable.gd         �      b���ГX�<[	h0�       res://dungeon.gd@      �      c(ȋ��"�U��@�>       res://dungeon.tscn.remapp>      d       b"�}�:� sƼ_4�       res://icon.svg  �B      �      C��=U���^Qu��U3       res://icon.svg.import   �      �       c�ǆ�v�|P�	_ZI       res://project.binary`I      �      �O�&yې0&i�b��%       res://selfdestruct.gd          s       ������r�7�5���       res://tile.tscn.remap   �>      a       &��  ����EA�$�       res://tower.gd  �      }       ��>�o.�=b;)	�,�       res://tower.tscn.remap  P?      b       i1X�ĿRLH�       res://unit.gd   �!      
      KHt��`���418U-n�       res://unit.tscn.remap   �?      a       ��?臆*�=��P��/       res://village.tscn.remap0@      d       �7���U��p�p�)       res://white.png.import  1      �       �Jkz.	��`<�j����       res://world.gd  �1      �      ���c�Ɯ�jy��=~�       res://world.tscn.remap  �@      b       �t�׵B�}��6�x    extends Node2D
class_name Damageable


@export var max_hp: float = 5


@onready var label = load("res://damage_label.tscn")


var hp: float = max_hp


func _ready():
	hp = max_hp


func damage(value: float):
	var t: RichTextLabel = label.instantiate()
	get_tree().current_scene.add_child(t)
	t.clear()
	t.add_text(str(value))
	t.global_position = global_position
	hp -= value


func _process(_delta):
	if hp <= 0:
		queue_free()
߇�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://selfdestruct.gd ��������      local://PackedScene_2w6ni          PackedScene          	         names "   	      damage_label    offset_right    offset_bottom $   theme_override_colors/default_color +   theme_override_font_sizes/normal_font_size    text    autowrap_mode    script    RichTextLabel    	   variants            4B     �A   ��O?          �?            5                        node_count             nodes        ��������       ����                                                        conn_count              conns               node_paths              editable_instances              version             RSRC^�J�bjmT��k�;�Nextends "res://damageable.gd"
class_name Dungeon


@export var team: String
@export var units_per_second: float = 0.5
@export var world: Node2D


@onready var spawner = load("res://unit.tscn")
@onready var spawn_cooldown: float = 0


func _process(delta):
	super(delta)
	spawn_cooldown -= delta
	if spawn_cooldown <= 0:
		spawn()


func spawn():
	var new_unit: Unit = spawner.instantiate()
	new_unit.position = position + Vector2(randi_range(-1, 1), randi_range(-1, 1))
	new_unit.source_structure = self
	new_unit.team = team
	new_unit.world = world
	world.add_child(new_unit)
	spawn_cooldown = 1 / units_per_second


func _on_area_2d_area_entered(area):
	if area.owner is Unit and area.owner.team != team:
		area.owner.damage(100)
R��pRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://dungeon.gd ��������   PackedScene    res://tile.tscn � "��H      local://CircleShape2D_srhj0 ~         local://PackedScene_cr4cb �         CircleShape2D          ı�A         PackedScene          	         names "         dungeon 	   modulate    script    team    max_hp    structures    targetable    Node2D    tile 	   position    scale    Area2D    CollisionShape2D    shape    _on_area_2d_area_entered    area_entered    	   variants          ���>��x>��`=  �?                enemy      �B         
           
      B   B                node_count             nodes     ,   ��������       ����                                             ���         	      
                        ����                     ����                   conn_count             conns                                      node_paths              editable_instances              version             RSRC.��{n�"r`GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ D2L)���#�E[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dfylyebhig7x8"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 ӎZ�-��B�>Oextends Node2D


@export var world: World


@onready var dungeon: Dungeon = $dungeon


func _ready():
	dungeon.world = world
��extends RichTextLabel


var time: float = 1


func _process(delta):
	time -= delta
	
	if time <= 0:
		queue_free()
 L��S�]pÛRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script    
   Texture2D    res://white.png  c�M��,      local://PackedScene_ibm3o 
         PackedScene          	         names "         tile 	   position    scale    texture 	   Sprite2D    	   variants       
     B   B
     �B  �B                node_count             nodes        ��������       ����                                conn_count              conns               node_paths              editable_instances              version             RSRC��RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://tower.gd ��������   PackedScene    res://dungeon.tscn ���6�L       local://PackedScene_10e61 5         PackedScene          	         names "         tower    script    Node2D    dungeon 	   modulate    team    units_per_second    	   variants                             ��i?��?  �?  �?      player      �?      node_count             nodes        ��������       ����                      ���                                     conn_count              conns               node_paths              editable_instances              version             RSRC��dp��extends "res://damageable.gd"
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
	sprite.modulate = source_structure.modulate
	
	
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


func _on_area_2d_area_exited(_area):
	collision = null
���d#RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://unit.gd ��������
   Texture2D    res://white.png  c�M��,      local://CircleShape2D_m7jb6 y         local://PackedScene_8un8u �         CircleShape2D            �@         PackedScene          	         names "         unit 	   position    script    max_ms    min_ms    dps    max_hp    targetable    Node2D 	   Sprite2D    scale    texture    Area2D    CollisionShape2D    shape    _on_area_2d_area_entered    area_entered    _on_area_2d_area_exited    area_exited    	   variants    	   
     �A  �A               �A     �@     �@     �A
     �@  �@                         node_count             nodes     /   ��������       ����                                                      	   	   ����   
                              ����                     ����                   conn_count             conns                                                              node_paths              editable_instances              version             RSRC��uVB�3��My���RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://dungeon.tscn ���6�L       local://PackedScene_p4eav          PackedScene          
         names "         village 	   modulate    team    tile    Area2D    CollisionShape2D    	   variants                      �?  �?  �?  �?      independent       node_count             nodes        �����������    ����                         conn_count              conns               node_paths              editable_instances              base_scene              version             RSRCM��F�ϫGST2            ����                        &   RIFF   WEBPVP8L   /    ���������  [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bl2ifxi32qv5a"
path="res://.godot/imported/white.png-d8533361663a5f8fe5200e5b5262a62d.ctex"
metadata={
"vram_texture": false
}
 ��Qs�k?
u媑extends Node2D
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
U���<�uP�RSRC                    PackedScene            ��������                                                  ..    resource_local_to_scene    resource_name 	   _bundled    script       Script    res://world.gd ��������   PackedScene    res://tower.tscn �BR	O��Q      local://PackedScene_druoc :         PackedScene          	         names "         world    script    Node2D    terrain    tower    strucutres 	   Camera2D    	   variants                                          node_count             nodes     !   ��������       ����                            ����                ���            @                       ����              conn_count              conns               node_paths              editable_instances              version             RSRCH��ֹ��[remap]

path="res://.godot/exported/133200997/export-49bb12de931c4d61741b6c3a500a45fe-damage_label.scn"
�/@$�[remap]

path="res://.godot/exported/133200997/export-881a8a99042672016260a1f24326859a-dungeon.scn"
H�-���«Yy[remap]

path="res://.godot/exported/133200997/export-dfbaa3b728ad779f93c7149c2a9a8326-tile.scn"
a���en��{���[remap]

path="res://.godot/exported/133200997/export-fe48af1464cf80c485166bfee9afe484-tower.scn"
y���lM�m�^�g�{[remap]

path="res://.godot/exported/133200997/export-b20e5b9a6a36c90835598587a6632344-unit.scn"
b�AD�;�=����[remap]

path="res://.godot/exported/133200997/export-5c09e85635f813d46991c6ac84e0b372-village.scn"
�eR�j��'Z[remap]

path="res://.godot/exported/133200997/export-76e0adcbc83681695885bae615f516ae-world.scn"
���� ��>o�list=Array[Dictionary]([{
"base": &"Node2D",
"class": &"Damageable",
"icon": "",
"language": &"GDScript",
"path": "res://damageable.gd"
}, {
"base": &"Node2D",
"class": &"Dungeon",
"icon": "",
"language": &"GDScript",
"path": "res://dungeon.gd"
}, {
"base": &"Node2D",
"class": &"Unit",
"icon": "",
"language": &"GDScript",
"path": "res://unit.gd"
}, {
"base": &"Node2D",
"class": &"World",
"icon": "",
"language": &"GDScript",
"path": "res://world.gd"
}])
�?��A�Q<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
��%\E �   �F7��r�
.   res://builds/build1/index.apple-touch-icon.pngu@��U�P"   res://builds/build1/index.icon.png/^�K-
   res://builds/build1/index.png�q`�Y��$.   res://builds/build2/index.apple-touch-icon.png�ޱpO"   res://builds/build2/index.icon.png��n�ev	E   res://builds/build2/index.pngm^�Gܺ�)   res://damage_label.tscn���6�L    res://dungeon.tscn�_f(�h   res://icon.svg� "��H   res://tile.tscn�BR	O��Q   res://tower.tscn :ĕ�t   res://unit.tscn�$���=   res://village.tscn c�M��,   res://white.png��U���6   res://world.tscn��!�Ǘ�b"   res://builds/build3/index.icon.png��+��^#.   res://builds/build3/index.apple-touch-icon.png���Jv   res://builds/build3/index.png8�Lx��ECFG      application/config/name         roguelike-jam-6    application/run/main_scene         res://world.tscn   application/config/features(   "         4.1    GL Compatibility       application/config/icon         res://icon.svg  "   display/window/size/viewport_width         #   display/window/size/viewport_height            display/window/stretch/mode         viewport   display/window/stretch/aspect         expand     dotnet/project/assembly_name         roguelike-jam-6 #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility2   rendering/environment/defaults/default_clear_color      ���=���=���=  �?�