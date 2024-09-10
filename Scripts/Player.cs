using Godot;

public partial class Player : CharacterBody3D
{
	[Export] public float ShootCooldown = 0.5f;
	[Export] public float ProjectileSpeed = 20.0f;
	
	private Node3D firepoint;
	private bool canShoot = true;
	public const float Speed = 5.0f;
	public const float DashSpeed = 20.0f;
	public const float DashDuration = 0.2f; // How long the dash lasts
	public const float DashCooldown = 1.0f; // Cooldown between dashes

	private bool isDashing;
	private double dashTimeLeft;
	private double dashCooldownTimeLeft;
	private Vector3 dashDirection = Vector3.Zero;
	public override void _PhysicsProcess(double delta)
	{
		Vector3 velocity = Velocity;
		
		// Get the input direction and handle the movement/deceleration.
		Vector2 inputDir = Input.GetVector("left", "right", "up", "down");
		Vector3 direction = new Vector3(inputDir.X, 0, inputDir.Y).Normalized();
		if (dashCooldownTimeLeft > 0)
			dashCooldownTimeLeft -= delta;
		
		if (Input.IsActionJustPressed("dash") && !isDashing && dashCooldownTimeLeft <= 0)
		{
			isDashing = true;
			dashTimeLeft = DashDuration;
			dashCooldownTimeLeft = DashCooldown;
			dashDirection = direction;
		}
		if (isDashing)
		{
			if (dashTimeLeft > 0)
			{
				dashTimeLeft -= delta;
				velocity.X = dashDirection.X * DashSpeed;
				velocity.Z = dashDirection.Z * DashSpeed;
			}
			else
				isDashing = false;
		}
		else
		{
			if (direction != Vector3.Zero)
			{
				velocity.X = direction.X * Speed;
				velocity.Z = direction.Z * Speed;
			}
			else
			{
				velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
				velocity.Z = Mathf.MoveToward(Velocity.Z, 0, Speed);
			}
		}
		Velocity = velocity;
		MoveAndSlide();
	}
}