library(dplyr)
library(ggplot2)

# Bernoulli
# Votacion federacion A y B
A <- rbinom(12000, 1, 0.46)
A

votos <- c(sum(A), 12000- sum(A))
barplot(votos, names.arg = c("Lista A", "Lista B"),
        main= "Votos por lista de candidatos")
mean(A)*100

# Binomial
# Numero de mensages de whataap respondidos por dia 
# por cada alumnos de Fac. Ing. 

# Dicotomico

set.seed(1124)
What <- rbinom(1500, 100, 0.15)
mean(What)

table(What)
rr <- as.numeric(table(What))
rr <- round( (rr/length(What))*100, 3 )

mensajes <- as.numeric(names(table(What)))
plot(mensajes, rr, type="h", lwd=2, 
     main = "Frec. rel. por numero de mensajes respondidos al dia" )

# Quantile plots
q <- quantile(What, probs = seq(0.01, 0.99, by=0.01) )
Q <- qbinom(seq(0.01, 0.99, by=0.01), 100, 0.15)  

# quantile: entrega los cuantiles empiricos.
# qbinom: cuantiles del modelo binomial

modq <- lm(q~Q)
bq1 <- unname(modq$coefficients)
plot(q,Q, main="QQplot binomal-empirico  vs binomial-teorico",
     ylab = "Quantiles teoricos" , xlab = "Quantiles empiricos")
abline(bq1[1], bq1[2], lwd=2)

# Poisson model
# Numero de micros 7 que llegan cada una hora en un dia al Campus
# Juan Pablo.

set.seed(543)
Z <- rpois(50, 3)
zz <- as.numeric( table(Z) )
zz <- (zz/length(Z))*100

plot(unique(sort(Z)), zz, type = "h", lwd=2,
     col="green", xlab="Z", ylab="Frecuencias rel.")


# Quantile plots
qq <- quantile(Z, probs = seq(0.01, 0.99, by=0.01))
QQ <- qpois(seq(0.01, 0.99, by=0.01), 3) 

mod2 <- lm(qq~QQ)
bq2 <- unname(mod2$coefficients)
plot(qq, QQ, col="blue2",
     main="QQplot poisson-empirico  vs poisson-teorico",
     ylab = "Quantiles teoricos" , xlab = "Quantiles empiricos" )
abline(bq2[1], bq2[2], col="green", lwd = 3)


# Casos en que QQplot no indica un modelo preferible 
# para los datos

plot(q, QQ, col="blue2",
     main="QQplot binomial-empirico  vs poisson-teorico",
     ylab = "Quantiles teoricos" , xlab = "Quantiles empiricos" )

sp <- smooth.spline(q, QQ)
lines(sp$x, sp$y, lwd=2)

plot(qq, Q, col="blue2",
     main="QQplot poisson-empirico  vs binomial-teorico",
     ylab = "Quantiles teoricos" , xlab = "Quantiles empiricos" )

sp <- smooth.spline(qq, Q)
lines(sp$x, sp$y, lwd=2)

#############################Modelos continuos
# Exponencial
# Tiempos en responder el cuestionario 1 MAT1124
  t <- rexp(150, 1/15)
hist(t, probability = TRUE, col = "blue3", ylim = c(0,0.07))
theta1= 1/5 ; theta2 <- 1/15 ; theta3 <- 1/30
curve(dexp(x, theta1), from=0.01, col="black", add = TRUE, lwd=2)
curve(dexp(x, theta2), from=0.01, col="orange", add = TRUE, lwd=3)
curve(dexp(x, theta3), from=0.01, col="red", add = TRUE, lwd=2)

mean(t)

range(t)
intervalos <- seq(0, 90, by=5)
hist(t, probability = TRUE, col = "blue3", ylim = c(0,0.07),
     breaks = intervalos)
curve(dexp(x, theta2), from=0.01, col="orange", add = TRUE, lwd=3)

###########################################################
# Notas en cuestionario 1
set.seed(1124)
x <- rnorm(150, 5.5, 0.36)
x <- x[x<=7]
summary(x)


hist(x, probability = TRUE, col = "blue3")
mu1= 5.5 ; mu2 <- 5
curve(dnorm(x, mu1, 0.36), from=0.01, col="orange", add = TRUE, lwd=3)
curve(dnorm(x, mu2, 0.55), from=0.01, col="red", add = TRUE, lwd=2)

# QQplot 

qqq <- quantile(t, probs = seq(0.01, 0.99, by=0.01))
QQQ <- qexp(seq(0.01, 0.99, by=0.01), 1/theta2) 

qqqq <- quantile(x, probs = seq(0.01, 0.99, by=0.01))
QQQQ <- qnorm(seq(0.01, 0.99, by=0.01), mu1, 0.36) 


plot(qqq, QQQQ, col="blue2",
     main="QQplot exponencial-empirico  vs Gaussiano-teorico",
     ylab = "Quantiles teoricos" , xlab = "Quantiles empiricos" )


plot(qqqq, QQQQ, col="blue2",
     main="QQplot normal-empirico  vs Gaussiano-teorico",
     ylab = "Quantiles teoricos" , xlab = "Quantiles empiricos" )


# Calculo de probabilidades

# Calculo de probabilidades modelo de Poisson
# Pr(X =< x) = Pr (X \in (-oo,x)): la probabilidad acumulada hasta 
# x minuscula.
 
# ppois: calcula laprobabilidad acumulada del modelo Poisson

# Calculo de probabilidadesdel modelo Gaussiano.

