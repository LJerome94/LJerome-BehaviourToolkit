extends FSMTransition


# Evaluates true, if the transition conditions are met.
func is_valid(_actor, _blackboard: Blackboard):
	if Input.is_action_pressed("action_sprint"):
		return true
	else:
		return false
