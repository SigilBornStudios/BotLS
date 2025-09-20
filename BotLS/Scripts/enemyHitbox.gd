class_name EnemyHitbox extends Node


func _ready():
	$HitBox.Damaged.connect( TakeDamage )

func TakeDamage( _damage : int ) -> void:
	queue_free()
	pass
