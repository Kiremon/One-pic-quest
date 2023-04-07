extends Control

@onready var obj_container :Node = $VFlowContainer;
@export_file var inv_obj_prefub_file;
var inv_obj_prefub :Resource;

func _ready() ->void:
	Ui.register_inv(self);
	inv_obj_prefub = load(inv_obj_prefub_file);

func update_inv() ->void:
	for obj in obj_container.get_children():
		obj.set_to_delete(true);
	
	var inventory :Node = Story.get_inv();
	for obj_id in inventory.get_list():
		var has_obj :bool = false;
		for obj in obj_container.get_children():
			if obj.get_obj_id() == obj_id:
				has_obj = true;
				obj.set_to_delete(false);
		if ! has_obj:
			var new_inv_obj :Node = inv_obj_prefub.instantiate();
			new_inv_obj.set_obj(obj_id);
			obj_container.add_child(new_inv_obj);
	
	for obj in obj_container.get_children():
		if obj.need_to_delete():
			obj.queue_free();



