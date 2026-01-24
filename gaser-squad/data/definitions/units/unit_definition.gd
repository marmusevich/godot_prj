extends BaseDefinition
class_name UnitDefinition

@export var platform: int = CommonEnums.Platform.INFANTRY
# Platform of the unit (платформа юнита)

@export var base_health: float = 1.0
# Base health (базовое здоровье)

@export var base_fatigue: float = 0.0
# Base fatigue (базовая усталость)

@export var base_morale: float = 1.0
# Base morale (базовая мораль)

@export var base_action_points: int = 2
# Base action points (базовые очки действий)

@export var base_carry_capacity: float = 20.0
# Base carry capacity (базовая грузоподъёмность)

@export var starting_items: Array[ItemDefinition] = []
# Starting inventory items (стартовые предметы)

@export var starting_weapons: Array[WeaponDefinition] = []
# Starting weapons (стартовое оружие)

@export var starting_armor: Array[ArmorDefinition] = []
# Starting armor (стартовая броня)

@export var starting_skills := {}
# Starting skills + aptitude (стартовые скиллы и предрасположенность)
# Example: { "rifles": { "aptitude": 0.7, "level": 1 } }
