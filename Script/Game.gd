extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Ball = preload("res://Scene/Ball.tscn")
var ball

var scores:PoolIntArray

var scoreNodes

var lastWin := false

var win := false

var counter := 3

func spawnBall():
	ball = Ball.instance()
	
	if !lastWin:
		ball.position = Vector2(225, 400)
	else:
		ball.position = Vector2(710, 400)
		
	ball.connect("body_entered", self, "_on_Ball_body_entered")
	call_deferred("add_child", ball)

# Called when the node enters the scene tree for the first time.
func _ready():
	scores = [0, 0]
	
	scoreNodes = [$ScoreP1, $ScoreP2]
	
	spawnBall()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
#	pass
func reset(var i, var b):
	ball.queue_free()
			
	scores[i] += 1
	
	scoreNodes[i].text = str(scores[i])
	
	lastWin = b
	
	counter = 3
	
	var label = $LabelTimer
	label.text = str(counter)
	label.show()
	
	win = false
	
	spawnBall()
	
	$Timer.start()

func _on_Ball_body_entered(body):
	match(body.name):
		"GroundP1":
			print("player1 lose")
			
			reset(1, true)
			
		"GroundP2":
			print("player2 lose")
			
			reset(0, false)
	pass # Replace with function body.


func _on_Timer_timeout():
	if counter > 1:
		counter -= 1
		
		$LabelTimer.text = str(counter)
	else:
		win = true
		
		ball.mode = RigidBody2D.MODE_RIGID
		
		$LabelTimer.hide()
		
		$Timer.stop()
	
	pass # Replace with function body.
