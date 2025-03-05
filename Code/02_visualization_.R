# Code for visualizing satellite data

# install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(terra)
libary(imageRy)

# Listing file
im.list()

# Sentinel-2 bands: https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/bands/
b2 <- im.import("sentinel.dolomites.b2.tif")

cl <- colorRampPalette(c("black", "dark grey", "light grey"))(100)
plot(b2, col=cl)

cl <- colorRampPalette(c("blue", "green", "yellow", "red"))(100)
plot(b2, col=cl)

# Exercise: change make your own color ramp
# https://sites.stat.columbia.edu/tzheng/files/Rcolor.pdf
cl <- colorRampPalette(c("darkorchid3", "chartreuse", "cyan"))(100)
plot(b2, col=cl)
