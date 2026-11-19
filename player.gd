extends CharacterBody2D

var max_speed = 300
var steering_factor := 5
var health := 10
var bullet_scene = preload("res://bullet.tscn")
var star_count := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if health <= 0:
		queue_free()

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
func set_star_count(new_star_count: int) -> void:
	star_count = new_star_count
	get_node("UI/StarCount").text = "x" + str(star_count)
	

func set_health(new_health: int) -> void:
	health = new_health
	get_node("UI/HealthBar").value = health

func _on_body_entered(area_that_entered: Area2D) -> void:
	if area_that_entered.is_in_group("ScoreStar"):
		set_star_count(star_count + 1)
	elif area_that_entered.is_in_group("HealthStar"):
		set_health(health + 10)


func _on_area_entered(area_that_entered: Area2D) -> void:
	set_health(health + 10)

		
