#define PREFIX PHK
#define COMPONENT feature_vehicleSpawner
#define COMPONENT_BEAUTIFIED VehicleSpawner

#define DOUBLES(a,b) a##_##b
#define TRIPLES(a,b,c) a##_##b##_##c
#define QUOTE(a) #a
#define GVAR(var) DOUBLES(PREFIX,var)
#define QGVAR(var) QUOTE(GVAR(var))
#define DFUNC(var) TRIPLES(PREFIX,fnc,var)

#define QPATHTOF_REL(var) \feature_vehicleSpawner\var
