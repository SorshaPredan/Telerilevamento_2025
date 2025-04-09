# R code for calculating spatial variability

library(terra)
library(imageRy)
library(viridis)
library(patchwork)

install.packages("RStoolbox")
library(RStoolbox)

# Standard deviation
# 24 26 25

# 

media <- (24 + 26 + 25) / 3

num <- (24-media)^2 + (26-media)^2 + (25-media)^2
den <- 3

varianza <- num/den
stdev <- sqrt(varianza)
# 0.8164966

sd(c(24,26,25))
# 1 variazione del campione

sd(c(24,26,25,49))
# 12.02775

# media
mean(c(24,26,25))
mean(c(24,26,25,49))

#--- 

im.list()

sent = im.import("sentinel.png")
sent = flip(sent)
# band 1 = NIR
# band 2 = red
# band 3 = green

# Exercise plot the image in RGB with the NIR ontop of the red component
im.plotRGB(sent, r=1, g=2, b=3)

# Exercise: make three plots with NIR ontop of each component: r, g, b
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=3, g=2, b=1)

# plots
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=3, g=2, b=1)









