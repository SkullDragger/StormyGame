extends Node3D


@export var speed : float
@export var damage : int
var direction : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $Timer.connect("timeout", Callable(self, "queue_free"))
    $Timer.set_wait_time(5)
    $Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    position += direction * speed * delta
# Called when the bullet collides with an area

# Called when the bullet collides with a body (like an enemy or wall)
# Handle physics integration to detect collisions
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
    if state.get_contact_count() > 0:
        for i in range(state.get_contact_count()):
            var collider = state.get_contact_collider_object(i)

            # Check if the collider has the 'enemy.gd' script attached
            if collider is Enemy:  
                collider.call("take_damage", damage)
                queue_free()  # Destroy the bullet after hitting the enemy
