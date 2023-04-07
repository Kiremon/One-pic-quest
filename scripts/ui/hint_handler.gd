extends Control

@onready var text_node :Label = $CenterContainer/text;

func _ready() ->void:
	Ui.register_hint(self);

func show_hint(hint :String) ->void:
	text_node.text = hint;
	show();

func hide_hint() ->void:
	hide();
