extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dirX := 0
var dirY := 0

var x_speed := 0.0
const X_ACC = 1.8
const MAX_X_SPEED = 200.0

const FALL_SPEED = 310.0

var wantJump := false
var y_speed := 0.0
const MAX_JUMP_SPEED = 220.0

var inputs:PoolStringArray

# Called when the node enters the scene tree for the first time.
func _ready():
	inputs = ["ui_right", "ui_left", "ui_up"]
	pass # Replace with function body.

func _process(delta):
	dirX = int(Input.is_action_pressed(inputs[0]))-int(Input.is_action_pressed(inputs[1]))
	
	if dirX != 0:
		x_speed = lerp(x_speed, dirX * MAX_X_SPEED, X_ACC)
	else:
		x_speed = lerp(x_speed, 0, X_ACC)
			
	wantJump = Input.is_action_just_pressed(inputs[2])
	
func _physics_process(delta):
	if $RayCast2D.is_colliding():
		$Label.text = "on ground"
		y_speed = 0
		
		if wantJump:
			$Label.text = "start jump"
			y_speed = -MAX_JUMP_SPEED
	else:
		$Label.text = "falling"
		y_speed += FALL_SPEED * delta
		
	
	move_and_slide(Vector2(x_speed, y_speed), Vector2.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
