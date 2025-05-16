class_name StarSystemInfo extends Object

# DIRECT means clockwise
enum RotationSpin {DIRECT = 1, REVERSE = -1}
# DIRECT means clockwise
enum OrbitDirection { DIRECT = 1, REVERSE = -1 }


enum StellarType {	GIANT, NORMAL, DWARF }
enum StellarSpectr {BLUE, WHITE, YELLOW, ORANGE, RED, BROWN}


enum PlanetSize { TINY, SMALL, NORMAL, BIG, LARGE }


class StarInfo extends Object:
	var tipe : = StellarType.NORMAL # type
	var spectr : = StellarSpectr.YELLOW
	var mass : float = 0
	var name : StringName = ""
	var spin : = RotationSpin.DIRECT


class PlanetaryInfo extends Object:
	var mass : float = 0
	var speed : float = 0
	var radius : float = 0
	var start_angle : float = 0
	var size : = PlanetSize.NORMAL
	var name : StringName = ""
	# direct means same as parent when generate
	var spin : = RotationSpin.DIRECT
	# direct means same as parent when generate
	var direction : = OrbitDirection.DIRECT


#
class PlanetInfo extends PlanetaryInfo:
	# moons or rings
	var objects : Array[MoonInfo] = []

#
class MoonInfo extends PlanetaryInfo:
	pass


class RingInfo extends PlanetaryInfo:
	pass


class AsteroidBeltInfo extends PlanetaryInfo:
	pass
	
# usese to save / load of state, i.e ranom state or other	
class StarSystemGeneratorState extends Object:
	pass

#---------------------------------------------------
var star : StarInfo
# planets or asteroid belt
var objects : Array[PlanetaryInfo] = []
