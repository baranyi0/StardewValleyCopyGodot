extends Label


onready var money_label = $"."

func _process(delta):
	money_label.text = "Money: " + str(Global.MONEY)
