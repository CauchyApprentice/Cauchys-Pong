extends AnimatableBody2D

@export var player: int = 1
@export var speed = 5
@export var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var up_key
	var down_key
	
	if player == 1:
		up_key = "player1_up"
		down_key = "player1_down"
	elif player == 2:
		up_key = "player2_up"
		down_key = "player2_down"
	
	
	direction = 0
	
	if Input.is_action_pressed(up_key) and position.y > -(1080/2 - scale.y/2):
		direction -= 1
	if Input.is_action_pressed(down_key) and position.y < 1080/2 - scale.y/2:
		direction += 1
		
	if direction == -1:
		position.y -= speed
	elif direction == 1:
		position.y += speed
