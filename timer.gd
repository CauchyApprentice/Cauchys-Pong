extends Node2D

@export var game_length = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = game_length
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str(round($Timer.time_left))
