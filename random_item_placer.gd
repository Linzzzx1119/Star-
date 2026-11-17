extends Node2D

var item_prefabs := [preload("res://health_srar.tscn"), preload("res://score_star.tscn")]

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var item_scene : PackedScene = item_prefabs.pick_random()
	var item_instance := item_scene.instantiate()
	add_child(item_instance)
	var viewport_size := get_viewport_rect().size
	item_instance.position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
