// saved as pump.stan

data{
  int<lower=0> N;       // number of pumps
  int<lower=0> y[N];             // number of failures
  real<lower=0> t[N];   // operation times of pumps
}

parameters{
  real<lower=0> lambda[N];
  real<lower=0> alpha;
  real<lower=0> beta;
}

transformed parameters{
  real<lower=0> eta[N];
  for (i in 1:N)
    eta[i] = lambda[i] * t[i];
}

model{
  target += exponential_lpdf( alpha | 1.0 );      // hyper-prior log-density
  target += gamma_lpdf( beta | 0.1, 1.0 );        // hyper-prior log-density
  target += gamma_lpdf( lambda | alpha, beta );   // prior log-density
  target += poisson_lpmf( y | eta );         // likelihood log-density
}
