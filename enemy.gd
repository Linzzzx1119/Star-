extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(get_node("Sprite2D"), "position", Vector2(0, -15), 0.8)
	tween.tween_property(get_node("Sprite2D"), "position", Vector2(0, 0), 0.8)
	tween.set_loops()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_health(body.health - 10)
		


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		queue_free()
