extends SubMenuScreen


func _on_primary_button_activated(id: UIIds.ButtonId) -> void:
	match id:
		UIIds.ButtonId.OPTION_BACK:
			close()
		_:
			push_warning("option menu::_on_primary_button_activated: wrong ID - ", id)
	
