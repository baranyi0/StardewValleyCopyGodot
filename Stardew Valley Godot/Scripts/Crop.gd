extends Node2D


export var price = 3
export var crop_frames := [0, 1, 2, 3, 4]
export var grow_time := 20
export var harvest_delay := 1.0 

var current_frame := 0
var time_since_last_frame := 0.0
var time_since_fully_grown := 0.0
var is_fully_grown := false

onready var sprite = $Sprite


func _process(delta):
	if is_fully_grown:
		time_since_fully_grown += delta
		if time_since_fully_grown >= harvest_delay:
			Global.MONEY += price
			queue_free()
	else:
		play_animation(crop_frames, delta)


func play_animation(frames, delta):
	time_since_last_frame += delta
	if time_since_last_frame >= grow_time:
		time_since_last_frame = 0.0
		if current_frame < frames.size() - 1:
			current_frame += 1
			sprite.frame = frames[current_frame]
		elif current_frame == frames.size() - 1:
			# Crop is fully grown
			is_fully_grown = true
			time_since_fully_grown = 0.0
