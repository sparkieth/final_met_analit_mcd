// código para correr modelo base de trolley problem en stan

data{
  int<lower=0> N;
  int<lower=1, upper=7> R[N]; 
  vector<lower=0>[N] A; 
  vector<lower=0>[N] I; 
  vector<lower=0>[N] C;
  vector<lower=0>[N] E;
  vector<lower=0>[N] Y;
}

parameters{
  real bA;
  real bI;
  real bC;
  real bE;
  real bY;
  real alpha;
}

model {
  alpha ~ normal(0, 1);                  
  bA ~ normal(0, 0.5);                   
  bI ~ normal(0, 0.5);                   
  bC ~ normal(0, 0.5);  
  bE ~ normal(0, 0.5);  
  bY ~ normal(0, 0.5);  
  for (i in 1:N)
    R[i] ~ bernoulli_logit(alpha + bA*A[i] + bI*I[i] + bC*C[i] + bE*E[i] + bY*Y[i]);
}
  
}