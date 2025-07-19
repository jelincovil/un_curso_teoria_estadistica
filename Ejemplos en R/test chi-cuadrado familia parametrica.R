# Generar datos Log-normal(1, 0.3)

n <- 200
set.seed(2246785)
x <- rlnorm(n, meanlog = 1, sdlog = 0.9)
hist(x)

# H0: P es un modelo Normal cualquiera. theta=(mu,sigma^2)
# H1: P no es un modelo Normal cualquiera.

# Partición de la recta
min(x); max(x)
breaks <- c(-Inf, 2, 4, 6, 8, 10, 12, Inf)
x_cut <- cut(x, breaks)
# Calculo de las frecuencias
freq <- table(x_cut)
print(freq)
obs_freq <- c(76, 54, 34, 12, 10, 6, 8)

mu <- mean(x)
sigma <- sd(x)

# Calculo del vector H0:p=p0
cum_probs <- pnorm(breaks, mu, sigma)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

# vec <- ((obs_freq - n*propH0)^2)/n*propH0
#t0 <- sum(vec)

vec <- (propH0^obs_freq)/((obs_freq/n)^obs_freq) 
vecc = -2*log(vec)
t0= sum(vecc)
t0

# k = 7
# s = 2
# df = k - s -1= 7-2-1= 7-3 = 4
df = 4

curve(dchisq(x,df=4, ncp = 0 ), from=0, to=12)

qchisq(0.05, df=4, ncp = 0,  lower.tail = FALSE)

# c= 9.48
# t0= 32.6

# Cuando n es pequeno, este test no rechaza H0. Cuando n crece, tiende a rechazar

# Modelo verdadero Binomial Negativo: 
n <- 25

x <-  rnbinom(n, mu = 4, size = 100)
hist(x)

# H0: P = P0~Geometrica(theta), 0<theta<1

# Partición de la recta
min(x); max(x)
breaks <- c(-Inf, 2, 4, 5.5, 7.5, Inf)
x_cut <- cut(x, breaks)
# Calculo de las frecuencias
freq <- table(x_cut)
print(freq)
obs_freq <- c(48, 78, 36, 25, 13)

theta = 1/mean(x)
# hist(rgeom(25, theta))
# Calculo del vector H0:p=p0
cum_probs <- pgeom(breaks, theta)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

vec <- (propH0^obs_freq)/((obs_freq/n)^obs_freq) 
vecc = -2*log(vec)
t0= sum(vecc)
t0

# k = 5
# s = 1
# df = k - s -1= 5-1-1= 5-2 = 3
df = 3

curve(dchisq(x,df=3, ncp = 0 ), from=0, to=10)

qchisq(0.05, df=3, ncp = 0,  lower.tail = FALSE)

# C= 7.814
# t0

