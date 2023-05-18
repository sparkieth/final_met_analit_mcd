
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
  ordered[K-1] CC;
}

transformed parameters{
  real deltaM1=sum(deltaMx[1:K-1]);
  real deltaF1=sum(deltaFx[1:K-1]);

  //real deltaM1;
  //real deltaF1;

  //deltaM1[1]=0;
  //deltaM1[2:K]=deltaM[1:K];
    //deltaF1[1]=0;
  //deltaF1[2:K]=deltaF[1:K];
}

model {
  bA ~ normal( 0 , 0.5 );
  bI ~ normal( 0 , 0.5 );
  bC ~ normal( 0 , 0.5 );
  bE ~ normal( 0 , 0.5 );
  bY ~ normal( 0 , 0.5 );
    
  alpha ~ normal(0, 1);

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
    simplex[K-1] deltaMx;
    simplex[K-1] deltaFx;
  
  deltaMx=dirichlet_rng(rep_vector(10,K-1));
  deltaFx=dirichlet_rng(rep_vector(10,K-1));
  }








