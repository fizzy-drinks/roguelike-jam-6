extends RichTextLabel


var time: float = 1


func _process(delta):
	time -= delta
	
	if time <= 0:
		queue_free()
