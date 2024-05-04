extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
func _ready():
	anim.play("spinning")

func _physics_process(delta):
	
	velocity.x = Game.directionX * Game.ballspeed
	velocity.y = Game.directionY * Game.ballspeed
	move_and_collide(velocity*delta)
	
func _process(delta):
	pass
