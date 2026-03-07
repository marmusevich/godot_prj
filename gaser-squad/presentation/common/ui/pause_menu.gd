extends SubMenuScreen


func _on_primary_button_activated(id: UiIDs.ButtonId) -> void:
	match id:
		UiIDs.ButtonId.PAUSE_BACK:
			close()
		_:
			push_warning("pause menu::_on_primary_button_activated: wrong ID - ", id)
	
