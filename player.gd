extends Area2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction_x = Input.get_axis("move_left","move_right")
	var direction_y = Input.get_axis("move_down","move_up")
	position.x = direction_x * speed * delta
	position.y = direction_y * speed * delta
