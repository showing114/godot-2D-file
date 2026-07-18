extends Control;
@onready var label_score_number: Label = $Panel/MarginContainer/HBoxContainer/LabelScoreNumber;

func _process(delta: float) -> void:
	label_score_number.text = str(GameManager.score);
