extends CharacterBody3D

@onready var cam_mount: Node3D = $cam_mount
@onready var animation_player: AnimationPlayer = $visuals/mixamo_base/AnimationPlayer
@onready var visuals: Node3D = $visuals

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const DASH_SPEED = 15.0  # Dash speed multiplier
const DASH_DURATION = 0.2  # Duration of the dash in seconds
const DASH_COOLDOWN = 1.0  # Time before dash can be used again
#@export is the same thing as putting a variable public in Unity
@export var sens_horizontal = .25;
@export var sens_vertical = .25;

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_dashing = false
var dash_time_left = 0.0
var dash_cooldown_left = 0.0
var dash_direction = Vector3.ZERO
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if	event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		cam_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))

#This is like FixedUpdate() from Unity
func _physics_process(delta: float) -> void:
			# Update cooldown timer
	if dash_cooldown_left > 0:
		dash_cooldown_left -= delta

	# Handle dash input and mechanism
	if Input.is_action_just_pressed("dash") and dash_cooldown_left <= 0 and not is_dashing:
		start_dash()

	# Process dash if active
	if is_dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			end_dash()
		else:
			velocity.x = dash_direction.x * DASH_SPEED
			velocity.z = dash_direction.z * DASH_SPEED
			move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "foward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if animation_player.current_animation != "running":
			animation_player.play("running")
					
		visuals.look_at(position + direction)
			
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
				
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
func start_dash() -> void:
	# Start dash by setting the direction and dash time
	is_dashing = true
	dash_direction = Vector3(velocity.x, 0, velocity.z).normalized()
	dash_time_left = DASH_DURATION
	dash_cooldown_left = DASH_COOLDOWN
	animation_player.play("dash")  # Play dash animation

func end_dash() -> void:
	# End dash and reset velocity
	is_dashing = false
	dash_direction = Vector3.ZERO
	animation_player.play("idle")  # Go back to idle or running animation
