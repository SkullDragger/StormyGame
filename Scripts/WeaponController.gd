extends Node3D

@export var bullet_prefab : PackedScene
@export var root_node : Node3D
@export var shoot_position : Node3D
@export var fire_rate : float

var fire_timer : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_timer = fire_rate
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fire_timer < fire_rate:
		fire_timer += delta
		
	if Input.is_action_pressed("fire") and fire_timer >= fire_rate:
		fire_timer = 0
		var bullet = bullet_prefab.instantiate()
		root_node.add_child(bullet)
		bullet.position = shoot_position.global_position
		bullet.direction = -get_global_transform().basis.z
	pass
