extends CharacterBody2D

var max_speed = 300
var steering_factor := 5
var health := 50
var bullet_scene = preload("res://bullet.tscn")
var star_count := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:

	position += velocity * delta

	if velocity.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()

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
	
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.rotation = get_node("Sprite2D").rotation
		bullet.velocity = Vector2.from_angle(get_node("Sprite2D").rotation) * bullet.speed
		get_tree().current_scene.add_child(bullet)


func set_star_count(new_star_count: int) -> void:
	star_count = new_star_count
	get_node("UI/StarCount").text = "x" + str(star_count)
	if  star_count >= 5:
		get_node("Camera2D/Win UI").show()
	

func set_health(new_health: int) -> void:
	health = new_health
	if health > 100:
		health = 100
	elif health < 0:
		health = 0
		get_node("Camera2D/Lose UI").show()
	get_node("UI/HealthBar").value = health


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("score star"):
		set_star_count(star_count + 1)
	elif area.is_in_group("health star"):
		set_health(health + 20)
