//este modelo fue tomado de una sugerencia de chatgpt
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
 
  vector[2] bA;
  vector[2] bI;
  vector[2] bC;
  vector[2] bE;
  vector[2] bY;
  simplex[K] deltaF;
  simplex[K] deltaM;
  real alpha; 
  ordered[K-1] CC;
}
    

model {

  for(i in 1:2){
  bA[i] ~ normal( 0 , 0.5 );
  bI[i] ~ normal( 0 , 0.5 );
  bC[i] ~ normal( 0 , 0.5 );
  bE[i] ~ normal( 0 , 0.5 );
  bY[i] ~ normal( 0 , 0.5 );
   }  

  for(m in 1:K){
        a[m] ~gamma(0.1,0.1);
        deltaF[m] ~ dirichlet(a[m]);
        deltaM[m] ~ dirichlet(a[m]);
  } 

  for(k in 2:K){
    CC[k-1] ~ normal(0, 1);
  }
  
  alpha ~ normal(0,1);
  
    for (i in 1:N){
    for(G in 1:2){
    R[i] ~ ordered_logistic(alpha + bA * A[i] + bI * I[i] + 
                            bC * C[i] + bY[i]*Y + G1*bE[G]*sum(deltaF[1:7]) + 
                            G2*bE[G]*sum(deltaM[1:7]), CC);
  }}

}