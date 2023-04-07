extends GameObject

func examine() ->void:
	if Story.has_flag("despair_reached"):
		start_speech([{ "text" : "S_CUP_AFTER"}]);
	else:
		start_speech([{ "text" : "S_CUP_BEFOR"}]);
