
data {
  int<lower=0> N;
  int<lower=1> K;
  array[N] int<lower=1,upper=K> R;  
  array[N] int A; 
  array[N] int I; 
  array[N] int C;
  array[N] int<lower=0,upper=1> G1;
  array[N] int<lower=0,upper=1> G2;
  array[N] real Y;
  
}

parameters {
 
  real bA;
  real bI;
  real bC;
  real bE;
  real bY;
  real alpha;
  vector[K] a;
  ordered[K-1] CC;
  simplex[K-1] deltaM;
  simplex[K-1] deltaF;
  //simplex[K-1] deltaM;
  //simplex[K-1] deltaF;
}

transformed parameters{
  real deltaM1=sum(deltaM[1:K-1]);
  real deltaF1=sum(deltaF[1:K-1]);
}

model {
  bA ~ normal( 0 , 0.5 );
  bI ~ normal( 0 , 0.5 );
  bC ~ normal( 0 , 0.5 );
  bE ~ normal( 0 , 0.5 );
  bY ~ normal( 0 , 0.5 );
    
  alpha ~ normal(0, 1);

  for(m in 1:K-1){
  a[m] ~gamma(0.1,0.1);
  }

  //  for (m in 1:K-1) {
  //  deltaM[m] ~ dirichlet(a);
  //  deltaF[m] ~ dirichlet(a);
  //}

  for(k in 2:K){
  CC[k-1] ~ normal(0, 1);
  }

    for (i in 1:N){
  R[i] ~ordered_logistic(alpha + bA * A[i] + bI * I[i] + bC * C[i] + bY*Y[i] + bE*deltaF1*G1[i] + 
                            bE*deltaM1*G2[i], CC);                  
  }
}

  generated quantities{

  for(m in 1:K-1){
  deltaM[m]=mean(dirichlet_rng(rep_vector(10,K-1)));
  deltaF[m]=mean(dirichlet_rng(rep_vector(10,K-1)));
  }



  }





