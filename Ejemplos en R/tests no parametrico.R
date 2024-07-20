# Sign test one sample
library(rstatix)
# Función: sign_test()

n = 100
set.seed(43)
x1 <- rnorm(n, 2, 10) # mediana = mu = 2
hist(x1, probability = TRUE)

# Estadistico Y. x0=eta=2
sum( ifelse(x1-2<=0, 1, 0) )
n- sum( ifelse(x1-2<=0, 1, 0) )

# H0: eta=2 contra H1: eta dif 2
sign_test(data.frame(x1), x1~1, mu=2,
          alternative="two.sided")

0.302 < 0.05

# H0: eta= 6 contra H1: eta dif 6
sign_test(data.frame(x1), x1~1, mu=6,
          alternative="two.sided")

0.118 < 0.05 # n=15
0.041 < 0.05 # n=35

# Sign test two sample
# eta1= 2
x2 <- rnorm(n, 4.5, 6) # eta2 = 10.5

df <- data.frame( x = c(x1,x2), 
                  g = c(rep(1, n), rep(2,n)) )
View(df)

boxplot( x~g, data=df)

# H0: eta=0 contra H1: eta dif 0

sign_test(data=df, x~g, mu=0)

0.175 < 0.05   # eta2 = 2 y eta2=4.5
0.133 <- 0.05  # Igual, n=100

0.00188 < 0.05 # eta1=2 y eta2=10.5


# test de rangos para datos pareados
n = 25
set.seed(435)
x1 <- rnorm(n, 2, 10) # mediana = mu = 2
xx1 <- x1 + rnorm(n, 0.4, 1)
boxplot(x1,xx1)

# H0:F1=F2 contra H1:  F1 dif F2

wilcox.test(x1, xx1, paired = TRUE, 
            alternative = "two.sided")

0.000715 < 0.05
# F1 es diferente de F2

xx2 <- x1 + rnorm(n, 0, 0.5)
boxplot(x1,xx2)

# H0:F1=F2 contra H1:  F1 dif F2
wilcox.test(x1, xx2, paired = TRUE, 
            alternative = "two.sided")
0.1014 < 0.05

# test de rangos para datos independientes
# Mann Witney test
# H0:F1=F2 contra H1:  F1 dif F2

wilcox.test(x1,x2, paired = FALSE, 
            alternative = "two.sided")

0.1191 < 0.05



# 3 Kolmogorov-Smirnov para una muestra

# Example for Normal data
# H0: F= F(mu=2,sigma=10)
# Test de bondad de ajuste
ks.test(x1, "pnorm", 2, 10)

# p-valor = 0.6116

# H0: F= F(mu=2,sigma=2)
ks.test(x1, "pnorm", 2, 2)
# p-valor = 0.001236


# Example for  X~Exp(1/5) 
hist(rexp(40, 1/4))
ks.test(rexp(40, 1/10), "pnorm", 2,10)
# p-valor = 5.983e-07


# Kruskal - Wallis

kruskal.test()


