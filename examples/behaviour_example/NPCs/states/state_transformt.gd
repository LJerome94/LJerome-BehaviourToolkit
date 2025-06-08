extends FSMState


## Executes after the state is entered.
func _on_enter(_fsm: FiniteStateMachine, actor: Node, _blackboard: Blackboard):
	# Make Transparent
	actor.set_modulate(Color(1, 1, 1, 0.5))
	actor.ghost_state_machine.fire_event("fully_transformed")


## Executes every _process call, if the state is active.
func _on_update(_delta: float, _fsm: FiniteStateMachine,_actor: Node, _blackboard: Blackboard):
	pass


## Executes before the state is exited.
func _on_exit(_fsm: FiniteStateMachine, _actor: Node, _blackboard: Blackboard):
	pass
