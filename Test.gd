extends HBoxContainer

var producer

# Called when the node enters the scene tree for the first time.
func _ready():
	producer = get_parent()
	print(producer.get_name())
	producer.setAmount("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
