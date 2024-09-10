extends Node3D


@export var speed : float

var direction : Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.connect("timeout", queue_free)
	$Timer.set_wait_time(5)
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	pass
