extends Resource
class_name ArmorDefinition

## ============================================================
## ENUMS
## ============================================================

enum ArmorSlot {
	HEAD,        # Head slot (шлем)
	BODY,        # Body / torso
	LEGS,        # Legs
	FULL_BODY    # Full body (скафандр, экзоскелет)
}

enum Platform {
	INFANTRY,    # Infantry (человек)
	DRONE,       # Drone
	VEHICLE      # Vehicle (танк, БТР)
}

enum DamageType {
	KINETIC,     # Kinetic (кинетический)
	ENERGY,      # Energy (энергетический)
	THERMAL      # Thermal (термический)
}

enum HitSide {
	FRONT,       # Front (перед)
	BACK,        # Back (зад)
	LEFT,        # Left
	RIGHT        # Right
}

## ============================================================
## IDENTITY
## ============================================================

@export var id: String
@export var display_name: String
@export var icon: Texture2D

## ============================================================
## CLASSIFICATION
## ============================================================

@export var slot: ArmorSlot
@export var allowed_platforms: Array[Platform]

## ============================================================
## ECONOMY & META
## ============================================================

@export var price: int = 0              # Price (цена)
@export var weight: float = 0.0         # Weight (вес)

## ============================================================
## ARMOR PROTECTION
## ============================================================
## armor[HitSide][DamageType] = value

@export var armor := {
	HitSide.FRONT: {
		DamageType.KINETIC: 0.0,
		DamageType.ENERGY: 0.0,
		DamageType.THERMAL: 0.0
	},
	HitSide.BACK: {
		DamageType.KINETIC: 0.0,
		DamageType.ENERGY: 0.0,
		DamageType.THERMAL: 0.0
	},
	HitSide.LEFT: {
		DamageType.KINETIC: 0.0,
		DamageType.ENERGY: 0.0,
		DamageType.THERMAL: 0.0
	},
	HitSide.RIGHT: {
		DamageType.KINETIC: 0.0,
		DamageType.ENERGY: 0.0,
		DamageType.THERMAL: 0.0
	}
}

@export var ricochet_chance: float = 0.0   # Ricochet chance (вероятность рикошета)

## ============================================================
## ENVIRONMENTAL
## ============================================================

@export var sealed: bool = false          # Sealed suit (герметичность)
@export var radiation_resistance: float = 0.0  # Radiation resist (опц.)

## ============================================================
## SUPPORT / AUGMENTATION
## ============================================================

@export var carry_capacity_bonus: float = 0.0
# Carry capacity bonus (бонус к грузоподъёмности — экзоскелет)

## ============================================================
## DURABILITY
## ============================================================

@export var base_durability: float = 1.0  # Base durability (базовая прочность)

## ============================================================
## HELPERS
## ============================================================

func supports_platform(platform: Platform) -> bool:
	return platform in allowed_platforms

func armor_value(side: HitSide, damage_type: DamageType) -> float:
	return armor.get(side, {}).get(damage_type, 0.0)
