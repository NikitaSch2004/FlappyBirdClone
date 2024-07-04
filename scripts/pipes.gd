extends Node2D;

signal died
var speed = 100
var dead = false
var player = load("res://scenes/bird.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		player.connect("ground", Callable(self, "_on_top_area_entered"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead == true:
		speed = 0
	position.x -= speed*delta
	if position.x < -160:
		queue_free()
		print("deleted")
		


func _on_top_area_entered(area):
	if area.is_in_group("player"):
		dead = true
		emit_signal("died")


func _on_bottom_area_entered(area):
	if area.is_in_group("player"):
		dead = true
		emit_signal("died")
