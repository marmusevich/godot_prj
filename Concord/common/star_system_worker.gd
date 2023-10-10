class_name StarSystemWorker extends Object

############################################################
# WILL BE binding to CPP



# TODO ADD
#  save an load func

enum Planets {
	MERCURY = 1,
	VENUS,
	EARTH,
	MARS,
	# ASTEROID BELT = 5
	JUPITER = 6,
	SATURN,
	URANUS,
	NEPTUNE,
	}

enum JupiterMoons{
	IO = 1, 
	EUROPA, 
	GANYMEDE, 
	CALLISTO
	}


static func calc_radius(nomber : int) -> float :
	#firs mast by 0.4, third = 1
	return 0.4 if nomber < 2 else 0.4 + 0.3 * pow(2, nomber - 2)


static func calc_speed_by_parent(radius : float, parrentMass : float) -> float :
	return 0.0 if is_zero_approx(radius) else sqrt( parrentMass / radius)

static func calc_speed(nomber : int) -> float :
	var radius : float = calc_radius(nomber)
	return 0.0 if is_zero_approx(radius) else sqrt( 1 / radius)



static func generate_info(_state : StarSystemInfo.StarSystemGeneratorState) -> StarSystemInfo :
	# base parrametr will randomaze for each star system
	# curently all relative the Earthearth
	const baseMass :float = 1.0 # mass maybe not need 
	const baseSpeed :float = 29.78 
	
	
	var sun := StarSystemInfo.StarInfo.new()
	sun.tipe = StarSystemInfo.StellarType.NORMAL
	sun.spectr = StarSystemInfo.StellarSpectr.YELLOW
	sun.mass = baseMass * 887
	sun.name  = "The Sun"
	sun.spin = StarSystemInfo.RotationSpin.DIRECT
	
	
	# planets:
	# Mercury, Venus, Earth and Mars; 
	# and four giant planets, including two gas giants, Jupiter and Saturn,
	#                               and two ice giants, named Uranus and Neptune. 

	#--------------------------------------------------------------
	var mercury := StarSystemInfo.PlanetInfo.new()
	mercury.mass = baseMass * 0.5
	mercury.radius = calc_radius(Planets.MERCURY)
	mercury.start_angle  = 0
	mercury.speed = baseSpeed * calc_speed(Planets.MERCURY)
	mercury.size = StarSystemInfo.PlanetSize.TINY
	mercury.name = "Mercury"
	mercury.spin = StarSystemInfo.RotationSpin.DIRECT # direct means same as parent when generate
	mercury.direction = StarSystemInfo.OrbitDirection.DIRECT # direct means same as parent when generate
	
	#--------------------------------------------------------------
	var venus := StarSystemInfo.PlanetInfo.new()
	venus.mass = baseMass * 0.8
	venus.radius = calc_radius(Planets.VENUS)
	venus.start_angle = 0
	venus.speed = baseSpeed * calc_speed(Planets.VENUS)
	venus.size = StarSystemInfo.PlanetSize.SMALL
	venus.name = "Venus"
	venus.spin = StarSystemInfo.RotationSpin.REVERSE # direct means same as parent when generate
	venus.direction = StarSystemInfo.OrbitDirection.REVERSE # direct means same as parent when generate
	
	#--------------------------------------------------------------
	var earth := StarSystemInfo.PlanetInfo.new()
	earth.mass = baseMass
	earth.radius = calc_radius(Planets.EARTH)
	earth.start_angle  = 0
	earth.speed = baseSpeed * calc_speed(Planets.EARTH)
	earth.size = StarSystemInfo.PlanetSize.NORMAL
	earth.name = "Earth"
	earth.spin = StarSystemInfo.RotationSpin.DIRECT # direct means same as parent when generate
	earth.direction = StarSystemInfo.OrbitDirection.DIRECT # direct means same as parent when generate
	
	var moon := StarSystemInfo.MoonInfo.new()
	moon.mass = baseMass * 0.2
	moon.radius = calc_radius(1) #we have only once moon :)
	moon.start_angle = 0
	moon.speed = 1.23*60
	moon.size = StarSystemInfo.PlanetSize.TINY
	moon.name = "Moon"
	moon.spin = StarSystemInfo.RotationSpin.DIRECT # direct means same as parent when generate
	moon.direction = StarSystemInfo.OrbitDirection.DIRECT # direct means same as parent when generate

	earth.objects.append(moon)

	#--------------------------------------------------------------
	# Mars 

	#--------------------------------------------------------------
	#asteroid belt

	#--------------------------------------------------------------
	var jupiter := StarSystemInfo.PlanetInfo.new()
	jupiter.mass = baseMass * 120
	jupiter.radius = calc_radius(Planets.JUPITER) #pass Mars and asteroid belr
	jupiter.start_angle = 0
	jupiter.speed = baseSpeed * calc_speed(Planets.JUPITER)
	jupiter.size = StarSystemInfo.PlanetSize.LARGE
	jupiter.name = "Jupiter"
	jupiter.spin = StarSystemInfo.RotationSpin.DIRECT # direct means same as parent when generate
	jupiter.direction = StarSystemInfo.OrbitDirection.DIRECT # direct means same as parent when generate
	
	var io := StarSystemInfo.MoonInfo.new()
	io.mass = baseMass * 0.3
	io.radius = calc_radius(JupiterMoons.IO)
	io.start_angle  = 0
	io.speed = calc_speed_by_parent(io.radius, jupiter.mass)
	io.size = StarSystemInfo.PlanetSize.TINY
	io.name = "Io"
	io.spin = StarSystemInfo.RotationSpin.DIRECT # direct means same as parent when generate
	io.direction = StarSystemInfo.OrbitDirection.DIRECT # direct means same as parent when generate
	
	var europa := StarSystemInfo.MoonInfo.new()
	europa.mass = baseMass * 0.5
	europa.radius = calc_radius(JupiterMoons.EUROPA)
	europa.start_angle = 0
	europa.speed = calc_speed_by_parent(europa.radius, jupiter.mass)
	europa.size = StarSystemInfo.PlanetSize.SMALL
	europa.name = "Europa"
	europa.spin = StarSystemInfo.RotationSpin.REVERSE # direct means same as parent when generate
	europa.direction = StarSystemInfo.OrbitDirection.REVERSE # direct means same as parent when generate

	var ganymede := StarSystemInfo.MoonInfo.new()
	ganymede.mass = baseMass * 0.9
	ganymede.radius = calc_radius(JupiterMoons.GANYMEDE)
	ganymede.start_angle = 0
	ganymede.speed = calc_speed_by_parent(ganymede.radius, jupiter.mass)
	ganymede.size = StarSystemInfo.PlanetSize.NORMAL
	ganymede.name = "Ganymede"
	ganymede.spin = StarSystemInfo.RotationSpin.DIRECT # direct means same as parent when generate
	ganymede.direction = StarSystemInfo.OrbitDirection.DIRECT # direct means same as parent when generate

	var callisto := StarSystemInfo.MoonInfo.new()
	callisto.mass = baseMass * 1.2
	callisto.radius = calc_radius(JupiterMoons.CALLISTO)
	callisto.start_angle = 0
	callisto.speed = calc_speed_by_parent(callisto.radius, jupiter.mass)
	callisto.size = StarSystemInfo.PlanetSize.NORMAL
	callisto.name = "Callisto"
	callisto.spin = StarSystemInfo.RotationSpin.DIRECT # direct means same as parent when generate
	callisto.direction = StarSystemInfo.OrbitDirection.DIRECT # direct means same as parent when generate

	jupiter.objects.assign( [io, europa, ganymede, callisto] )

	#--------------------------------------------------------------
	var solarSystem : = StarSystemInfo.new()
	solarSystem.star = sun
	solarSystem.objects.assign( [mercury, venus, earth,  moon, jupiter] )

	return solarSystem

