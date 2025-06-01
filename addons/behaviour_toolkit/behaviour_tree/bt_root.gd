@tool
@icon("res://addons/behaviour_toolkit/icons/BTRoot.svg")
class_name BTRoot extends BehaviourToolkit
## Node used as a base parent (root) of a Behaviour Tree
##
## This is the root of your behaviour tree.[br]
## It is designed to expect first child node to be a BTComposite node to start
## the execution of the behaviour tree.[br]
## The root node is responsible for updating the tree.


var current_status: BTBehaviour.BTStatus
var entry_point: Node = null


func _ready() -> void:
	# Don't run in editor
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
		return
	
	if verbose: BehaviourToolkit.Logger.say("Initializing Behavior Tree...", self)
	
	entry_point = get_child(0)
	if verbose and entry_point: 
		BehaviourToolkit.Logger.say("Entry point set to: " + entry_point.name, self)
	
	if blackboard == null:
		blackboard = _create_local_blackboard()
		if verbose: BehaviourToolkit.Logger.say("Created local blackboard", self)

	if autostart:
		active = true
		if verbose: BehaviourToolkit.Logger.say("Autostart enabled", self)

	if not process_type:
		process_type = ProcessType.PHYSICS

	_setup_processing()


func _process_code(delta: float) -> void:
	if not active:
		return
	
	var previous_status = current_status
	current_status = entry_point.tick(delta, actor, blackboard)
	
	if verbose and previous_status != current_status:
		BehaviourToolkit.Logger.say("Status changed: " + str(current_status), self)


func _create_local_blackboard() -> Blackboard:
	if verbose: BehaviourToolkit.Logger.say("Creating new blackboard", self)
	var blackboard: Blackboard = Blackboard.new()
	return blackboard


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var children = get_children()

	if children.size() == 0:
		warnings.append("Behaviour Tree needs to have one Behaviour child.")
	elif children.size() == 1:
		if not children[0] is BTBehaviour:
			warnings.append("The child of Behaviour Tree needs to be a Behaviour.")
	elif children.size() > 1:
		warnings.append("Behaviour Tree can have only one Behaviour child.")

	return warnings
