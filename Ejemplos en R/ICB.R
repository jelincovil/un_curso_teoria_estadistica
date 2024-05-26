# Link tutoriales

# https://istats.shinyapps.io/ExploreCoverage/
  
# https://test-science.shinyapps.io/BayesianBinomialCIs/
  

# Link: https://easystats.github.io/bayestestR/reference/hdi.html

library(bayestestR)

# muestreo de una posterior mu|x ~ Normal(10, 2.5 )
posterior <- rnorm(1000, 10, 2.5)

# HDI: High density interval

hdi(posterior, ci = 0.89)
hdi(posterior, ci = c(0.80, 0.90, 0.95))

# Ejemplo con data iris

data("iris")
str(iris)

bayestestR::hdi(iris[1:4])
bayestestR::hdi(iris[1:4], ci = c(0.80, 0.90, 0.95))
help(bayestestR)

# Ejemplo con datos mtcars

data(mtcars)
str(mtcars)


library(rstanarm)
model <- suppressWarnings(
  stan_glm(mpg ~ wt + gear, 
           data = mtcars, 
           chains = 2, 
           iter = 200, 
           refresh = 0)  )

bayestestR::hdi(model)
bayestestR::hdi(model, ci = c(0.80, 0.90, 0.95))

library(emmeans)
bayestestR::hdi(emtrends(model, ~1, "wt", data = mtcars))

library(brms)
model <- brms::brm(mpg ~ wt + cyl, data = mtcars)
bayestestR::hdi(model)
bayestestR::hdi(model, ci = c(0.80, 0.90, 0.95))

library(BayesFactor)
bf <- ttestBF(x = rnorm(100, 1, 1))
bayestestR::hdi(bf)
bayestestR::hdi(bf, ci = c(0.80, 0.90, 0.95))


  
  
  