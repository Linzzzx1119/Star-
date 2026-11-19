extends Area2D

var max_speed = 500
var velocity := Vector2(0,0)
var steering_factor := 3
var health := 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	area_entered.connect(_on_area_entered)
	set_health(50)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
 
	var direction := Vector2(0,0)
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity : Vector2 = max_speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * steering_factor * delta
	position += velocity * delta

	if velocity.length() > 0.0:
		rotation = velocity.angle()


func set_health(new_health: int) -> void:
	health = new_health
	get_node("UI/HealthBar").value = health


func _on_area_entered(area_that_entered: Area2D) -> void:
	set_health(health + 10)
