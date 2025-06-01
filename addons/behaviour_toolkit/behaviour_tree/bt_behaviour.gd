@icon("res://addons/behaviour_toolkit/icons/BTBehaviour.svg")
extends Node
class_name BTBehaviour
## Base class for building behaviour nodes in BehaviourToolkit.
##
## Behaviours can return [enum BTBehaviour.BTStatus.SUCCESS],
## [enum BTBehaviour.BTStatus.FAILURE] or [enum BTBehaviour.BTStatus.RUNNING]
## which control the flow of the behaviours in Behaviour Tree system.


enum BTStatus {
	SUCCESS,
	FAILURE,
	RUNNING,
}
