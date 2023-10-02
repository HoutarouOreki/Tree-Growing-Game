class_name DogRadialMenu extends RadialMenu


var dog: Dog
var command_callable_dic: Dictionary


func _init(dog: Dog) -> void:
	self.dog = dog
	command_callable_dic = {
		"sit": dog.on_sit,
		"free": dog.set_idle,
		"follow": dog.on_follow,
		"pet": dog.on_pet
	}
	selected.connect(on_selected)
	var command_names: Array[String] = []
	command_names.append_array(command_callable_dic.keys())
	super._init(command_names)


func on_selected(command_name: String) -> void:
	var callable: Callable = command_callable_dic[command_name]
	callable.call()
