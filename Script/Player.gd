extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dirX := 0
var dirY := 0

var x_speed := 0.0
const X_ACC = 1.0
const MAX_X_SPEED = 200.0

const FALL_SPEED = 300.0

var wantJump := false
var jumping := false
var y_speed := 0.0
const Y_DEC = 600.0
const MAX_JUMP_SPEED = 275.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	dirX = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	
	if dirX != 0:
		x_speed = lerp(x_speed, dirX * MAX_X_SPEED, X_ACC)
	else:
		x_speed = lerp(x_speed, 0, X_ACC)
			
	wantJump = Input.is_action_just_pressed("ui_up") 
	
func _physics_process(delta):
	if jumping:
		$Label.text = "jumping"
		y_speed += Y_DEC * delta
		
		if y_speed > 0:
			y_speed = 0
			jumping = false
	elif $RayCast2D.is_colliding():
		$Label.text = "on ground"
		y_speed = 0
		
		if wantJump:
			$Label.text = "start jump"
			y_speed = -MAX_JUMP_SPEED
			jumping = true
	else:
		$Label.text = "falling"
		y_speed += FALL_SPEED * delta
		
	
	move_and_slide(Vector2(x_speed, y_speed), Vector2.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
