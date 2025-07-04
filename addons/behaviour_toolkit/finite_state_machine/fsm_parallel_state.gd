@tool
extends FSMState
class_name FSMParallelState

## The list of states in the Parallel State.
var states: Array[FSMState]


## Executes after the state is entered.
func _on_enter(_fsm: FiniteStateMachine, _actor: Node, _blackboard: Blackboard) -> void:
	# Get all the states
	for state in get_children():
		if state is FSMState:
			states.append(state)# DANGER Ceci est dangereux pour des doubles calls
			state._on_enter(_fsm, _actor, _blackboard)
	#if verbose: BehaviourToolkit.Logger.say("Setting up " + str(states.size()) + " states.", self)


func fire_event(event: StringName) -> void:
	for state in get_children():
		if state.has_method("fire_event"):
			state.fire_event(event)


## Executes every process call, if the state is active.
func _on_update(_delta: float, _fsm: FiniteStateMachine, _actor: Node, _blackboard: Blackboard) -> void:
	for state in states:
		state._on_update(_delta, _fsm, _actor, _blackboard)
