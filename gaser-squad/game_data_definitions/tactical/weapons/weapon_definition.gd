class_name WeaponDefinition extends BaseDefinition

# ============================================================
# CLASSIFICATION
# ============================================================

## Weapon category (категория оружия)
@export var category: int = CommonEnums.WeaponCategory.FIREARM
## Damage type (тип урона)
@export var damage_type: int = CommonEnums.DamageType.KINETIC
## One / two handed (одноручное / двухручное)
@export var handling: int = CommonEnums.Handling.ONE_HANDED
## Allowed platforms (куда можно экипировать)
@export var allowed_platforms: Array[CommonEnums.Platform] = []

# ============================================================
# BASE COMBAT STATS
# ============================================================

## Base damage (базовый урон)
@export var base_damage: float = 0.0
## Armor penetration (пробитие брони)
@export var armor_penetration: float = 0.0
## Effective range (дальность)
@export var range: float = 0.0
## Damage radius (радиус урона)
@export var damage_radius: float = 0.0
## Bullet spread (разброс)
@export var spread: float = 0.0
## Recoil (отдача)
@export var recoil: float = 0.0
## Noise level (шум)
@export var noise: float = 0.0

# ============================================================
# AMMO & DURABILITY
# ============================================================

## Ammo type / caliber (тип боеприпаса)
@export var ammo_type: String = ""
## Magazine size (ёмкость магазина)
@export var magazine_capacity: int = 0
## Reload time (перезарядка)
@export var reload_time: float = 0.0
## Base durability (базовая прочность)
@export var base_durability: float = 1.0

# ============================================================
# SKILL REQUIREMENTS
# ============================================================

## требуемые навыки { "rifles": 2, "heavy_weapons": 1 }
@export var required_skills := {}

# ============================================================
# HELPERS
# ============================================================

func supports_platform(platform: CommonEnums.Platform) -> bool:
	return platform in allowed_platforms

func uses_ammo() -> bool:
	return magazine_capacity > 0
