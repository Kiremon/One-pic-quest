extends Line2D

@export var key_increase :Thesaurus.MOVE_KEYS;#кнопка движения по оси
@export var key_decrease :Thesaurus.MOVE_KEYS;#кнопка движения против оси
@export var scale_change :float = 0.0;#изменение масштаба за один шаг по оси
@export var speed_modifier :float = 1.0;#модификатор скорости перемещения по локации для данной оси
@export var is_perspective :bool = false;#рассматривать ли вторую точку линии как точку схода перспективы

var direction :Vector2;

func _ready() ->void:
	direction = points[1].normalized();

func get_direction(key_id :int) ->Vector2:
	var way_mod :int = 1;
	if key_id == key_decrease:
		way_mod = -1;
	if is_perspective:
		pass; #здесь должна быть математика для рассчёта перспективы
	
	return direction * way_mod;

func get_speed_modifier() -> float:
	return speed_modifier;

func get_scale_change() -> float:
	return scale_change;

func has_key(key_id :int) ->bool:
	return key_id == key_increase or key_id == key_decrease;
