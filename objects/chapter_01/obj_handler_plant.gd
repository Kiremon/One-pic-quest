extends ObjectHandler

func _after_load() ->void:
	super();
	obj_node.watered.connect(water_me);

func water_me() ->void:
	get_node("watered").show();
