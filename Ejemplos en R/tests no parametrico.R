# Sign test one sample
# %>%

library(rstatix)
# Función: sign_test()

n = 100
set.seed(43)
x1 <- rnorm(n, 2, 10) # mu = eta = 2
hist(x1, probability = TRUE)
# p0=0,5 => eta (x0) es la pediana

# Estadistico Y. x0=eta=2
sum( ifelse(x1-2<=0, 1, 0) )
n- sum( ifelse(x1-2<=0, 1, 0) )

# H0: eta=2 contra H1: eta dif 2
help(sign_test)
sign_test(data.frame(x1), x1~1, mu=10, #H0
          alternative="two.sided")
# P-valor = 1 > 0.05; H0: eta=2
# 0.133> 0.05 ; H0: eta = 4
# 0.00000000027 < 0.05 ; Rechazar H0: eta = 10
0.302 < 0.05

# H0: eta= 6 contra H1: eta dif 6
sign_test(data.frame(x1), x1~1, mu=6,
          alternative="two.sided")

0.118 < 0.05 # n=15
0.041 < 0.05 # n=35

# Sign test two sample
# eta1= 2
x2 <- rnorm(n, 2.2, 6) # eta2 = 10.5

df <- data.frame( x = c(x1,x2), 
                  g = c(rep(1, n), rep(2,n)) )
View(df)

boxplot( x~g, data=df)

# H0: dif etas=0 contra H1: dif etas dif 0

sign_test(data=df, x~g, mu=0) # eta1 - eta2 = eta*= 0

0.00664 < 0.05   # eta1 = 2 y eta2=6 Rechazo H0


1< 0.05 # eta1=2 y eta2=2,2 No rechazo H0.

# Test de los signos para quantiles



# test de rank o posiciones para datos pareados
n = 25
set.seed(435)
x1 <- rnorm(n, 2, 10) # mediana = mu = 2
xx1 <- x1 + rnorm(n, 0.4, 1)
boxplot(x1,xx1)

summary(data.frame(x1, xx1))
# mu1=2, sigma1=10; 
# mu2= 2.4; sqrt(10+1)

# H0:F1=F2 contra H1:  F1 dif F2

help(wilcox.test)

wilcox.test(x1, xx1, paired = TRUE, 
            alternative = "two.sided")

4.579e-05 < 0.05
# F1 es diferente de F2

xx2 <- x1 + rnorm(n, 0, 0.5)
boxplot(x1,xx2)

# H0:F1=F2 contra H1:  F1 dif F2
wilcox.test(x1, xx2, paired = TRUE, 
            alternative = "two.sided")
0.1664 > 0.05

# test de rangos para datos independientes
# Mann Witney test
# H0:F1=F2 contra H1:  F1 dif F2

wilcox.test(x1,x2, paired = FALSE, 
            alternative = "two.sided")

0.1191 < 0.05



# 3 Kolmogorov-Smirnov para una muestra

help(ks.test)

# Example for Normal data
# H0: F= F(mu=2,sigma=10)
# Test de bondad de ajuste

hist(x1)

ks.test(x1, "pnorm", 2, 10) # H0: Xi ~ Normal(2,10)

# p-valor = 0.6775 > 0.01.

# H0: F= F(mu=2,sigma=2)
ks.test(x1, "pnorm", 2, 2) # H0: Xi ~ Normal(2,2) F0
# p-valor = 2.319e-12 < 0.01 => Rechazar H0


# Example for  X~Exp(1/5) 
hist(rexp(40, 1/5))
ks.test(rexp(40, 1/5), "pnorm", 2, 10)
# p-valor = 3.846e-07


# Kolmogorov para dos muestras

a1 <- rexp(100, 1/5)
a2 <- rnorm(100, 5, 4)

hist(a1)
hist(a2)
boxplot(a1,a2)

ks.test(a1,a2, alternative = "two.sided")

# p-value = 0.4046 > 0.05 n=40
# p-value = 0.01581 > 0.05 n=100

# Importante considerar el tamaño muestral


# Kruskal - Wallis
data(iris)

str(iris)

boxplot(data= iris, Sepal.Length ~Species)

help(kruskal.test)
kruskal.test(data= iris, Sepal.Length ~Species)
#  p-value < 2.2e-16 < 0.01
# "Grupos diferentes" == medianas poblacionales diferentes 


library(agricolae)


dff <- data.frame( x = iris$Sepal.Length, 
                  g = c(rep(1, n), rep(2,n)) )


objs <- kruskal(iris$Sepal.Length, iris$Species, alpha = 0.05,
        console = TRUE)

str(objs)

plot(objs)

objs

ob<- Median.test(iris$Sepal.Length, iris$Species,
            alpha=0.05,correct=TRUE,simulate.p.value = FALSE, group = TRUE,
            main = NULL,console=TRUE)

plot(ob)
