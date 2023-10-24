extends Node2D

@export var particles: GPUParticles2D
@export var environment: WorldEnvironment

var environment_resource: Environment
var base_glow_intensity := 1.0
var effect := AudioServer.get_bus_effect_instance(1, 0) as AudioEffectSpectrumAnalyzerInstance

func _ready() -> void:
	if environment:
		environment_resource = environment.environment
		base_glow_intensity = environment_resource.glow_intensity
	if effect == null:
		push_warning("effect instance not found")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if effect != null:
		var intensity := effect.get_magnitude_for_frequency_range(20, 20000).length() * 5.0
		if particles:
			particles.speed_scale = 0.5 + 2.5 * intensity
		if environment_resource:
			environment_resource.glow_intensity = base_glow_intensity * (1 + intensity)
