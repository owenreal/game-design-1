extends RigidBody2D

@export var speed = 100
var direction = 1

func _ready() -> void:
	$Timer.start()
	update_animation(direction)
	
func _physics_process(delta: float) -> void:
	self.linear_velocity.x = speed * direction
	
func _on_timer_timeout() -> void:
	direction *= -1
	update_animation(direction)
func _on_body_entered(body: Node) -> void:
	if body.name == "plt_player":
		body.queue_free()
		OS.alert("You died!")
		get_tree().reload_current_scene()
		
@onready var anim = $AnimatedSprite2D
func update_animation(direction):
	if direction != 0: # walking
		anim.play("walk")
		anim.flip_h = direction < 0
