# res://data/state/weapon_state.gd
class_name WeaponState
extends Object

## ============================================================
## DEFINITION (WRITE-ONCE)
## ============================================================

var _definition: WeaponDefinition

## ============================================================
## RUNTIME STATE
## ============================================================

var _ammo: int
var _durability: float

var _modifiers: Array = []   # ModifierState[]

## ============================================================
## INIT
## ============================================================

func _init(definition: WeaponDefinition):
	assert(definition != null, "WeaponState requires WeaponDefinition")
	_definition = definition
	_ammo = definition.magazine_capacity
	_durability = definition.base_durability

## ============================================================
## DEFINITION ACCESS
## ============================================================

func definition() -> WeaponDefinition:
	return _definition

## ============================================================
## MODIFIERS
## ============================================================

func add_modifier(modifier):
	_modifiers.append(modifier)

func remove_modifier(modifier):
	_modifiers.erase(modifier)

func modifiers() -> Array:
	return _modifiers.duplicate()

## ============================================================
## COMPUTED STATS (ONLY VIA FUNCTIONS)
## ============================================================

func damage() -> float:
	return _apply_modifiers("modify_damage", _definition.base_damage)

func armor_penetration() -> float:
	return _apply_modifiers("modify_armor_penetration", _definition.armor_penetration)

func spread() -> float:
	return _apply_modifiers("modify_spread", _definition.spread)

func recoil() -> float:
	return _apply_modifiers("modify_recoil", _definition.recoil)

func noise() -> float:
	return _apply_modifiers("modify_noise", _definition.noise)

## ============================================================
## AMMO
## ============================================================

func ammo() -> int:
	return _ammo

func can_fire() -> bool:
	return not _definition.uses_ammo() or _ammo > 0

func consume_ammo():
	if _definition.uses_ammo():
		_ammo = max(0, _ammo - 1)


# простой вариант
#func reload():
#	_ammo = _definition.magazine_capacity
func reload(inventory: InventoryState) -> bool:
	if not _definition.uses_ammo():
		return false

	var ammo_item = inventory.find_ammo(_definition.ammo_type)
	if ammo_item == null:
		return false

	var needed = _definition.magazine_capacity - _ammo
	if needed <= 0:
		return false

	var taken = min(needed, ammo_item.quantity)
	ammo_item.quantity -= taken
	_ammo += taken
	return true


## ============================================================
## DURABILITY
## ============================================================

func durability() -> float:
	return _durability

func apply_damage(amount: float):
	_durability = clamp(_durability - amount, 0.0, _definition.base_durability)


## ============================================================
## UI / EFFECTS
## ============================================================

func active_effects_description() -> Array:
	var result := []
	for m in _modifiers:
		if m.definition:
			result.append({
				"name": m.definition.display_name,
				"description": m.definition.description,
				"is buff": m.definition.is_buff
			})
	return result



## ============================================================
## INTERNAL
## ============================================================

func _apply_modifiers(method: String, base_value):
	var value = base_value
	for m in _modifiers:
		if m.has_method(method):
			value = m.call(method, value)
	return value
