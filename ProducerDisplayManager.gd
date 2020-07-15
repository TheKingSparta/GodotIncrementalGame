#extends "res://HBoxDisplayManager.gd"
extends HBoxContainer


#This class manages the display of information for
#its parent producer
class_name ProducerDisplayManager

#These variables hold references to their respective elements, that is, the
#displays and the buy button.
var levelDisplay
var buyButton
var amountDisplay
var producerDisplay
var productionDisplay

#The parent Producer for a given PDM, which
#the PDM manages the values for
var producer

var elements = {}

# Called when the node enters the scene tree for the first time.
# Fetches references for all of the ProducerDisplayManager's child nodes.
func _ready():
	findElements() #Fills elements with references to child nodes
	producer = get_parent()
	print(producer.get_name())
	levelDisplay = elements["LevelDisplay"]
	buyButton = elements["BuyButton"]
	amountDisplay = elements["AmountDisplay"]
	producerDisplay = elements["ProducerDisplay"]
	productionDisplay = elements["ProductionDisplay"]

func findElements():
	for child in get_children():
		elements[child.get_name()] = child

#Sets the tier in the ProducerDisplay
func setTier(tier):
	producerDisplay.text = "Producer: " + str(tier)

#Sets the level in the LevelDisplay
func setLevel(level):
	levelDisplay.text = "Level: " + str(level)

#Sets the text in the BuyButton to the cost for this Producer
func setCost(cost):
	#buyButton.text = "Level up for:\n$" + formatValue(cost)
	pass
	
#Sets the amount in the AmountDisplay
func setAmount(amount):
	#amountDisplay.text = "Amount: " + formatValue(amount)
	pass

#Sets the production in the ProductionDisplay
func setProduction(production):
	#productionDisplay.text = "Production: $" + formatValue(production)+ "/s"
	pass

#Called by ._process() whenever the time since the last update exceeds the desired
#time between updates
func updateValues():
	setTier(producer.getTier())
	setAmount(producer.getAmount())
	setCost(producer.getCost())
	setLevel(producer.getLevel())
	setProduction(producer.getProduction() * producer.getAmount())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#updateValues()
	#._process(delta)	#Handles the logic for updateValues()
