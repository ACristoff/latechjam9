extends GPUParticles2D

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func bleed():
	emitting = true
	gpu_particles_2d.emitting = true


func _on_finished() -> void:
	queue_free()
