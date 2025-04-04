@icon("res://addons/behaviour_toolkit/icons/Gear.svg")
class_name BehaviourToolkit extends Node
## Base class for Behaviour Toolkit plugin nodes.


enum ProcessType {
	IDLE, ## Updates on every rendered frame (at current FPS).
	PHYSICS, ## Updates on a fixed rate (60 FPS by default) synchornized with physics thread. 
}

var active: bool = false

@export var autostart: bool = false
@export var actor: Node
@export var blackboard: Blackboard
## Can be used to select if Behaviour Tree tick() is calculated on
## rendering (IDLE) frame or physics (PHYSICS) frame. 
## [br]
## More info: [method Node._process] and [method Node._physics_process]
@export var process_type: ProcessType = ProcessType.PHYSICS
@export var verbose: bool = false


# Configures process type to use, if BTree is not active both are disabled.
func _setup_processing() -> void:
	if verbose:
		BehaviourToolkit.Logger.say("Setting process type: " + str(ProcessType.keys()[process_type]), self)
	set_physics_process(process_type == ProcessType.PHYSICS)
	set_process(process_type == ProcessType.IDLE)


func _process_code(delta: float) -> void:
	pass


func  _physics_process(delta: float) -> void:
	_process_code(delta)


func _process(delta: float) -> void:
	_process_code(delta)


class Logger:
	enum LogType {
	DEFAULT,
	WARNING,
	ERROR,
	}
	## Logger class for Behaviour Toolkit plugin.

	## Main color for logger messages.
	const COLOR_MAIN: String = "Orange"
	## Accent color for logger messages.
	const COLOR_ACCENT: String = "Blue"
	## Warning color for logger messages.
	const COLOR_WARNING: String = "Yellow"
	## Error color for logger messages.
	const COLOR_ERROR: String = "Red"

	## Log a message to the console with the Behaviour Toolkit prefix.
	static func say(message: String, caller: Node = null, type: LogType = LogType.DEFAULT) -> void:
		var log_message: String
		log_message = colorize("[Behaviour Toolkit] ", COLOR_MAIN)

		if not type == LogType.DEFAULT:
			var color: String
			match type:
				LogType.WARNING:
					color = COLOR_WARNING
				LogType.ERROR:
					color = COLOR_ERROR
			
			log_message += colorize("[" + LogType.keys()[type] + "] ", color)

		if caller != null:

			log_message += colorize(caller.name + " ", COLOR_ACCENT)

			var actor: Node = null
			if "actor" in caller:
				actor = caller.actor
			
			if actor:
				log_message += colorize("@ " + actor.name + " ", COLOR_ACCENT)


		log_message += message

		print_rich(log_message)

	## Colorize a message with a given color tag in BBCode format.
	static func colorize(message: String, color: String) -> String:
		return "[color=" + color + "]" + message + "[/color]"
