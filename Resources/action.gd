extends Resource
class_name Action

enum Types { NORMAL, FIRE, WOOD, METAL, EARTH, WATER }

@export var action_icon : Texture
@export var action_name : String
@export var action_type : Types
@export var action_power : int
@export var action_fatigue : float
