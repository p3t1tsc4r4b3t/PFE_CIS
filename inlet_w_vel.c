/***************************************************************/

/* Womersley inlet velocity profile with Bessel Functions for Fluent */
/* Fourier Amplitudes are computed in a companion Matlab file "Wom_wave.m" */

/* Libraries info:

   udf.h -- Fluent UDF library
   complex_rec.h -- complex data type declaration
   zbes.h -- computes Bessel function of 1st kind integer order; series representation
   complex_ops.h -- complex arithmetic operations declaration
   parameters.h -- fluid parameters (viscosity, density, etc....)

*/

/* Created by P. McGah */
/**************************************************************/

#include "udf.h"
#include "parameters.h"

FILE *fourier;
double vel_i[M], vel_r[M];
double v_peak;
double w_vel(int nfour, double *vel_r, double *vel_i, double t);



/* Main Program -- Defines velocity at inlet zone */

DEFINE_PROFILE(prox_art_vel, thread, position) 
{   
  int n;

  double t, r;
  real x[ND_ND];

  double xo = 0.004153;
  double yo = -0.020060 ;
  double zo = -0.007001;

  face_t f;
 
  /**************************************/
  /* LOADS FOURIER AMPLITUDES */

  fourier=fopen("LPM_EH2_1600RPM.txt","r");

  for (n=0;n<M;n++){
    fscanf(fourier,"%lf", &vel_i[n]);  /* Sine comp. */   
  }
  for (n=0;n<M;n++){
    fscanf(fourier,"%lf", &vel_r[n]);  /* Cosine comp. */
  }
  fclose(fourier);  

  /*************************************/   
   
  t = RP_Get_Real("flow-time");
  
  v_peak = w_vel(M, vel_r, vel_i, t);
  
  begin_f_loop(f, thread)
    {
      F_CENTROID(x,f,thread);
      r = (x[2]-zo)*(x[2]-zo) + (x[1]-yo)*(x[1]-yo) + (x[0]-xo)*(x[0]-xo);
      
      F_PROFILE(f, thread, position) = -v_peak*(1 - r/R/R);
    }
  end_f_loop(f, thread);
 
}  

/**************************************************************/

/* Function to compute peak velocity from Fourier coefficients */

double w_vel(int nfour, double *vel_r, double *vel_i, double t){
  double w;
  double theta;
  int k;

  w = vel_r[0]; /* mean value */
  /* Message("velocity at time=%f for 0 iterations: %f m/s \n",t,w); */
    for (k=1;k<nfour;k++){
    /* Compute frequency */
	theta = 2*PI*k*t/T;
	/* Use Fourier coefficents to find peak velocity */
    w = w+vel_r[k]*cos(theta)-vel_i[k]*sin(theta);
	/* Message("velocity at time=%f for %d iterations: %f m/s \n",t,k,w); */
    }
    
    return w;
}
