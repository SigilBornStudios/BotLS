class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
#var move_speed : float = 50.0
#var state : String = "idle"
@onready var state_machine: PlayerStateMachine = $StateMachine


@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal DirectionChanged( new_direction : Vector2 ) 



var states = []


func _ready() -> void:
	add_to_group("Player")
	#animation_player.play("idle_down")
	state_machine.Initialize(self)
	pass

func _process(delta: float) -> void:
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	"""
	velocity = direction * move_speed
	
	if SetState() || SetDirection():
		UpdateAnimation()
	"""
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

func SetDirection() -> bool:
	var new_direction : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_direction == cardinal_direction:
		return false
	cardinal_direction = new_direction
	DirectionChanged.emit( new_direction )
	return true
"""
func SetState() -> bool:
	var new_state : String = "idle"
	
	if direction == Vector2.ZERO:
		new_state = "idle"
	else:
		new_state = "run"
		
	if new_state == state:
		return false
	state = new_state
	return true
"""

func UpdateAnimation( state : String ) -> void:
	animation_player.play(state + "_" + AnimationDirection())
	pass

func AnimationDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	else:
		return "right"
