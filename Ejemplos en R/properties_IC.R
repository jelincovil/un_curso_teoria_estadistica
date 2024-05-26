## Parte 1: propiedad frecuentista de los IC

# Modelo de ejemplo:  Curva o densidad  normal

mu <- 0
sigma <- 1

hist( rnorm(10000), probability = TRUE, 
      ylim=c(0,0.5), col = "gray")  
curve(dnorm(x, mu, sigma), 
      main="Curva normal estandar", 
      xlab="Z", 
      ylab="F densidad", 
      type="l", xlim=c(min(rnorm(100, mu, sigma)), max(rnorm(100, mu, sigma))),
      col="blue",
      lwd=2,
      add = TRUE)
abline(v=mu)
abline(v=18)
abline(v=25)
# calculo de probabilidades
# Pob(Z<0)


# Propiedad de los intervalos de confianza

# Intervalos de confianza Gaussianos para una media poblacional

library(plotrix)

alpha <- 0.05 # Nivel de significancia
# 95%  
replicas <- 10000 # Numero de repeticiones
n <- 250 # Tamaño de muestra: n=5 ; 20 y  30.

# Modelo Gaussiano. Varianza conocida
mu <- 0
sigma <- 1

vecG <- rep(0, replicas)
a <- rep(0, replicas)
b <- rep(0, replicas)
hit <- rep(0, replicas)

for(i in 1:replicas){
  sample <- rnorm(n = n, mean = mu, sd = sigma) # rep de un eperiment
  z <- qnorm(1-alpha/2, lower.tail = TRUE) 
  a[i] <- mean(sample) - z * sigma / sqrt(n)
  b[i] <- mean(sample) + z * sigma / sqrt(n)
  hit[i] <- ifelse( a[i]<=mu & mu <= b[i], 1,0)
  vecG[i] <- hit[i] 
  #paste0( 100*(1 - alpha), "% confidence interval (Gaussian): (",                 a, ", ", b,")")
  print(i)
}

frelG <- 100*(1/seq(from=1, to=replicas))* cumsum(vecG)

plot.ts(frelG, main="M. Gaussiano u=0, sigma=2", ylab="Frecuencia de cobertura")
abline(a=95, b=0, col="blue")
legend("topright",c("Frec relativa","Confianza"), lwd = c(2, 2),
       lty=c(1, 1), col = c(1,"blue") , cex = 0.75 )

frelG[length(frelG)]

# Porcentaje
frelG[length(frelG)]*1000/length(replicas)
# Proporcion empirica

# Casos en que el IC no incluyo la media

100*(length(which(hit==0))/ replicas)

###########
plotCI(seq(1, 25), rep(mu,25) ,  ui=b[1:25], li=a[1:25], scol="red")
plotCI(seq(26, 50), rep(mu,25) ,  ui=b[26:50], li=a[26:50], scol="red")
plotCI(seq(51, 75), rep(mu,25) ,  ui=b[51:75], li=a[51:75],scol="red")
plotCI(seq(76, 100), rep(mu,25) ,  ui=b[76:100], li=a[76:100], scol="red")

# Modelo Gaussiano. Varianza desconocida  
# Resultado obtenido mediante la función 
# de R t.test.

replicas <- 100
n <- 5
vecGG <- rep(0, replicas)
a <- rep(0, replicas)
b <- rep(0, replicas)
hit <- rep(0, replicas)

for(i in 1:replicas){
  sample <- rnorm(n = n, mean = mu, sd = sigma)
  t <- qt(alpha/2, df=n-1, lower.tail=FALSE) 
  
  a[i] <- mean(sample) - t * sd(sample) / sqrt(n)
  b[i] <- mean(sample) + t * sd(sample) / sqrt(n)
  hit[i] <- ifelse( a[i]<=mu & mu <= b[i],1,0)
  vecGG[i] <- hit[i] 
  #paste0( 100*(1 - alpha), "% confidence interval (Gaussian): (",                 a, ", ", b,")")
  print(i)
}

frelGG <- 100*(1/seq(from=1, to=replicas))* cumsum(vecGG)

plot.ts(frelGG, main="Modelo Gaussiano u=0, sigma=2", ylab="Frecuencia de cobertura")
abline(a=95, b=0, col="blue")

# Proporcion de cobetura
frelGG[length(frelGG)]

which(hit == 0)

plotCI(seq(1, 20), rep(mu,20) ,  ui=b[1:20], li=a[1:20],  scol="red")



# Modelo Exponencial
# Datos no simetricos.
# Necesito muestras de tamaños grandes
# Teorema central del limite


replicas <- 10000
n <- 15 # probar 5, 10,  30, 50 y 100
lambda= 0.5
ejemplo <- rexp(n, lambda)
hist(ejemplo, probability = TRUE, main = "Datos asimetricos")
curve(dexp(x, lambda), from = 0, to=9, add =TRUE)
# mu = 1/0.5 = 2
mean(ejemplo)
hist(ejemplo, main="Histograma Asimetrico")

alpha <- 0.05
vecE <- rep(0, replicas)
a <- rep(0, replicas)
b <- rep(0, replicas)

for(i in 1: replicas){
  sample <- rexp( n, lambda) # Exp. desde un modelo Exponencial
  
  t <- qt(alpha/2, df=n-1, lower.tail=FALSE) 
  
  a[i] <- mean(sample) - t * sd(sample) / sqrt(n)
  b[i] <- mean(sample) + t * sd(sample) / sqrt(n)
  
  hit <- ifelse( a[i]<= 1/lambda & 1/ lambda <= b[i], 1, 0)
  vecE[i] <- hit 
  
  print(i)
}

frelE <- (1/seq(from=1, to=replicas))* cumsum(vecE)

plot.ts(frelE, main="Modelo Exponencial lambda", 
        ylab="Frecuencia de cobertura", ylim = c(0.8,1) )
abline(a=0.95, b=0, col="blue")


# Proporcion cobertura. 
frelE[length(frelE)] *100



mu0<- 1/lambda
par(mfcol = c(2, 2))
plotCI(seq(1, 25), rep(mu0,25) ,  ui=b[1:25], li=a[1:25])
plotCI(seq(26, 50), rep(mu0,25) ,  ui=b[26:50], li=a[26:50])
plotCI(seq(51, 75), rep(mu0,25) ,  ui=b[51:75], li=a[51:75])
plotCI(seq(76, 100), rep(mu0,25) ,  ui=b[76:100], li=a[76:100])




## Parte 2: propiedad  los IC según el nivel de confianza
# Media poblacional 10
# Variancia poblacional 5^2

set.seed(4567)
muestra <- rnorm(35, 10, 5)
hist(muestra)

# Para la media
t.test(muestra, conf.level = 0.99)

# IC 90 percent:
# [10.47 , 12.94]
# Largo IC 90: 2.47

# IC 95 percent:
# [10.22, 13.19]
# Largo IC 95: 2.97

# IC 99 percent:
# [9.72 , 13.69]
# Largo IC 99: 3.97

# 


# El largo del IC es directamente proporcional
# el su nivel de confianza

# IC largos: poco precisos, pero con mas informacion
# IC cortos:  mas precisos, pero con menos informacion




