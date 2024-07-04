extends Node2D
@onready var txt = $points
@onready var timer = $Timer
@onready var player = $bird
var rng = RandomNumberGenerator.new()
var counter = 0
var dead = false
var played = false
func _ready(): 
	timer.wait_time = 2.0
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()
	
	if player:
		player.connect("point", Callable(self, "_on_object_point"))
	
func _on_Timer_timeout():
	var pipe = load("res://scenes/pipes.tscn").instantiate()
	if pipe:
		pipe.connect("died", Callable(self, "_on_object_died"))
	spawn_object(pipe)  # Example initial position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	txt.text = str(counter)
	if dead and not played:
		$Label2/AnimationPlayer.play("fade-in")
		played = true
	if dead and Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()
	
func spawn_object(pipe):
	var my_random_number = rng.randf_range(-15.0, 35.0)
	pipe.position = Vector2(150,my_random_number)
	add_child(pipe)

func _on_object_died():
	print("Object has died, stopping the timer.")
	dead = true
	timer.stop()

func _on_object_point():
	print("+Point")
	counter += 1;
	
