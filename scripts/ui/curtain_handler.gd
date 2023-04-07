extends ColorRect

const fade_speed :float = 1.0;
var fader :Fader;

signal faded;

func _ready() ->void:
	Ui.register_curtain(self);
	fader = Fader.new(self, fade_speed);
	add_child(fader);
	fader.faded.connect(func(): faded.emit());

func fade_out() ->void:
	if ! is_visible() :
		return;
	fader.fade_out();

func fade_in() ->void:
	if is_visible() :
		return;
	fader.fade_in();
