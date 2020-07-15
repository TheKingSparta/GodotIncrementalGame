extends HBoxContainer

#This is a helper class for updating lavels. It basically is just an HBoxContainer
#With a couple helper methods that should be useful for most things that
#need to update values. It also has an elements property, which has the 
#name of every child node and a reference to it.
class_name HBoxDisplayManager

#The number of miliseconds between each update
#of all of the values this DisplayManager controls
export(int) var timeBetweenUpdates = 100

#This is a dict that holds all child elements of the HBoxDisplayManager
#Format: elements["childName"] == referenceToChild
var elements = {}

#The time since the last time values were
#updated
var timeSinceLastUpdate = 0

# Called when the node enters the scene tree for the first time.
#Includes the code for filling elements
func _ready():
	findElements()

func findElements():
	for child in get_children():
		elements[child.get_name()] = child

#Sets the text of the child with the specified name to value
func setText(name, value):
	elements[name].text = str(value)

#This is called every time the timeSinceLastUpdate exceeds timeBetweenUpdates.
#Does nothing by itself, and is just a virtual function
func updateValues():
	pass

#Formats the input number and returns it in scientific
#notation if 10,000 or greater, and with two decimals if less.
func formatValue(value) -> String:
	var exponent = str(value).split(".")[0].length() - 1
	if(exponent > 3):
		var mantissa = value / pow(10, exponent)
		return str(mantissa).pad_decimals(2) + "e" + str(exponent)
	else:
		return str(value).pad_decimals(2)
	

# Includes the code for calling updateValues()
func _process(delta):
	timeSinceLastUpdate += delta * 1000
	if(timeSinceLastUpdate >= timeBetweenUpdates):
		updateValues()
		timeSinceLastUpdate = 0
