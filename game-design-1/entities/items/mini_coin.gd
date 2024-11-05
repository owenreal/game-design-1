extends BaseItem

func _init(): super._init(1) # 1 coin

func interact(player):
	player.pickup_money(value)
	remove()
