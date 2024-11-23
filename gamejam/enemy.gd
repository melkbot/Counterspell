extends CharacterBody2D

var input_vector
var input_dir
@onready var sprite = $AnimatedSprite2D

const tile_size = 16
var moving = false
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_right: RayCast2D = $RayCastRight


func _physics_process(delta: float) -> void:
	input_dir = Vector2.ZERO
	if Input.is_action_just_pressed("ui_down") && !ray_cast_down.is_colliding():
		input_dir = Vector2.DOWN
		sprite.play("Run_Down")
		move()
	elif Input.is_action_just_pressed("ui_up") && !ray_cast_up.is_colliding():
		input_dir = Vector2.UP
		sprite.play("Run_Up")
		move()
	elif Input.is_action_just_pressed("ui_left") && !ray_cast_left.is_colliding():
		input_dir = Vector2.LEFT
		sprite.play("Run_Left")
		move()
	elif Input.is_action_just_pressed("ui_right") && !ray_cast_right.is_colliding():
		input_dir = Vector2.RIGHT
		sprite.play("Run_Right")
		move()
	
	move_and_slide()
	velocity = input_dir * 10000 * delta
	
func move():
	if input_dir:
		if moving == false:
			moving = true
			var tween = create_tween()
			tween. tween_property(self, "position", position+ input_dir*tile_size, 0.35)
			tween.tween_callback(move_false)

func move_false():
	moving = false
	sprite.play("Idle")
