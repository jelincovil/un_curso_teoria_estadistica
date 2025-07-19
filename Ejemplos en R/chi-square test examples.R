## EJEMPLOS TEST CHI-CUADRADO

# Ejemplo 1: datos Normales(2, 1) y modelo propuesto 
# Normal(2, 1)

n <- 30
x <- rnorm(n, 2,1)

help(cut)
# Partición de la recta
min(x); max(x)
breaks <- c(-Inf, 1, 2, 3, Inf)
x_cut <- cut(x, breaks)
# Calculo de las frecuencias
freq <- table(x_cut)
print(freq)
obs_freq <- c(2, 13, 11, 4 ) # Muestral
# X= (X1, X2, X3, X4)

# Calculo del vector 
# H0: P=P0, que es una medidad de probabilida Normal
# con mu= 2 y sigma= 1
# H0:p=p0
cum_probs <- pnorm(breaks, 1.8, 2.1)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

help(chisq.test)
chisq.test(x= obs_freq, p= propH0)

# p-value = 0.4714 > 0.05
# No rechazo H0
# T0 = X-squared = 25.126
qchisq(0.05, n-1, lower.tail = FALSE )
# 42.55697

ifelse(25.126 > 42.55697, 1,0)


# Ejemplo 2: datos Normales(2, 1) y modelo propuesto 
# Normal(4, 2)

cum_probs <- pnorm(breaks, 4, 2)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

chisq.test(x= obs_freq, p= propH0)
# p-value = 1.421e-11

# Ejemplo 3: datos Poisson(2) y modelo propuesto 
# Poisson(2)

n <- 40
set.seed(267000)
x <- rpois(n, 2)
# Partición de la recta
min(x); max(x)
breaks <- c(-Inf, 0, 2, 4, 6, Inf)
x_cut <- cut(x, breaks)
# Calculo de las frecuencias
freq <- table(x_cut)
print(freq)
obs_freq <- c(5, 18, 12, 4,  1)

# Calculo del vector H0:p=p0
cum_probs <- ppois(breaks, 2)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

chisq.test(x= obs_freq, p= propH0)

# Ejemplo 4: datos Poisson(2) y modelo propuesto 
# Poisson(5)

# Calculo del vector H0:p=p0 
cum_probs <- ppois(breaks, 5)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

chisq.test(x= obs_freq, p= propH0)

# Ejemplo 5: datos Normales(2, 1) y modelo propuesto 
# LogNormal(1, 0.3)

n <- 35
set.seed(4567)
x <- rnorm(n, 2,1)
hist(x, probability = TRUE, ylim = c(0,0.7),
     main = "Datos Normales(2, 1)")
curve(dnorm(x, 2,1), from=0, to=5, 
      col = "blue", add= TRUE, lwd= "2")
curve(dlnorm(x, 1, 0.3), from=0, to=5, 
      col = "green", add= TRUE, lwd= "2")

# Calculo del vector H0:p=p0
cum_probs <- plnorm(breaks, 1, 0.3)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

chisq.test(x= obs_freq, p= propH0)

# Ejemplo 6: Aplicación a Tabla de contingencia 
# Fuente: http://sthda.com/english/wiki/chi-square-test-of-independence-in-r

# Importamos los datos de Tareas domésticas
file_path <- "http://www.sthda.com/sthda/RDoc/data/housetasks.txt"
housetasks <- read.delim(file_path, row.names = 1)
head(housetasks)

# 156 esposas lavan la ropa, 2 maridos lo hacen,  personas lo hacen juntos.
# Etc

library("graphics")
mosaicplot(dt, shade = TRUE, las=2,
           main = "housetasks")

# Stat
chisq <- chisq.test(housetasks)
chisq

###################################################3
# 1 shapiro.test(normal_data)
n <- 35
x <- rnorm(n, 0, 2)
# H0: X~Normal(0,2)

help(shapiro.test)

shapiro.test(x)
# p-value = 0.70 > 0.05

# 2 Bondad de ajuste
# Partición de la recta
min(x); max(x)
breaks <- c(-Inf,-2, -1, 0,  1, 2, 3, Inf)
x_cut <- cut(x, breaks)
# Calculo de las frecuencias
freq <- table(x_cut)
print(freq)

obs_freq <- as.numeric(freq) # Muestral
# X= (X1, X2, X3, X4)

# Calculo del vector 
# H0: P=P0, que es una medidad de probabilida Normal
# con mu= 2 y sigma= 1
# H0:p=p0
cum_probs <- pnorm(breaks, 0, 2)
propH0<- diff(cum_probs)
print(propH0)
sum(propH0)

chisq.test(x= obs_freq, p= propH0)

# p-value = 0.4362 > 0.05



