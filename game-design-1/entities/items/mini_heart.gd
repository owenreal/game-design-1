extends BaseItem

func _init(): super._init(5) # 1/4 heart

func interact(player):
	player.pickup_health(value)
	self.aud_player.stream = soundF
	self.aud_player.play()
	await self.aud_player.finished
	remove()
