# Titolo del progetto
# Scopo del progetto: osservare i cambiamenti e/o perdita di vegetazione nel zona di Tarvisio in Friuli, a causa di stress dovuti a cambiamenti ambientali e patologie vegetali quali la processionaria del pino e il bostrico del castagno.
+ sono stati presi in considerazione due anni (2018 - 2022). Le immagini sono state selezionate da Sentinel....
# pacchetti utilizzati (commento a cosa servono)
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)
library(cblindplot)
library(devtools) # Da rivedere a cosa serve
# Viridis colors:
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
library(viridis)

# Exporting data
# \ change direction
# Windowds users: C://comp/Downloads
# setwd("C://nome/Downloads")
setwd("C:/Users/user/Desktop/Telerilevamento/Immagini")


# Importo l'immagine "True color" (RGB) per l'ANNO 2018
# From 2018-02-01 to 2018-06-30
Tr_2018 <- rast("Tr_2018.tif")
Tr_2018
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2018
TrNIR_2018 <-rast("Tr_2018_NIR.tif")
TrNIR_2018
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2018
TrRedE_2018 <-rast("Tr_2018_RedEdge.tif")
TrRedE_2018

# Importo l'immagine "True color" (RGB) per l'ANNO 2022
# From 2022-02-01 to 2022-06-30
Tr_2022 <- rast("Tr_2022.tif")
Tr_2022
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2022
TrNIR_2022 <-rast("Tr_2022_NIR.tif")
TrNIR_2022
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2022
TrRedE_2022 <-rast("Tr_2022_RedEdge.tif")
TrRedE_2022

# Scelta delle bande per la visualizzazione della vegetazione
# Immagini True color :
  # B4 = Red
  # B3 = Green
  # B2 = Blue
# Immagini False color per il calcolo NDVI
  # B8 = NIR 
  # B4 = Red
  # B3 = Green
# Immagini False color per il calcolo NDRE
  # B8 = NIR 
  # B5 = Red Edge
  # B2 = Blue

# True Color Vegetation (RGB naturale)
# stretch="lin" : aggiusta la dimensione dell'immagine
im.multiframe(2,1)
plotRGB(Tr_2018, r=3, g=2, b=1, stretch="lin")
plotRGB(Tr_2022, r=3, g=2, b=1, stretch="lin")
# False color vegetazion (NIR/Red/Green)
plotRGB(TrNIR_2018, r="B8", g="B4", b="B3", stretch="lin")
plotRGB(TrNIR_2022, r="B8", g="B4", b="B3", stretch="lin")
# Vegetation false color (NIR/Red Edge/Blue)
plotRGB(TrRedE_2018, r="B8", g="B5", b="B2", stretch="lin")
plotRGB(TrRedE_2022, r="B8", g="B5", b="B2", stretch="lin")

dev.off()

# Ricostruzione immagine per anno (2018 - 2022)
# Anno 2018
# Bande RGB + NIR (B4, B3, B2, B8)
Tr2018_br <-Tr_2018[[1]]
Tr2018_bg <-Tr_2018[[2]]
Tr2018_bb <-Tr_2018[[3]]
Tr2018_nir <-TrNIR_2018[[1]]
Tarvisio2018 <-c(Tr2018_br, Tr2018_bg, Tr2018_bb, Tr2018_nir)
Tarvisio2018
# Bande Red Edge + NIR (B8, B5, B2, B3)
Tr2018_bnir <-TrRedE_2018[[1]]
Tr2018_bRE <-TrRedE_2018[[2]]
Tr2018_bb <-TrRedE_2018[[3]]
Tr2018_bg <-TrNIR_2018[[3]]
Tarvisio2018_RE <-c(Tr2018_bnir, Tr2018_bRE, Tr2018_bb, Tr2018_bg)
Tarvisio2018_RE
# Anno 2022
# Bande RGB + NIR (B4, B3, B2, B8)
Tr2022_br <-Tr_2022[[1]]
Tr2022_bg <-Tr_2022[[2]]
Tr2022_bb <-Tr_2022[[3]]
Tr2022_nir <-TrNIR_2022[[1]]
Tarvisio2022 <-c(Tr2022_br, Tr2022_bg, Tr2022_bb, Tr2022_nir)
Tarvisio2022
# Bande Red Edge + NIR (B8, B5, B2, B3)
Tr2022_bnir <-TrRedE_2022[[1]]
Tr2022_bRE <-TrRedE_2022[[2]]
Tr2022_bb <-TrRedE_2022[[3]]
Tr2022_bg <-TrNIR_2022[[3]]
Tarvisio2022_RE <-c(Tr2022_bnir, Tr2022_bRE, Tr2022_bb, Tr2022_bg)
Tarvisio2022_RE

