extends CharacterBody2D


const SPEED := 100.0
const SPRINT_MULTIPLIER := 1.7


var movement_direction := Vector2.ZERO


@onready var sprite := $Sprite2D
@onready var animation_player := $AnimationPlayer
@onready var particles_walking := $ParticlesWalking


func _physics_process(_delta):
	movement_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
