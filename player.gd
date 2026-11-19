extends CharacterBody2D

var max_speed = 500
var steering_factor := 3
var bullet_scene = preload("res://bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction := Vector2(0,0)
	
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity : Vector2 = max_speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * steering_factor * delta
	
	move_and_slide()

	if velocity.length() > 0.0:
		rotation = velocity.angle()
		
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.rotation = rotation
		bullet.velocity = velocity.normalized() * bullet.speed
		get_tree().current_scene.add_child(bullet)
