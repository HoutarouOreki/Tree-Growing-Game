class_name InputHelper


static func is_action_press(action: StringName, event: InputEvent) -> bool:
	return event.is_action(action) && Input.is_action_just_pressed(action)
