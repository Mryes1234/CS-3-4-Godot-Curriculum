extends npc

@onready var sprite: Sprite2D = $Sprite2D
@export var damage_amount: int = -10
@export var damage_cooldown: float = 1.0

var can_damage: bool = true

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass

func _on_detection_radius_body_entered(body: Node2D) -> void:
	super._on_detection_radius_body_entered(body)
	if body is Player:
		is_hostile = true

func _on_detection_radius_body_exited(body: Node2D) -> void:
	super._on_detection_radius_body_exited(body)
	if body is Player:
		is_hostile = false


func _on_hit_radius_body_entered(body: Node2D) -> void:
	can_damage = true
	if body is Player and can_damage:
		print("Player touched slime! Dealing " + str(damage_amount) + " damage")
		
		if body.has_method("change_health"):
			body.change_health(damage_amount)


func _on_hit_radius_body_exited(body: Node2D) -> void:
	if body is Player:
		can_damage = false
