# res://data/definitions/weapon_definition.gd
extends Resource
class_name WeaponDefinition

## ============================================================
## ENUMS
## ============================================================

enum WeaponCategory {
	MELEE,        # Melee weapon (нож, дубинка)
	FIREARM,      # Firearms (пистолет, автомат)
	THROWN,       # Thrown (гранаты)
	LASER,
	PLASMA
}

enum WeaponPlatform {
	INFANTRY,     # Infantry (пехота)
	DRONE,        # Drones
	VEHICLE       # Vehicles (колёсная/гусеничная техника)
}

enum DamageType {
	KINETIC,      # Kinetic (кинетический)
	ENERGY,       # Energy (энергетический)
	THERMAL       # Thermal (термический)
}

enum Handling {
	ONE_HANDED,   # One-handed (одноручное)
	TWO_HANDED    # Two-handed (двухручное)
}

## ============================================================
## IDENTITY
## ============================================================

@export var id: String
@export var display_name: String
@export var icon: Texture2D

## ============================================================
## ECONOMY & META
## ============================================================

@export var price: int = 0              # Price (цена)
@export var weight: float = 0.0         # Weight (вес)

## ============================================================
## CLASSIFICATION
## ============================================================

@export var category: WeaponCategory
@export var damage_type: DamageType     # Damage type (тип урона)
@export var handling: Handling          # One / two handed (одноручное / двухручное)

@export var allowed_platforms: Array[WeaponPlatform]

## ============================================================
## BASE COMBAT STATS
## ============================================================

@export var base_damage: float = 0.0     # Base damage (базовый урон)
@export var armor_penetration: float = 0.0  # Armor penetration (пробитие брони)

@export var range: float = 0.0           # Effective range (дальность)
@export var damage_radius: float = 0.0   # Damage radius (радиус урона)

@export var spread: float = 0.0          # Bullet spread (разброс)
@export var recoil: float = 0.0          # Recoil (отдача)
@export var noise: float = 0.0           # Noise level (шум)

## ============================================================
## AMMO & DURABILITY
## ============================================================

# fragment only
@export var ammo_type: String = ""   # Ammo type / caliber (тип боеприпаса)

@export var magazine_capacity: int = 0   # Magazine size (ёмкость магазина)
@export var reload_time: float = 0.0     # Reload time (перезарядка)

@export var base_durability: float = 1.0 # Base durability (базовая прочность)

## ============================================================
## SKILL REQUIREMENTS
## ============================================================

@export var required_skills := {}        # { "rifles": 2, "heavy_weapons": 1 }

## ============================================================
## HELPERS
## ============================================================

func supports_platform(platform: WeaponPlatform) -> bool:
	return platform in allowed_platforms

func uses_ammo() -> bool:
	return magazine_capacity > 0
	
