@tool
@icon("res://addons/behaviour_toolkit/icons/FSMCompoundState.svg")
class_name FSMCompoundState extends FSMState


## The list of states in the Compound State.
var states: Array[FSMState]
## The current active state.
var active_state: FSMState
## The list of current events.
var current_events: Array[String]


## The initial state of the Compound State.
@export var initial_state: FSMState:
	set(value):
		initial_state = value
		update_configuration_warnings()


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	# Get all the states
	for state in get_children():
		if state is FSMState:
			states.append(state)

	#if verbose: BehaviourToolkit.Logger.say("Setting up " + str(states.size()) + " states.", self)

	#active = true

	# Set the initial state
	active_state = initial_state
	active_state._on_enter(_actor, _blackboard)

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


func _process_code(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	# The current event
	var event: StringName = ""

	# Check if there are events
	if current_events.size() > 0:
		# Get the first event
		event = current_events[0]
		# Remove the event from the list
		current_events.remove_at(0)

	# Check if the current state is valid
	var transition = active_state._has_valid_transitions(_actor, _blackboard, event)
	
	if transition is FSMTransition:
		# Process the transition
		transition._on_transition(_delta, _actor, _blackboard)
		
		# Change the current state
		change_state(transition.next_state, _actor, _blackboard)
	
	active_state._on_update(_delta, _actor, _blackboard)


## Changes the current state and calls the appropriate methods like _on_exit and _on_enter.
func change_state(state: FSMState, _actor: Node, _blackboard: Blackboard) -> void:
	# Exit the current state
	active_state._on_exit(_actor, _blackboard)

	# Change the current state
	active_state = state

	# Enter the new state
	active_state._on_enter(_actor, _blackboard)

	#if verbose: BehaviourToolkit.Logger.say("Changed state to " + active_state.get_name(), self)

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


## Fires an event in the compound state.
func fire_event(_event: StringName):
	current_events.append(_event)
	
	if active_state is FSMCompoundState:
		active_state.fire_event(_event)

	#if verbose: BehaviourToolkit.Logger.say("Fired event: " + event, self)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = super()

	if not initial_state:
		warnings.append("Initial state is not set.")
	
	var children: Array = get_children()

	if children.size() == 0:
		warnings.append("No states found.")

	for child in children:
		if child is not FSMState and child is not FSMTransition:
			warnings.append("Node '" + child.get_name() + "' is not a FSMState or FSMTransition.")

	return warnings
