extends ColorRect

var glow_power = 0.0
var speed = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func start_shader() -> void:
	var shader = get_material()
	shader.set_shader_parameter('hovered',true)
	speed = 0.75

func stop_shader() -> void:
	var shader = get_material()
	shader.set_shader_parameter('hovered',false)
	speed = 0.0
