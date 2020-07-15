extends PanelContainer

#This class is a class for Antimatter Dimensions style producers, 
#ie "Dimensions". Should be a grandchild of a Manager, and have a ProducerDisplayManager
#as a child
class_name Producer

#The tier of the producer. Each producer produces the producer one tier below
#it, as well as money
export(int) var tier = 1

#The current amount of this producer
var amount = 0

#The exponent that the currentCost is raised to on every level up
export(float) var costExponent = 2

#The base cost of the Producer
export(int) var baseCost = 2

#The current cost to level up the producer
var cost

#The amount the current production is multiplied by on each level up
export(float) var productionMultiplier = 2

#The production of a single producer of this level and tier, not including
#the amount
var totalProductionMultiplier

#The base production per amount of this Producer at level 1
export(float) var baseProduction = 1

#The current level of the Producer (how many times it has been bought)
export(int) var level = 0

#The ProducerDisplayManager used to display 
#all of the values for this Producer
var producerDisplayManager

#The Manager that manages money
var manager

#Constructor for this class. Takes values for tier, base cost,
#base production, cost-increase exponent, production multiplier, and initial
#amount, in order
func _init(initTier, initBaseCost, initBaseProduction, initCostIncrease, initProdIncrease, initAmount):
	amount = initAmount
	baseCost = initBaseCost
	tier = initTier
	baseProduction = initBaseProduction
	costExponent = initCostIncrease
	productionMultiplier = initProdIncrease

# Called when the node enters the scene tree for the first time.
#This gets the ProducerDisplayManager responsible for displaying the values
#for this Producer, registers this Producer with the manager, connects 
#the BuyButton to the onBuy() function, and sets the baseCost and 
#productionMultiplier
func _ready():
	producerDisplayManager = get_node("ProducerDisplayManager")
	manager = get_parent().get_parent()
	manager.registerProducer(tier, self)
	producerDisplayManager.get_node("BuyButton").connect("pressed", self, "onBuy")
	cost = baseCost
	productionMultiplier = baseProduction

#Called when the BuyButton is clicked. It checks if the manager has enough
#money to afford the next upgrade, and if so, buys it, increases the level and
#amount, then calles calculateValues()
func onBuy():
	if manager.getMoney() >= cost:
		manager.addMoney(cost * -1)
		level = level + 1
		amount = amount + 1
		calculateValues() #Updates cost too

#Call to recalculate the cost and production of this producer.
func calculateValues():
	cost = pow(baseCost, pow(costExponent, level))
	productionMultiplier = baseProduction * (pow(productionMultiplier, level))

#Causes the producer to produce money
#and/or producers based on the input time
#(in seconds)
func produce(delta):
	#The real, actual, total production of this producer this frame
	var actualProd = productionMultiplier * amount * delta
	manager.addMoney(actualProd)
	if(tier > 1):
		manager.increaseProducer(tier - 1, actualProd)

#Increase the amount of this producer by delta
func increaseAmount(delta):
	amount = amount + delta

#Returns the tier of this producer
func getTier():
	return tier

#Returns the amount of this producer
func getAmount():
	return amount

#Returns the production of this producer
func getProduction():
	return productionMultiplier

#Returns the cost to level up this producer
func getCost():
	return cost

#Returns the level of this producer
func getLevel():
	return level

# Called every frame. 'delta' is the elapsed time since the previous frame.
#Also increases the respective value for this tier of producer
func _process(delta):
	produce(delta)
