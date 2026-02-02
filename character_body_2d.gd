extends CharacterBody2D
const speed = 200
const rotspd = 10
const maxrotspd = 30
const drift = 0.1
var inputx
var inputy
var brake
var speeddir = 100
var rotdir = 0
var leftp = 0
var rightp = 0
var forwardp = 0
var brakep = 0
@onready var particles = $point/particles
@onready var right = get_node("/root/main/uilayer/mobilecontrol/right")
@onready var left = get_node("/root/main/uilayer/mobilecontrol/left")
@onready var forward = get_node("/root/main/uilayer/mobilecontrol/forward")
@onready var brakeb = get_node("/root/main/uilayer/mobilecontrol/brake")
func _ready():
	left.connect("button_down", _on_left_pressed)
	left.connect("button_up", _on_left_released)
	right.connect("button_down", _on_right_pressed)
	right.connect("button_up", _on_right_released)
	forward.connect("button_down", _on_forward_pressed)
	forward.connect("button_up", _on_forward_released)
	brakeb.connect("button_down", _on_brake_pressed)
	brakeb.connect("button_up", _on_brake_released)
func _physics_process(delta: float):
	var right = transform.y
	var forward = transform.x
	inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") + rightp - leftp
	inputy = Input.get_action_strength("ui_up")+forwardp
	brake = Input.get_action_strength("ui_down")+brakep
	if brake > 0:
		speeddir *= 0.6
	speeddir += speed * delta * inputy
	rotdir += rotspd * delta * inputx
	rotdir *= 0.96
	speeddir *= 0.99
	if rotdir >= maxrotspd:
		rotdir = maxrotspd
	rotation += rotdir*delta
	var target_velocity = forward * speeddir
	velocity = velocity.lerp(target_velocity, drift * delta * 10)
	if inputy > 0:
		particles.emitting = true
	else:
		particles.emitting = false
	move_and_slide()
	right
func _on_right_pressed() -> void:
	rightp = 1
func _on_right_released() -> void:
	rightp = 0
func _on_left_pressed() -> void:
	leftp = 1
func _on_left_released() -> void:
	leftp = 0
func _on_forward_pressed() -> void:
	forwardp = 1
func _on_forward_released() -> void:
	forwardp = 0
func _on_brake_pressed() -> void:
	brakep = 1
func _on_brake_released() -> void:
	brakep = 0
