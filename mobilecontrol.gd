extends Control
func _ready():
	if OS.get_name() != "Android" and OS.get_name() != "iOS":
		$left.visible = false
		$right.visible = false
		$forward.visible = false
		$brake.visible = false
