extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Ball = preload("res://Scene/Ball.tscn")

var scores:PoolIntArray

var scoreNodes

var lastWin := false

var win := false

# Called when the node enters the scene tree for the first time.
func _ready():
	scores = [0, 0]
	
	scoreNodes = [$ScoreP1, $ScoreP2]
	
	$Player.myPause(false)
	$Player2.myPause(false)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !win and Input.is_action_just_pressed("ui_accept"):
		var ball = Ball.instance()
		
		if !lastWin:
			ball.position = Vector2(225, 416)
		else:
			ball.position = Vector2(710, 416)
			
		ball.connect("body_entered", self, "_on_Ball_body_entered")
		add_child(ball)
	
		$Player.myPause(true)
		$Player2.myPause(true)
		
		win = true

func freeBall():
	$Ball.queue_free()
	
#	pass
func reset(var i, var b):
	call_deferred("freeBall")
			
	scores[i] += 1
	
	scoreNodes[i].text = str(scores[i])
	
	lastWin = b
	
	$Player.myPause(false)
	$Player2.myPause(false)
	
	win = false

func _on_Ball_body_entered(body):
	match(body.name):
		"GroundP1":
			print("player1 lose")
			
			reset(1, true)
			
		"GroundP2":
			print("player2 lose")
			
			reset(0, false)
	pass # Replace with function body.
