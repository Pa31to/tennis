extends Node2D
@onready var stmTxt = get_node("map/STM/staminaBar")
@onready var hpTxt = get_node("map/HP/hpBar")
@onready var stmBar = get_node('map/STM')
@onready var hpBar = get_node('map/HP')
var loading = true

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("start"):
		_start()
		
	var hp= Game.hp
	if hp < 0:
		hp=0
	var stm= Game.stamina
	if stm < 0:
		stm = 0	
	if hp > Game.maxHp:
		hp=Game.maxHp
	if stm > Game.maxStamina:
		stm = Game.maxStamina	
	stmTxt.set_text('Stamina: '+str(stm)+'/'+str(Game.maxStamina))
	hpTxt.set_text('HP         : '+str(hp)+'/'+str(Game.maxHp))
	stmBar.set_value(stm)
	hpBar.set_value(hp)

func _start():
	if not loading:
		get_tree().change_scene_to_file("res://parts/main.tscn")


func _on_loading_timeout():
	loading = false
