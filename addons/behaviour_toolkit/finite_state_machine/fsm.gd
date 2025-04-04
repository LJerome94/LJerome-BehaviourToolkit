@tool
@icon("res://addons/behaviour_toolkit/icons/FiniteStateMachine.svg")
class_name FiniteStateMachine extends BehaviourToolkit
## An implementation of a simple finite state machine.
##
## The Finite State Machine is composed of states and transitions.
## This is the class to handle all states and their transitions.
## On ready, all FSMTransition child nodes will be set up as transitions.
## To implement your logic you can override the [code]_on_enter, _on_update and
## _on_exit[/code] methods when extending the node's script.


const ERROR_INITIAL_STATE_NULL: String = "The initial cannot be null when starting the State Machine."


## The signal emitted when the state changes.
signal state_changed(state: FSMState)


## The initial state of the FSM.
@export var initial_state: FSMState:
	set(value):
		initial_state = value
		update_configuration_warnings()


## The list of states in the FSM.
var states: Array[FSMState]
## The current active state.
var active_state: FSMState
## The list of current events.
var current_events: Array[String]
## Current BT BTStatus
var current_bt_status: BTBehaviour.BTStatus


func _ready() -> void:
	# Don't run in editor
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
		return

	connect("state_changed", _on_state_changed)

	if blackboard == null:
		BehaviourToolkit.Logger.say("Creating new blackboard", self)
		blackboard = Blackboard.new()

	if autostart:
		start.call_deferred()
	else:
		active = false

	if not process_type:
		process_type = ProcessType.PHYSICS

	_setup_processing()


func start() -> void:
	if verbose: BehaviourToolkit.Logger.say("Starting FiniteStateMachine...", self)

	current_bt_status = BTBehaviour.BTStatus.RUNNING

	# Check if the initial state is valid
	assert(initial_state != null, ERROR_INITIAL_STATE_NULL)

	# Get all the states
	for state in get_children():
		if state is FSMState:
			states.append(state)

	if verbose: BehaviourToolkit.Logger.say("Setting up " + str(states.size()) + " states.", self)

	active = true

	# Set the initial state
	active_state = initial_state
	active_state._on_enter(actor, blackboard)

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


func _process_code(delta: float) -> void:
	if not active:
		return

	# Check if there are states
	if states.size() == 0:
		return

	# The current event
	var event: StringName = ""

	# Check if there are events
	if current_events.size() > 0:
		# Get the first event
		event = current_events[0]
		# Remove the event from the list
		current_events.remove_at(0)

	# Check if the current state is valid
	var transition = active_state._has_valid_transitions(actor, blackboard, event)

	if transition is FSMTransition:
		# Process the transition
		transition._on_transition(delta, actor, blackboard)

		# Change the current state
		change_state(transition.next_state)

	if active_state is FSMCompoundState:
		active_state._process_code(delta, actor, blackboard)

	# Process the current state
	active_state._on_update(delta, actor, blackboard)


## Changes the current state and calls the appropriate methods like _on_exit and _on_enter.
func change_state(state: FSMState) -> void:
	# Exit the current state
	active_state._on_exit(actor, blackboard)

	# Change the current state
	active_state = state

	# Enter the new state
	active_state._on_enter(actor, blackboard)

	if verbose: BehaviourToolkit.Logger.say("Changed state to " + active_state.get_name(), self)

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


## Fires an event in the FSM.
func fire_event(event: String) -> void:
	current_events.append(event)

	if active_state is FSMCompoundState:
		active_state.fire_event(event)

	if verbose: BehaviourToolkit.Logger.say("Fired event: " + event, self)


func _on_state_changed(state: FSMState) -> void:
	pass


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	if not initial_state:
		warnings.append("Initial state is not set.")

	var children: Array = get_children()

	if children.size() == 0:
		warnings.append("No states found.")

	for child in children:
		if not child is FSMState:
			warnings.append("Node '" + child.get_name() + "' is not a FSMState.")

	return warnings
