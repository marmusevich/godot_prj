class_name UnitDefinition extends Resource

## ID of the definition (идентификатор)
@export var id: String           
## Display name (отображаемое имя)
@export var display_name: String 
## Icon for UI (иконка для интерфейса)
@export var icon: Texture2D      

## Platform of the unit (платформа юнита)
@export var platform: int = CommonEnums.Platform.INFANTRY

## Base health (базовое здоровье)
@export var base_health: float = 1.0

## Base fatigue (базовая усталость)
@export var base_fatigue: float = 0.0

## Base morale (базовая мораль)
@export var base_morale: float = 1.0

## Base action points (базовые очки действий)
@export var base_action_points: int = 2

## Base carry capacity (базовая грузоподъёмность)
@export var base_carry_capacity: float = 20.0

## Starting inventory items (стартовые предметы)
@export var starting_items: Array[ItemDefinition] = []

## Starting weapons (стартовое оружие)
@export var starting_weapons: Array[WeaponDefinition] = []

## Starting armor (стартовая броня)
@export var starting_armor: Array[ArmorDefinition] = []

## Starting skills + aptitude (стартовые скиллы и предрасположенность)
## Example: { "rifles": { "aptitude": 0.7, "level": 1 } }
@export var starting_skills := {}
