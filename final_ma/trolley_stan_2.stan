// código para correr modelo base de trolley problem en stan

data{
  int<lower=0> N;
  int<lower=1> K;
  array[N] int<lower=1,upper=K> R; 
  array[N] int A; 
  array[N] int I; 
  array[N] int C;
  array[N] int E;
  array[N] int Y;
}

parameters{
  real bA;
  real bI;
  real bC;
  real bE;
  real bY;
  real alpha;
  ordered[K-1] CC;
}

model {
  alpha ~ normal(0, 1);                  
  bA ~ normal(0, 0.5);                   
  bI ~ normal(0, 0.5);                   
  bC ~ normal(0, 0.5);  
  bE ~ normal(0, 0.5);  
  bY ~ normal(0, 0.5);  

     for (k in 1:K-1) {
    CC[k] ~ normal(0, 1);
  }              

  for (i in 1:N)
    R[i] ~ ordered_logistic(alpha + bA*A[i] + bI*I[i] + bC*C[i]+ bE*E[i] + bY*Y[i],CC);
}
  
}