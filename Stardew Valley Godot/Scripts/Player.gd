extends KinematicBody2D

var speed := 50.0
var idle_frames := [0, 1]
var walk_frames := [8, 9, 10, 11, 12, 13, 14, 15]
var current_frame := 0
var frame_time := 0.1
var time_since_last_frame := 0.0
onready var sprite = $Sprite

func _process(delta):
	var x_axis = Input.get_axis("ui_left", "ui_right")
	var y_axis = Input.get_axis("ui_up", "ui_down")
	var input := Vector2(x_axis, y_axis).normalized()
	
	var velocity := input * speed
	velocity = move_and_slide(velocity)

	if input == Vector2(0, 0):
		play_animation(idle_frames, delta / 2)
	else:
		play_animation(walk_frames, delta)
		
		sprite.flip_h = input.x > 0

func play_animation(frames, delta):
	time_since_last_frame += delta
	if time_since_last_frame >= frame_time:
		time_since_last_frame = 0.0
		if current_frame < frames.size() - 1:
			current_frame += 1
		else:
			current_frame = 0
		sprite.frame = frames[current_frame]
