extends FSMState


# Executes after the state is entered.
func _on_enter(_fsm, actor, _blackboard: Blackboard):
	# Cast actor
	actor = actor as CharacterBody2D

	actor.animation_player.play("idle")


# Executes every _process call, if the state is active.
func _on_update(_delta, _fsm, _actor, _blackboard: Blackboard):
	pass


# Executes before the state is exited.
func _on_exit(_fsm: FiniteStateMachine, _actor, _blackboard: Blackboard):
	pass
