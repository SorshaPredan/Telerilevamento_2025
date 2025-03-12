# Code for calculating spectral indices

library(imageRy)
library(terra)
library(viridis)

im.list()
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# Rotazione immagine
mato1992 <- flip(mato1992)
plot(mato1992)

# 1 = NIR
# 2 = red
# 3 = green

# Vegetazione rossa
im.plotRGB(mato1992, r=1, g=2, b=3)
# Vegetazione verde
im.plotRGB(mato1992, r=2, g=1, b=3)
# Suolo nudo diventa giallo
im.plotRGB(mato1992, r=2, g=3, b=1)


mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 <- flip(mato2006)
plot(mato2006)
im.plotRGB(mato2006, r=1, g=2, b=3)


# Plot a confronto
im.multiframe(1,2)
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato2006, r=1, g=2, b=3)

im.plotRGB(mato1992, r=3, g=2, b=1)
im.plotRGB(mato2006, r=3, g=2, b=1)

im.multiframe(3,2)
# NIR ontop of red
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato2006, r=1, g=2, b=3)

# NIR ontop of green
im.plotRGB(mato1992, r=2, g=1, b=3)
im.plotRGB(mato2006, r=2, g=1, b=3)

# NIR ontop of blue 
im.plotRGB(mato1992, r=3, g=2, b=1)
im.plotRGB(mato2006, r=3, g=2, b=1)

# Exercise: plot only the first layer of mato2006
dev.off()

# non viene però utilizzato
plot(mato2006$matogrosso~6209_lrg_1)
# invece si utilizzano le []
plot(mato2006[[1]])
# utilizzo di viridis
plot(mato2006[[1]], col=magma (100))
plot(mato2006[[1]], col=mako (100))


# DVI - Difference Vegetation Index
# Tree:          NIR = 255 (8 bit), red = 0 (8 bit)
# DVI =          NIR - red = 255 - 0 = 255 (pianta sana)
# Stressed tree: NIR = 100 (8 bit), red = 30 (8 bit)
# DVI =          NIR - red = 100 - 30 = 70 (pianta sotto stress)









