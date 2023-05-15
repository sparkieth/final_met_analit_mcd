// código para correr modelo base de trolley problem en stan

data{
  int<lower=0> N;
  array[N] int R; 
  array[N] int A; 
  array[N] int I; 
  array[N] int C;
}

parameters{
  real bA;
  real bI;
  real bC;
  real alpha;
}

model {
  alpha ~ normal(0, 1);                  
  bA ~ normal(0, 0.5);                   
  bI ~ normal(0, 0.5);                   
  bC ~ normal(0, 0.5);                   
  for (i in 1:N){
    R[i] ~ bernoulli_logit(alpha + bA*A[i] + bI*I[i] + bC*C[i]);
  }
}
  