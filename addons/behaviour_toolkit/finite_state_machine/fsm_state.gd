@tool
@icon("res://addons/behaviour_toolkit/icons/FSMState.svg")
class_name FSMState extends Node
## A state in a [FiniteStateMachine]. This is the base class for all states.
##
## It's a basic building block to build full State Machines, only one state
## held by [FiniteStateMachine] is active, to switch to a different state,
## a [FSMTransition] must be triggered or you can use FSM methods to switch
## states manually.
## To implement your logic you can override the [code]_on_enter, _on_update and
## _on_exit[/code] methods when extending the node's script.


## List of transitions from this state.
var transitions: Array[FSMTransition] = []


func _ready() -> void:
	# Don't run in editor
	if Engine.is_editor_hint():
		return

	for transition in get_children():
		if transition is FSMTransition:
			transitions.append(transition)


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	pass


## Executes every process call, if the state is active.
func _on_update(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	pass


## Checks for valid transitions.
func _has_valid_transitions(_actor: Node, _blackboard: Blackboard, _event: StringName) -> FSMTransition:
	for transition in transitions:
		if transition.is_valid(_actor, _blackboard) or transition.is_valid_event(_event):
			return transition
	return null
	

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	var parent: Node = get_parent()
	if not parent is FiniteStateMachine:
		warnings.append("FSMState should be a child of a FiniteStateMachine node.")

	return warnings
