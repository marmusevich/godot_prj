class_name ArmorState extends BaseState

## ============================================================
## RUNTIME STATE
## ============================================================

var _durability: float
var _modifiers: Array = []   # ModifierState[]

## ============================================================
## INIT
## ============================================================

func _init(definition: ArmorDefinition):
	super(definition)
	_durability = definition.base_durability

## ============================================================
## DEFINITION ACCESS
## ============================================================

func definition() -> ArmorDefinition:
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
## COMPUTED STATS
## ============================================================

func armor_value(side : CommonEnums.HitSide, damage_type : CommonEnums.DamageType) -> float:
	var base = _definition.armor_value(side, damage_type)
	return _apply_modifiers("modify_armor", base, side, damage_type)

func ricochet_chance() -> float:
	return _apply_modifiers("modify_ricochet", _definition.ricochet_chance)

func carry_capacity_bonus() -> float:
	return _apply_modifiers("modify_carry_capacity", _definition.carry_capacity_bonus)

func is_sealed() -> bool:
	return _definition.sealed or _has_modifier("force_sealed")

## ============================================================
## DURABILITY
## ============================================================

func durability() -> float:
	return _durability

func apply_damage(amount: float):
	_durability = clamp(_durability - amount, 0.0, _definition.base_durability)

func is_broken() -> bool:
	return _durability <= 0.0

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
				"is_buff": m.definition.is_buff
			})
	return result

## ============================================================
## INTERNAL
## ============================================================

func _apply_modifiers(method: String, base_value, side = null, damage_type = null):
	var value = base_value
	for m in _modifiers:
		if m.has_method(method):
			value = m.call(method, value, side, damage_type)
	return value

func _has_modifier(method: String) -> bool:
	for m in _modifiers:
		if m.has_method(method):
			return true
	return false
