extends Control

@onready var tex_node :TextureRect = $TextureRect;

func _ready() ->void:
	Ui.register_hand(self);

func take(obj_id :String) ->void:
	var obj :GameObject = Story.get_object(obj_id);
	tex_node.texture = obj.get_inventory_texture();
	show();
	set_process(true);

func put_away() ->void:
	hide();
	set_process(false);

func _process(delta :float) ->void:
	position = get_global_mouse_position();
