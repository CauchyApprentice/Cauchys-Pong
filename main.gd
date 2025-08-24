extends Node2D

var init_ball_speed = 9
var last_player_scored = 1
signal new_ball_needed(vel)
var game_length = 60
var score = Vector2(0,0)

func score_string(_score: Vector2):
	return str(_score.x) + ":" + str(_score.y) 


func get_new_ball_vel() -> Vector2:
	var vel_x: float
	var vel_y: float
	var vel: Vector2
	
	if last_player_scored == 1:
		vel_x = -1
	elif last_player_scored == 2:
		vel_x = 1
		
	vel_y = randf_range(-0.3,0.3)
	vel = Vector2(vel_x, vel_y).normalized() * init_ball_speed
	
	return vel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_ball_needed.emit(get_new_ball_vel())
	$Timer.wait_time = game_length
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$timeDisplay.text = str(round($Timer.time_left))
	$scoreDisplay.text = score_string(score)


func _physics_process(delta: float) -> void:
	pass
	

func _on_ball_out_of_bounds(player: int) -> void:
	print("outofbounds signal")
	if player == 1:
		score.x += 1
	elif player == 2:
		score.y += 1
		
	last_player_scored = player
		
	$ball.position = Vector2(0,0)
	new_ball_needed.emit(get_new_ball_vel())
	
	get_tree().paused = true
	$resetPauseTimer.start()

func _on_reset_pause_timer_timeout() -> void:
	get_tree().paused = false


func _on_timer_timeout() -> void:
	$timeDisplay.visible = false
	$scoreDisplay.visible = false
	$endScoreDisplay.text = score_string(score)
	$endScoreDisplay.visible = true
	get_tree().paused = true
