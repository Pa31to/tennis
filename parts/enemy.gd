extends CharacterBody2D


var speed = Vector2(0.0 , 100.0)
var direction = Vector2(0.0,0.0)
var belocity = Vector2(0.0,0.0)
@onready var ball = get_node("res://parts/ball.tscn")


func _physics_process(delta):
	var y_dist = sqrt(pow(ball.position.y - position.y, 2)) 

	if y_dist < (speed.y * delta):
	 # not  far enough away to move
		direction = Vector2.ZERO
	elif ball.position.y > position.y:
	 	# far enough to move and ball below the paddle
		direction = Vector2.DOWN
	elif ball.position.y < position.y:
	 	# far enough to move and ball above the paddle
		direction = Vector2.UP

	belocity = speed * direction
	move_and_collide(belocity)
