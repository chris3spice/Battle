extends Resource
class_name Chaomon

enum Types { NORMAL, FIRE, WOOD, METAL, EARTH, WATER }

@export var is_player : bool
@export var chaomon_texture : Texture
@export var chaomon_name : String
@export var chaomon_type : Types
@export var base_speed : int
@export var action_list : Array = [Action]

#HP
@export var max_health : int
@export var current_health : int

#Other Stuff
@export var acv : int
@export var dcv : int

#Affinities
var normal_affinity = 10
var fire_affinity = 10
var wood_affinity = 10
var metal_affinity = 10
var earth_affinity = 10
var water_affinity = 10
#Defects
var normal_defect = 10
var fire_defect = 10
var wood_defect = 10
var metal_defect = 10
var earth_defect = 10
var water_defect = 10

func _take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		pass
		
