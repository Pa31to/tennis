extends CharacterBody2D


var speed = Vector2(200.0 , 200.0)
var direction = Vector2(0.0,0.0)
var belocity = Vector2(0.0,0.0)
var predictBall = Vector2(0.0,0.0)
@onready var ball = get_node("../Ball")
@onready var anim = get_node("AnimatedSprite2D")
@onready var animR = get_node("ballDetection/detectD/CollisionD/AnimateD")
@onready var animL = get_node("ballDetection/detectI/CollisionI/AnimateI")
@onready var toPredict = get_node("toPredict")
@onready var base = get_node("../map/Area2D2/Base")
var reachI = false
var reachD = false
var canHit = true
var canPredict = true

func _ready():
	animR.flip_v = true
	animL.flip_v = true
	anim.play("idle")
	
func _physics_process(delta):
	var enRango = false
	if reachD or reachI:
		enRango = true
	if enRango:
		hit()
	elif Game.side == 1 and not Game.directionY == 1 :
		if canPredict:
			predictBall = ball._predict()
			canPredict = false
			toPredict.start()
		var y_dist = sqrt(pow(predictBall.y - position.y, 40)) 
		var x_dist = sqrt(pow(predictBall.x - position.x, 64)) 
		if y_dist < (speed.y * delta) and x_dist < (speed.x * delta):
			direction = Vector2.ZERO
		elif y_dist < (speed.y * delta) and ball.position.x > position.x:
			direction = Vector2.RIGHT	
		elif y_dist < (speed.y * delta) and ball.position.x < position.x:
			direction = Vector2.LEFT	
		elif x_dist < (speed.x * delta) and ball.position.y < position.y:
			direction = Vector2.UP	
		elif x_dist < (speed.x * delta) and ball.position.y > position.y:
			direction = Vector2.DOWN				
		elif ball.position.y > position.y and ball.position.x > position.x:
			direction = Vector2(1,1)
		elif ball.position.y > position.y and ball.position.x < position.x:
			direction = Vector2(-1,1)	
		elif ball.position.y < position.y and ball.position.x > position.x:
			direction = Vector2(1,-1)
		elif ball.position.y < position.y and ball.position.x < position.x:
			direction = Vector2(-1,-1)	
		if direction.x or direction.y:	
			belocity.x = direction.x * speed.x
			belocity.y = direction.y * speed.y
			anim.play('run')	
		else:
			if belocity.y == 0 and belocity.x == 0:
				anim.play("idle")
			belocity.x = move_toward(belocity.x, 0, speed.x)
			belocity.y = move_toward(belocity.y, 0, speed.y)
	elif not Game.directionY == 1:
		var y_dist = sqrt(pow(base.position.y - position.y, 40)) 
		var x_dist = sqrt(pow(base.position.x - position.x, 64)) 
		if y_dist < (speed.y * delta) and x_dist < (speed.x * delta):
			direction = Vector2.ZERO
		elif y_dist < (speed.y * delta) and ball.position.x > position.x:
			direction = Vector2.RIGHT	
		elif y_dist < (speed.y * delta) and ball.position.x < position.x:
			direction = Vector2.LEFT	
		elif x_dist < (speed.x * delta) and ball.position.y < position.y:
			direction = Vector2.UP	
		elif x_dist < (speed.x * delta) and ball.position.y > position.y:
			direction = Vector2.DOWN				
		elif ball.position.y > position.y and ball.position.x > position.x:
			direction = Vector2(1,1)
		elif ball.position.y > position.y and ball.position.x < position.x:
			direction = Vector2(-1,1)	
		elif ball.position.y < position.y and ball.position.x > position.x:
			direction = Vector2(1,-1)
		elif ball.position.y < position.y and ball.position.x < position.x:
			direction = Vector2(-1,-1)	
		if direction.x or direction.y:	
			belocity.x = direction.x * speed.x
			belocity.y = direction.y * speed.y
			anim.play('run')	
		else:
			if belocity.y == 0 and belocity.x == 0:
				anim.play("idle")
			belocity.x = move_toward(belocity.x, 0, speed.x)
			belocity.y = move_toward(belocity.y, 0, speed.y)
	move_and_collide(belocity*delta)

func hit():
	if reachD and canHit:
		Game.directionX = Game.directionX * -1
		Game.directionY = Game.directionY * -1
		animR.play("swing")
		await animR.animation_finished
		canHit = false
		$canhit.start()
	elif reachI and canHit:
		Game.directionX = Game.directionX * -1
		Game.directionY = Game.directionY * -1
		animL.play("swing")
		await animL.animation_finished
		canHit = false
		$canhit.start()	

func _on_detect_i_body_entered(body):
	if body.name == "Ball":
		reachI = true

func _on_detect_i_body_exited(body):
	if body.name == "Ball":
		reachI = false

func _on_detect_d_body_entered(body):
	if body.name == "Ball":
		reachD = true

func _on_detect_d_body_exited(body):
	if body.name == "Ball":
		reachD = false

func _on_to_predict_timeout():
	canPredict = true

func _on_canhit_timeout():
	canHit = true
