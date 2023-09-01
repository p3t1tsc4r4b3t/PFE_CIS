#ifndef T
#define T 2.000  /* period (s) */
#endif

#ifndef M
#define M 16 /* No. of Fourier coefs. */ 
#endif

#ifndef R
#define R 0.008 /* vessel radius (m) */
#endif

#ifndef rho
#define rho 1060.0 /* fluid density (kg/m^3) */
#endif

#ifndef nu
#define nu 3.333e-06 /* fluid visc. (m^2/s) */
#endif

#ifndef PI 
#define PI 4.0*atan(1.0) /* 3.14.... */
#endif

#ifndef Wo
#define Wo R*sqrt(2*PI/T/nu) /* Womersley No. */
#endif
