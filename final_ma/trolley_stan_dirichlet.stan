//este modelo fue tomado de una sugerencia de chatgpt
data {
  int<lower=0> N;
  int<lower=1> K;
  array[N] int<lower=1,upper=K> R;  
  array[N] int A; 
  array[N] int I; 
  array[N] int C;

}

parameters {
  real bA;   
  real bI;   
  real bC;   
  real bE;   
  real alpha; 
  simplex[K] delta;
  ordered[K-1] CC;
}

transformed parameters {
  vector[K+1] delta_j;             // appended delta values

  delta_j[1] = 0;
  delta_j[2:K+1] = delta;
}
        R ~ ordered_logistic( phi , alpha ),
        phi <- G1*bE[G]*sum( deltaF_j[1:E] ) + 
               G2*bE[G]*sum( deltaM_j[1:E] ) + 
               bA[G]*A + bI[G]*I + bC[G]*C +
               bY[G]*Y,
        alpha ~ normal( 0 , 1 ),
        bA[G] ~ normal( 0 , 0.5 ),
        bI[G] ~ normal( 0 , 0.5 ),
        bC[G] ~ normal( 0 , 0.5 ),
        bE[G] ~ normal( 0 , 0.5 ),
        bY[G] ~ normal( 0 , 0.5 ),
        vector[8]: deltaF_j <<- append_row( 0 , deltaF ),
        vector[8]: deltaM_j <<- append_row( 0 , deltaM ),
        simplex[7]: deltaF ~ dirichlet( a ),
        simplex[7]: deltaM ~ dirichlet( a )

model {
  alpha ~ normal(0, 1);                // prior for the intercept
  bA ~ normal(0, 0.5);                 // prior for bA
  bI ~ normal(0, 0.5);                 // prior for bI
  bC ~ normal(0, 0.5);                 // prior for bC
  bE ~ normal(0, 0.5);                 // prior for bE
  delta ~ dirichlet(rep_vector(1, 8)); // prior for delta_j

   for (k in 1:K-1) {
    CC[k] ~ normal(0, 1);
  } 

  for (i in 1:N)
    R[i] ~ ordered_logistic(bE * sum(delta_j[1:K+1]) + bA * A[i] + bI * I[i] + bC * C[i], CC);
}