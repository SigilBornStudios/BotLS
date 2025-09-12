extends CharacterBody2D

@export var speed: float = 15.0
@export var health: int = 100
@export var damage: int = 10
@export var detection_radius: float = 35.0

var player: Node2D = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	add_to_group("Enemy")

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()

func _physics_process(delta: float):
	if player and is_instance_valid(player):
		var to_player = player.global_position - global_position
		if to_player.length() < detection_radius:
			velocity = to_player.normalized() * speed
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
	
