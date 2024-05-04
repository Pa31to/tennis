extends CharacterBody2D


const SPEED = 300.0
@onready var anim = get_node("AnimatedSprite2D")
var reachI = false
var reachD = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	anim.play("idle")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	
	if directionX == -1:
		anim.flip_h = true
	if directionX == 1:
		anim.flip_h = false
	if directionX or directionY:
		velocity.x = directionX * SPEED
		velocity.y = directionY * SPEED
		anim.play("run")
	else:	
		if velocity.y == 0 and velocity.x == 0:
			anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()


func _on_area_i_child_entered_tree(node):
	reachI = true


func _on_area_d_child_entered_tree(node):
	reachD = true


func _on_area_i_child_exiting_tree(node):
	reachI = false

func _on_area_d_child_exiting_tree(node):
	reachD = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_A:
			print(event.keycode)
		if event.keycode == KEY_D:
			print(event.keycode)
		if event.keycode == KEY_S:
			print(event.keycode)
		if event.keycode == KEY_W:
			print(event.keycode)		
		
func _hit():
	pass
