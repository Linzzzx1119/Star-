extends CharacterBody2D

var max_speed = 500
var steering_factor := 3
var health := 10
var bullet_scene = preload("res://bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if health <= 0:
		queue_free()

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

	

func set_health(new_health: int) -> void:
	health = new_health
	get_node("UI/HealthBar").value = health


func _on_area_entered(area_that_entered: Area2D) -> void:
	set_health(health + 10)

		
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.rotation = rotation
		bullet.velocity = Vector2.from_angle(rotation) * bullet.speed
		get_tree().current_scene.add_child(bullet)
