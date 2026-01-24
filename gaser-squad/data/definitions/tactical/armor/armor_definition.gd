extends BaseDefinition
class_name ArmorDefinition

const CommonEnums = preload("res://data/definitions/tactical/enums.gd")

## ============================================================
## ENUMS
## ============================================================

enum ArmorSlot {
	HEAD,        # Head slot (шлем)
	BODY,        # Body / torso
	LEGS,        # Legs
	FULL_BODY    # Full body (скафандр, экзоскелет)
}


## ============================================================
## CLASSIFICATION
## ============================================================

@export var slot: ArmorSlot
@export var allowed_platforms: Array[CommonEnums.Platform]


## ============================================================
## ARMOR PROTECTION
## ============================================================
## armor[HitSide][DamageType] = value

@export var armor := {
	CommonEnums.HitSide.FRONT: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
	},
	CommonEnums.HitSide.BACK: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
	},
	CommonEnums.HitSide.LEFT: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
	},
	CommonEnums.HitSide.RIGHT: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
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

func supports_platform(platform: CommonEnums.Platform) -> bool:
	return platform in allowed_platforms

func armor_value(side: CommonEnums.HitSide, damage_type: CommonEnums.DamageType) -> float:
	return armor.get(side, {}).get(damage_type, 0.0)
