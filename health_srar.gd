extends Area2D

func _ready() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(get_node("Sprite2D"), "position", Vector2(0, -15), 1.3)
	tween.tween_property(get_node("Sprite2D"), "position", Vector2(0, 0), 1.3)
	tween.set_loops()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_health(body.health + 20)
		queue_free()
