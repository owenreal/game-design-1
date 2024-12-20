extends CharacterBody2D

const SPEED = 100.0
const MAXIMUM_OBTAINABLE_HEALTH = 400.0
enum  STATES { IDLE=0, DEAD, DAMAGED, ATTACKING, CHARGING }
# aud_player.stream = whatever
# aud_player.play()

@export var data = {
	"max_health": 60.0,  # 20hp per heart, 5 per fraction
	"health": 40.0,      # Min 60 Max 400
	"money": 0,
	"state": STATES.IDLE,
	"secondaries": [],
}

var inertia = Vector2()
var look_direction = Vector2.DOWN  # Vector2(0,1)
var attack_direction = look_direction
var animation_lock = 0.0 # lock player in attack anim
var damage_lock = 0.5
var charge_time = 1.0
var charge_start_time = 0.0
var charge_ready = false

var slash_scene = preload("res://entities/attacks/slash.tscn")
var damage_shader = preload("res://Assets/shaders/take_damage.tres")
var attack_sound = preload("res://Assets/sounds/slash.wav")
var chargeReady_sound = preload("res://Assets/sounds/chargeReady.wav")
var charge_sound = preload("res://Assets/sounds/chargeSlash.wav")
var coin_pickup = preload("res://Assets/sounds/pickupCoin.wav")
var heart_pickup = preload("res://Assets/sounds/pickupHeart.wav")
var hurt_sound = preload("res://Assets/sounds/hitHurt.wav")
var death_sound = preload("res://Assets/sounds/death_sound.wav")
var container_pickup = preload("res://Assets/sounds/maxUp.wav")

@onready var p_HUD = get_tree().get_first_node_in_group("HUD")
@onready var aud_player = $AudioStreamPlayer2D

func save_to_file(data):
	var file = FileAccess.open("res://game_data.player_data.txt", FileAccess.WRITE)
	file.store_string(str(data.money))

func load_from_file():
	var file = FileAccess.open("res://game_data.player_data.txt", FileAccess.READ)
	var Mdata = file.get_as_text()
	data.money = float(Mdata)
	#return data

func get_direction_name():
	return ["right", "down", "left", "up"][
		int(round(look_direction.angle() * 2 / PI)) % 4
	]

func attack():
	data.state = STATES.ATTACKING
	var dir_name = get_direction_name()
	if dir_name == "left":
		$AnimatedSprite2D.flip_h = 0
	$AnimatedSprite2D.play("swipe_" + dir_name)
	attack_direction = look_direction
	var slash = slash_scene.instantiate()
	slash.position = attack_direction * 20.0
	slash.rotation = Vector2().angle_to_point(-attack_direction)
	add_child(slash)
	aud_player.stream = attack_sound
	aud_player.play()
	animation_lock = 0.2

func charged_attack():
	data.state = STATES.ATTACKING
	$AnimatedSprite2D.play("swipe_charge")
	attack_direction = -look_direction
	damage_lock = 0.3
	for i in range(9):
		# offset angle by (i-4) * 45 degrees [-4, 4]
		var angle = attack_direction.angle() + (i-4) * PI/4
		var dir = Vector2(cos(angle), sin(angle))
		var slash = slash_scene.instantiate()
		slash.position = dir * 20
		slash.rotation = Vector2().angle_to_point(-dir)
		slash.damage *= 1.5
		add_child(slash)
		await get_tree().create_timer(0.03).timeout
	animation_lock = 0.2
	await $AnimatedSprite2D.animation_finished
	data.state = STATES.IDLE

func _ready() -> void:
	#load_from_file()
	p_HUD.show()

func pickup_health(value):
	aud_player.stream = heart_pickup
	aud_player.play()
	data.health += value
	data.health = clamp(data.health, 0, data.max_health)

func pickup_container(value):
	aud_player.stream = container_pickup
	aud_player.play()
	data.max_health += value
	data.health = data.max_health

func pickup_money(value):
	aud_player.stream = coin_pickup
	aud_player.volume_db -= 20
	aud_player.play()
	aud_player.volume_db += 20
	data.money += value
	$PlayerHUD/PlayerMoney/coinslbl.text = str(data.money)

signal health_depleted

func take_damage(dmg):
	if damage_lock == 0.0 and data.state != STATES.DEAD:
		data.health -= dmg
		data.state = STATES.DAMAGED
		damage_lock = 0.5
		animation_lock = dmg * 0.005
		$AnimatedSprite2D.material = damage_shader.duplicate()
		$AnimatedSprite2D.material.set_shader_parameter("intensity", 0.5)
		if data.health > 0:
			aud_player.stream = hurt_sound
			aud_player.play()
			pass
		else:
			data.state = STATES.DEAD
			aud_player.stream = death_sound
			aud_player.play()
			await get_tree().create_timer(0.5).timeout
			health_depleted.emit()
	pass

func _physics_process(delta: float) -> void:
	animation_lock = max(animation_lock-delta, 0.0)
	damage_lock = max(damage_lock-delta, 0.0)
	
	
	if animation_lock == 0.0 and data.state != STATES.DEAD:
		if data.state == STATES.DAMAGED and max(damage_lock-delta, 0.0):
			$AnimatedSprite2D.material = null
		
		if data.state != STATES.CHARGING:
			data.state = STATES.IDLE
	
		var direction = Vector2(
			Input.get_axis("ui_left", "ui_right"),
			Input.get_axis("ui_up", "ui_down")
		)
		if direction.length() > 0:
			look_direction = direction
			# Scale to 1 to prevent speed boost from diagonals
			direction = direction.normalized()
			velocity  = direction * SPEED
		else:
			velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		velocity += inertia
		update_animation(direction)
		move_and_slide()
		inertia = inertia.move_toward(Vector2.ZERO, delta * 1000.0)
		
	if data.state != STATES.DEAD:
		if Input.is_action_just_pressed("ui_accept"):
			attack()
			charge_start_time = 0.0
			data.state = STATES.CHARGING
		if charge_start_time >= charge_time and data.state == STATES.CHARGING and charge_ready == false:
			charge_ready = true
			aud_player.stream = chargeReady_sound
			aud_player.play()
			
		if Input.is_action_just_pressed("ui_select"):
			for entity in get_tree().get_nodes_in_group("Interactable"):
				if entity.in_range(self):
					entity.interact(self)
					data.state = STATES.IDLE
					return
		
		charge_start_time += delta
		if Input.is_action_just_released("ui_accept"):
			if charge_start_time >= charge_time and data.state == STATES.CHARGING and charge_ready == true:
				aud_player.stream = charge_sound
				aud_player.play()
				charged_attack()
				charge_ready = false
			else:
				data.state = STATES.IDLE
			
		if Input.is_action_just_pressed("ui_cancel"):
			$Camera2D/pause_menu.show()
			get_tree().paused = true
			#save_to_file(data)
			#load_from_file()
	elif data.state == STATES.DEAD:
		$AnimatedSprite2D.flip_v = true
		$AnimatedSprite2D.play("death")
		var death_time = get_tree().create_timer(1.0)
		await death_time.timeout
		$Camera2D/death_menu.show()
	pass

func update_animation(direction):
	if data.state == STATES.IDLE:
		var a_name = "idle_"
		if direction.length() > 0:
			a_name = "walk_"
		if look_direction.x != 0:
			a_name += "side"
			$AnimatedSprite2D.flip_h = look_direction.x < 0
		elif look_direction.y < 0:
			a_name += "up"
		elif look_direction.y > 0:
			a_name += "down"
		$AnimatedSprite2D.animation = a_name
		$AnimatedSprite2D.play()
	pass
