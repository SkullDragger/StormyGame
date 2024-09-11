using Godot;

public partial class Player : CharacterBody3D
{
	[Export] public Camera3D Camera;
	[Export] public AnimationPlayer AnimationPlayer;
	public int Hp = 3;
	
	private bool _canShoot = true;
	public const float Speed = 7.0f;
	public const float DashSpeed = 20.0f;
	public const float DashDuration = 0.2f;
	public const float DashCooldown = 1.0f;
	
	private bool _isDashing;
	private double _dashTimeLeft;
	private double _dashCooldownTimeLeft;
	private Vector3 _dashDirection = Vector3.Zero;
	public override void _PhysicsProcess(double delta)
	{
		Vector3 velocity = Velocity;
		
		// Get the input direction and handle the movement/deceleration.
		Vector2 inputDir = Input.GetVector("left", "right", "up", "down");
		Vector3 direction = new Vector3(inputDir.X, 0, inputDir.Y).Normalized();
		if (_dashCooldownTimeLeft > 0)
			_dashCooldownTimeLeft -= delta;
		
		if (Input.IsActionJustPressed("dash") && !_isDashing && _dashCooldownTimeLeft <= 0)
		{
			_isDashing = true;
			_dashTimeLeft = DashDuration;
			_dashCooldownTimeLeft = DashCooldown;
			_dashDirection = direction;
		}
		if (_isDashing)
		{
			if (_dashTimeLeft > 0)
			{
				_dashTimeLeft -= delta;
				velocity.X = _dashDirection.X * DashSpeed;
				velocity.Z = _dashDirection.Z * DashSpeed;
			}
			else
				_isDashing = false;
		}
		else
		{
			if (direction != Vector3.Zero)
			{
				velocity.X = direction.X * Speed;
				velocity.Z = direction.Z * Speed;
				PlayAnimation("walk");
			}
			else
			{
				velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
				velocity.Z = Mathf.MoveToward(Velocity.Z, 0, Speed);
			}
		}
		Velocity = velocity;
		MoveAndSlide();

		Vector3 targetPosition = new Vector3(Position.X, 15f, Position.Z);
		Camera.GlobalTransform = new Transform3D(Camera.GlobalTransform.Basis, Camera.GlobalTransform.Origin.Lerp(targetPosition, 0.1f)  // Smooth follow
		);
	}
	private void PlayAnimation(string animationName)
	{
		if (!AnimationPlayer.IsPlaying() || AnimationPlayer.CurrentAnimation != animationName)
			AnimationPlayer.Play(animationName);
	}
}