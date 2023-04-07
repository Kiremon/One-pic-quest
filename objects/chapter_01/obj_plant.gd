extends GameObject

var is_watered :bool = false;
signal watered;

func water_me() ->void:
	if ! Story.has_flag("despair_reached"):
		start_speech([{ "text" : "S_PLANT_CUP_BEFOR"}]);
		return;
	if is_watered :
		combine_failed();
		return;
	is_watered = true;
	var flag_list :Array = [
		"plant_watered_1",
		"plant_watered_2",
		"plant_watered_3"
	];
	for flag in flag_list:
		if ! Story.has_flag(flag):
			Story.set_flag(flag, true);
			break;
	watered.emit();
	Sound.play_sfx("plant_watering");
	if Story.has_flag("plant_watered_3"):
		start_speech([{ "text" : "S_PLANT_MUSIC"}]);
