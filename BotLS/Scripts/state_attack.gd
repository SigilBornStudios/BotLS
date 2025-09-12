class_name State_Attack extends State

var attacking : bool = false

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@onready var idle: State_Idle = $"../idle"
@onready var run: State = $"../run"

@onready var attack_hurt_box: HurtBox = %AttackHurtBox



## Enter state
func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect( EndAttack )
	attacking = true
	
	await get_tree().create_timer( 0.175 ).timeout
	attack_hurt_box.monitoring = true
	
	pass


##Exit state
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack ) 
	attacking = false
	
	attack_hurt_box.monitoring = false
	pass
	
func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return run
	return null
	
func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return null


func EndAttack( _newAnimationName : String ) -> void:
	attacking = false
