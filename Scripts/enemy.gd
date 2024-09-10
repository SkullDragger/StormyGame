class_name Enemy
extends RigidBody3D

var health: int = 1


# Called when the enemy takes damage
func take_damage(damage: int) -> void:
    health -= damage
    if health <= 0:
        die()

# Handle enemy death
func die() -> void:
    queue_free()  # Remove the enemy from the scene
