extends Node2D

var loading = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('start') and not loading:
		_on_play_pressed()
	elif Input.is_action_pressed('reset'):
		_on_exit_pressed()


func _on_exit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://court.tscn")


func _on_timer_timeout():
	loading = false
