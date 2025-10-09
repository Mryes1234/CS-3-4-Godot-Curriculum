extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_shop_radius_body_entered(_body: Node2D) -> void:
	if _body is Player:
		animated_sprite.play("Wave")

func _on_shop_radius_body_exited(_body: Node2D) -> void:
	if _body is Player:
		animated_sprite.play("Idle")
