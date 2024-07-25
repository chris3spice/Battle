extends RefCounted
class_name Formulas

func calculate_base_damage(battler, opponent, action):
	var damage = (battler.acv + action.action_power) - (opponent.dcv)
	return damage
