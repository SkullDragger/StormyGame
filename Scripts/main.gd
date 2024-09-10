extends Node3D

var ray_origin = Vector3()
var ray_target = Vector3()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    var mouse_pos = get_viewport().get_mouse_position()
    var ray_length = 2000
    var from = $Camera3D.project_ray_origin(mouse_pos)
    var to = from + $Camera3D.project_ray_normal(mouse_pos) * ray_length
    var space = get_world_3d().direct_space_state
    var ray_query = PhysicsRayQueryParameters3D.new()
    ray_query.from = from
    ray_query.to = to
    ray_query.collide_with_areas = true
    var raycast_result = space.intersect_ray(ray_query)
    
    if not raycast_result.is_empty():
        var pos = raycast_result.position
        var look_at_me = Vector3(pos.x, $Player.position.y, pos.z)
        $Player.look_at(look_at_me, Vector3.UP)
