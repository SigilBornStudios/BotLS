class_name State_Run extends State

@export var move_speed : float = 50.0

@onready var idle: State = $"../idle"
@onready var attack: State = $"../attack"


## Enter state
func Enter() -> void:
	player.UpdateAnimation("run")
	pass


##Exit state
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("run")
	return null
	
func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
