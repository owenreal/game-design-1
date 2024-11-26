extends BaseItem


func _init(): super._init(20) # 1 new heart

func interact(player):
	player.pickup_container(value)
	remove()
