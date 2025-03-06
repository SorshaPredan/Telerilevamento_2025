# Code for visualizing satellite data

# install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(terra)
library(imageRy)

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

# Band 3
b3 <- im.import("sentinel.dolomites.b3.tif")
# Band 4
b4 <- im.import("sentinel.dolomites.b4.tif")
# Band 8
b8 <- im.import("sentinel.dolomites.b8.tif")

par(mfrow=c(1,4))
b2 <- im.import("sentinel.dolomites.b2.tif")
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")

par(mfrow=c(1,4))
plot(b2)
plot(b3)
plot(b4)
plot(b8)

dev.off()

im.multiframe(1,4)
plot(b2)
plot(b3)
plot(b4)
plot(b8)


# Exercise: plot the bands using im.miltiframe() ore on top of the other
im.multiframe(4,1)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

im.multiframe(2,2)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