# Visualizzazione immagine in funzione del NIR
# Plot a confronto
# Vegetazione rossa: Nir , Green, Blue
im.multiframe(2,1)
im.plotRGB(Tarvisio2018, 4,2,3) 
im.plotRGB(Tarvisio2022, 4,2,3) 
# Vegetazione blu: Red, Green, Nir
im.multiframe(2,1)
im.plotRGB(Tarvisio2018, 1,2,4)
im.plotRGB(Tarvisio2022, 1,2,4)
# Vegetazione verde: Red, Nir, Bue
im.multiframe(2,1)
im.plotRGB(Tarvisio2018, 1,4,3)
im.plotRGB(Tarvisio2022, 1,4,3)

dev.off()

# Utilizzo pacchetto viridis
# Anno 2018
plot(Tr2018_nir)
plot(Tr2018_nir, col=viridis (100))
plot(Tr2018_nir, col=inferno (100))
# Anno 2022
plot(Tr2022_nir)
plot(Tr2022_nir, col=viridis (100))
plot(Tr2022_nir, col=inferno (100))

dev.off()

# Calculate dvi for 2018
dvi2018 = Tr2018_nir - Tr2018_br # NIR - red
dvi2018
plot(dvi2018)
# Calculate dvi for 2022
dvi2022 = Tr2022_nir - Tr2022_br # NIR - red
dvi2022
plot(dvi2022)

# Plot a confronto con viridis
im.multiframe(2,1)
plot(dvi2018, col=inferno (100))
plot(dvi2022, col=inferno (100))


# Calculate NDVI (standardization)
# Anno 2018
ndvi2018 = (Tr2018_nir - Tr2018_br) / (Tr2018_nir + Tr2018_br)
ndvi2018
# ndvi2018 = dvi2018 / (Tr2018_nir + Tr2018_br)
plot(ndvi2018)
# Anno 2022
ndvi2022 = (Tr2022_nir - Tr2022_br) / (Tr2022_nir + Tr2022_br)
ndvi2022
# ndvi2022 = dvi2022 / (Tr2022_nir + Tr2022_br)
plot(ndvi2022)
im.multiframe(2,1)
plot(ndvi2018, col=inferno (100))
plot(ndvi2022, col=inferno (100))

# Calculate NDRE
# Anno 2018
ndre2018 = (Tr2018_bnir - Tr2018_bRE) / (Tr2018_bnir + Tr2018_bRE)
ndre2018
plot(ndre2018)
# Anno 2022
ndre2022 = (Tr2022_bnir - Tr2022_bRE) / (Tr2022_bnir + Tr2022_bRE)
ndre2022
plot(ndre2022)
im.multiframe(2,1)
plot(ndre2018, col=inferno (100))
plot(ndre2022, col=inferno (100))

# NDVI: phenology
im.plotRGB(ndvi2018, 1, 2, 3)
im.plotRGB(ndvi2022, 1, 2, 3)
# Ridgeline plots
im.ridgeline(ndvi2018, scale=1, palette="inferno")
im.ridgeline(ndvi2022, scale=1, palette="inferno")
# Anno 2018
names(ndvi2018) <-c("02_Feb", "03_Mar", "04_Apr", "05_May", "06_Jun")
im.ridgeline(ndvi2018, scale=1, palette="inferno")
# Anno 2022
names(ndvi2022) <-c("02_Feb", "03_Mar", "04_Apr", "05_May", "06_Jun")
im.ridgeline(ndvi2022, scale=1, palette="inferno")

# manca anche l'argomento delle mappe con ggplot vedere se farlo adesso o dopo

# ARGOMENTO SUCCESSIVO
# Matrice di grafici
pairs(Tarvisio2018)    
pairs(Tarvisio2022)


# Classificazione delle immagini e calcolo frequenza
Tarvisio2018c <-im.classify(Tarvisio2018,2)
#
# 
Tarvisio2022c <-im.classify(Tarvisio2022,2)



