//este modelo fue tomado de una sugerencia de chatgpt
data {
  int<lower=0> N;
  array[N] int R; 
  array[N] int A; 
  array[N] int I; 
  array[N] int C;

}

parameters {
  real<lower=-5, upper=5> bA;   // coefficient for predictor variable A
  real<lower=-5, upper=5> bI;   // coefficient for predictor variable I
  real<lower=-5, upper=5> bC;   // coefficient for predictor variable C
  real<lower=-5, upper=5> bE;   // coefficient for delta_j (E)
  real alpha;                   // intercept
  simplex[7] delta;             // delta_j values
}

transformed parameters {
  vector[8] delta_j;             // appended delta values

  delta_j[1] = 0;
  delta_j[2:8] = delta;
}

model {
  alpha ~ normal(0, 1);                // prior for the intercept
  bA ~ normal(0, 0.5);                 // prior for bA
  bI ~ normal(0, 0.5);                 // prior for bI
  bC ~ normal(0, 0.5);                 // prior for bC
  bE ~ normal(0, 0.5);                 // prior for bE
  delta ~ dirichlet(rep_vector(1, 8)); // prior for delta_j

  for (i in 1:N)
    R[i] ~ ordered_logistic(bE * sum(delta_j[1:8]) + bA * A[i] + bI * I[i] + bC * C[i], alpha);
}