#define PREFIX PHK
#define COMPONENT core
#define COMPONENT_BEAUTIFIED Core

// Minimal local macros (avoid external includes during build)
#define DOUBLES(a,b) a##_##b
#define TRIPLES(a,b,c) a##_##b##_##c
#define QUOTE(a) #a
#define GVAR(var) DOUBLES(PREFIX,var)
#define QGVAR(var) QUOTE(GVAR(var))
#define DFUNC(var) TRIPLES(PREFIX,fnc,var)

#define QPATHTOF_REL(var) \PHUKit\core\var

// Simple logger
#define LOG(M) diag_log text format ["[%1|%2] %3", QUOTE(PREFIX), QUOTE(COMPONENT), M]
