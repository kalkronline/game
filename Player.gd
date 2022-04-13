extends KinematicBody

export var max_speed = 12
export var gravity  = 70
export var jump_impulse = 25

var velocity = Vector3.ZERO
var oldpos = Vector3.ZERO
var newpos = Vector3.ZERO
var height = Vector3.ZERO
var changeheight = Vector3.ZERO

onready var pivot = $Pivot

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_gravity(delta)
	jump()
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
	
func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	
	return input_vector.normalized()
	

func apply_movement(input_vector):
	velocity.x = input_vector.x * max_speed
	velocity.z = input_vector.z * max_speed
	
	
	if input_vector != Vector3.ZERO:
		pivot.look_at(translation + input_vector, Vector3.UP)
	

func get_position():
	return self.global_transform.origin

func apply_gravity(delta):
	velocity.y -= gravity * delta
	
func jump():
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_impulse
		newpos = self.get_position()
		if Vector3(-3,0,-3) < newpos - oldpos and newpos - oldpos < Vector3(3,0,3):
			max_speed += 2
			print(max_speed)
			print(oldpos)
			print(newpos)
			oldpos = Vector3.ZERO
		else:
			max_speed = 12
			print("didnt work")
			print(newpos - oldpos)
			print(oldpos)
			print(newpos)
			oldpos = Vector3.ZERO
	if is_on_floor() and !Input.is_action_pressed("jump"):
		if oldpos == Vector3.ZERO:
			oldpos = self.get_position()
			print("GOT")

