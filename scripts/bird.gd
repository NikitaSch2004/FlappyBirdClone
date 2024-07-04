extends Node2D

signal point
signal ground
func _on_area_2d_area_entered(area):
	if area.is_in_group("point"):
		emit_signal("point")
	elif area.is_in_group("ground"):
		emit_signal("ground")
