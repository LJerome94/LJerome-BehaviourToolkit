extends FSMTransition


# Evaluates true, if the transition conditions are met.
func is_valid(actor, _blackboard: Blackboard):
	# Cast actor
	actor = actor as CharacterBody2D
	
	if actor.movement_direction != Vector2.ZERO:
		return true
	return false
