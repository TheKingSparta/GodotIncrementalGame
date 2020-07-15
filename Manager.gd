extends Panel

#This file defines a "Manager", a class that creates and controls Producers,
#as well as displays and manages current money
class_name Manager

#The current amount of money
export(float) var money

#The CurrencyManager responsible for displaying the currencies 
var currencyManager

#A dict to hold all of the registered producers
var registeredProducers = {}

func _ready():
	#Fetch the CurrencyManager responsible for displaying the currencies of this game
	currencyManager = get_node("CurrencyBar/CurrencyManager")
	

#Call to register a producer to this Manager. Inputs are the producer's tier,
#and the producer itself. Only one producer of a given tier can be registered
func registerProducer(tier, nodeReference):
	registeredProducers[tier] = nodeReference

#Update the MoneyDisplay Label every frame with the current money
func _process(_delta):
	pass

#Increase money by the input amount. Input negative numbers to decrease money
func addMoney(amount):
	money = money + amount

#Returns the current amount of money
func getMoney():
	return money

#Formats the input number and returns it in scientific
#notation
#This exists in HBoxDisplayManager, so I should probably just make a
#class for it, buuuuut...
func formatValue(value) -> String:
	var exponent = str(value).split(".")[0].length() - 1
	if(exponent > 3):
		var mantissa = value / pow(10, exponent)
		return str(mantissa).pad_decimals(2) + "e" + str(exponent)
	else:
		return str(value).pad_decimals(2)

#Increases the amount of the Producer with the specified tier by the specified
#amount
func increaseProducer(tier, amount):
	if registeredProducers[tier] != null:
		registeredProducers[tier].increaseAmount(amount)
