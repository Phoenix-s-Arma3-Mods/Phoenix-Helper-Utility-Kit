#define PREFIX PHK
#define COMPONENT feature_pushVehicle
#define COMPONENT_BEAUTIFIED PushVehicle

#define DOUBLES(a,b) a##_##b
#define TRIPLES(a,b,c) a##_##b##_##c
#define QUOTE(a) #a
#define GVAR(var) DOUBLES(PREFIX,var)
#define QGVAR(var) QUOTE(GVAR(var))
#define DFUNC(var) TRIPLES(PREFIX,fnc,var)

#define QPATHTOF_REL(var) \PHUKit\feature_pushVehicle\var
