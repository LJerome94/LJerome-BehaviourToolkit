extends FSMState


## Executes after the state is entered.
func _on_enter(_fsm: FiniteStateMachine,actor: Node, _blackboard: Blackboard):
	actor.animation_player.play("RESET")
	actor.animation_player.play("walking")


## Executes every _process call, if the state is active.
func _on_update(_delta: float, _fsm: FiniteStateMachine,_actor: Node, _blackboard: Blackboard):
	pass


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard):
	pass
