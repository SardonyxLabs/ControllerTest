extends RichTextLabel

var lastControllerID = -2 #Bad placeholder
var lastControllerName = "No inputs detected yet..."

var controllerIDs = ""
var controllerNames = ""

var updateDeadZone = 0.5 #absolutley massive deadzone, likely could remain stable at 0.2-0.3

func _input(event):
	if event is InputEventJoypadButton or event is InputEventJoypadMotion: #bad way of checking if input is a controller
		if event is InputEventJoypadMotion:
			if event.axis_value > updateDeadZone or event.axis_value < -updateDeadZone:
				lastControllerID = event.device
				lastControllerName =  Input.get_joy_name(event.device) + ", " + String(event.axis_value)

func _process(_delta):
	if Input.get_connected_joypads().size() > 0:
		for i in Input.get_connected_joypads():
			controllerIDs = String(i) + ", "
			controllerNames = Input.get_joy_name(i) + ", "
		#Yes, this is a very ugly. Mostly a debugging feature
		text = "Connected Controller IDs: \n" + controllerIDs
		text += "\nConnected Controller Names: \n" + controllerNames
		text += "\nLast ID, Name, Axis Position\n" + String(lastControllerID) + ", " + lastControllerName
	else:
		text = "Waiting For Controllers..."
