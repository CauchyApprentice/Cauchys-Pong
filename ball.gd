extends CharacterBody2D

signal out_of_bounds(player: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity)
	if collision:
		var wall = collision.get_collider()
		
		if wall.is_in_group("walls"):
			velocity.x *= -1
			if wall.direction == -1:
				velocity.y -= wall.speed
			elif wall.direction == 1:
				velocity.y += wall.speed
				
		elif wall.is_in_group("bordersTopBottom"):
			velocity.y *= -1
			
		elif wall.is_in_group("bordersLeftRight"):
			var player
			if position.x < 0:
				player = 2
			else:
				player = 1
			out_of_bounds.emit(player)
			


func _on_main_new_ball_needed(vel: Variant) -> void:
	velocity = vel
