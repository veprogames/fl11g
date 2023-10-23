class_name PlayerDeathEffect
extends Node2D

@onready var audio_player := $AudioStreamPlayer as AudioStreamPlayer
@onready var explosion := $Explosion as Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := get_tree().create_tween()
	var stream := audio_player.stream as AudioStreamWAV
	var stream_length := stream.get_length()
	audio_player.play()
	tween.tween_property(explosion, ^"scale", Vector2.ONE * 3, stream_length)
	tween.parallel().tween_property(explosion, ^"modulate", Color.TRANSPARENT, stream_length)
