# Code for visualizing satellite data

# install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")
# install.packages("viridis")

library(terra)
library(imageRy)
library(viridis)

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

# Band 3: importing and plot it with the previous palette
b3 <- im.import("sentinel.dolomites.b3.tif")
# Band 4: importing the red band
b4 <- im.import("sentinel.dolomites.b4.tif")
# Band 8: importing the NIR band
b8 <- im.import("sentinel.dolomites.b8.tif")

# Multiframe
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

cl=colorRampPalette(c("black","light grey"))(100)
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

cl=colorRampPalette(c("black","light grey"))(2)
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# Sent
sent=c(b2,b3,b4,b8)
plot(sent, col=cl)

names(sent)=c("b2ble","b3green","b4red","b8NIR")
sent

# Plotting one layer
dev.off()
plot(sent$b8NIR)
plot(sent[[1]], col=cl)
plot(sent[[4]])

# Multiframe with different color palette
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

# Plotting the green band (b3)
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

# Plotting the red band (b4)
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

# Plotting the NIR band (b8)
cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)

im.multiframe(2,2)
plot(b2, col=clb)
plot(b3, col=clg)
plot(b4, col=clr)
plot(b8, col=cln)


# Importing several bands altoghether
sentdol=im.import("sentinel.dolomites")

# How to import several sets altoghether
pairs(sentdol)


# Viridis
install.packages("viridis")
library(viridis)

plot(sentdol, col=viridis(100))
plot(sentdol, col=mako(100))
plot(sentdol, col=magma(100))

# Viridis colors:
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

# Layers
# 1 - band 2 (blue)
# 2 - band 3 (green)
# 3 - band 4 (red)
# 4 - band 8 (NIR)

# Natural colors
im.plotRGB(sentdol,r=3, g=2, b=1)

# False colors
im.plotRGB(sentdol, r=4, g=3, b=2)
im.plotRGB(sentdol, r=3, g=4, b=2) 
im.plotRGB(sentdol, r=3, g=4, b=1) 

im.multiframe(1,2)
im.plotRGB(sentdol, r=3, g=4, b=2)
im.plotRGB(sentdol, r=3, g=4, b=1)

dev.off()
im.plotRGB(sentdol, r=3, g=2, b=4)

# RGB plotting
# sent[[1]] blue
# sent[[2]] green
# sent[[3]] red
# sent[[4]] NIR




