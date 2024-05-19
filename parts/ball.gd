extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
var positionPredict = Vector2.ZERO

func _ready():
	anim.play("spinning")

func _physics_process(delta):
	velocity.x = Game.directionX * Game.ballspeed
	velocity.y = Game.directionY * Game.ballspeed
	move_and_collide(velocity*delta)

func _predict():
	positionPredict.x = position.x + (Game.directionX * Game.ballspeed * 2)
	positionPredict.y = position.y + (Game.directionY * Game.ballspeed * 2)
	print("Posicion: "+str(position)+" Prediccion: "+str(positionPredict))
	return positionPredict

func _process(delta):
	pass
