# Titolo del progetto
# Scopo del progetto: osservare i cambiamenti e/o perdita di vegetazione a causa di stress dovuti a cambiamenti ambientali e patologie vegetali quali la processionaria del pino e il bostrico del castagno.
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
UD_2018 <- rast("UD_2018.tif")
UD_2018
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2018
UDNIR_2018 <-rast("UD_2018_NIR.tif")
UDNIR_2018
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2018
UDRedE_2018 <-rast("UD_2018_RedEdge.tif")
UDRedE_2018

# Importo l'immagine "True color" (RGB) per l'ANNO 2022
# From 2022-02-01 to 2022-06-30
UD_2022 <-rast("UD_2022.tif")
UD_2022
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2022
UDNIR_2022 <-rast("UD_2022_NIR.tif")
UDNIR_2022
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2022
UDRedE_2022 <-rast("UD_2022_RedEdge.tif")
UDRedE_2022 

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
plotRGB(UD_2018, r=3, g=2, b=1, stretch="lin")
plotRGB(UD_2022, r=3, g=2, b=1, stretch="lin")
# False color vegetazion (NIR/Red/Green)
plotRGB(UDNIR_2018, r="B8", g="B4", b="B3", stretch="lin")
plotRGB(UDNIR_2022, r="B8", g="B4", b="B3", stretch="lin")
# Vegetation false color (NIR/Red Edge/Blue)
plotRGB(UDRedE_2018, r="B8", g="B5", b="B2", stretch="lin")
plotRGB(UDRedE_2022, r="B8", g="B5", b="B2", stretch="lin")

dev.off()

# Ricostruzione immagine per anno (2018 - 2022) con le bande RGBNir (B4, B3, B2, B8)
# Anno 2018
UD2018_br <-UD_2018[[1]]
UD2018_bg <-UD_2018[[2]]
UD2018_bb <-UD_2018[[3]]
UD2018_nir <-UDNIR_2018[[1]]
Udine2018 <-c(UD2018_br, UD2018_bg, UD2018_bb, UD2018_nir)
# Anno 2022
UD2022_br <-UD_2022[[1]]
UD2022_bg <-UD_2022[[2]]
UD2022_bb <-UD_2022[[3]]
UD2022_nir <-UDNIR_2022[[1]]
Udine2022 <-c(UD2022_br, UD2022_bg, UD2022_bb, UD2022_nir)

# Visualizzazione immagine in funzione del NIR
# Plot a confronto
# Vegetazione rossa: Nir , Green, Blue
im.multiframe(2,1)
im.plotRGB(Udine2018, 4,2,3) 
im.plotRGB(Udine2022, 4,2,3) 
# Vegetazione blu: Red, Green, Nir
im.multiframe(2,1)
im.plotRGB(Udine2018, 1,2,4)
im.plotRGB(Udine2022, 1,2,4)
# Vegetazione verde: Red, Nir, Bue
im.multiframe(2,1)
im.plotRGB(Udine2018, 1,4,3)
im.plotRGB(Udine2022, 1,4,3)

dev.off()

# Utilizzo pacchetto viridis
# 2018
plot(UD2018_nir)
plot(UD2018_nir, col=inferno (100))
plot(UD2018_nir, col=rocket (100))
# 2022
plot(UD2022_nir)
plot(UD2022_nir, col=inferno (100))
plot(UD2022_nir, col=rocket (100))

dev.off()

# Calcolo DVI 
# DVI - Difference Vegetation Index
# Tree:          NIR = 255 (8 bit), red = 0 (8 bit)
# DVI =          NIR - red = 255 - 0 = 255 (pianta sana)
# Stressed tree: NIR = 100 (8 bit), red = 30 (8 bit)
# DVI =          NIR - red = 100 - 30 = 70 (pianta sotto stress)

# Calculate dvi for 2018
dvi2018 = UD2018_nir - UD2018_br # NIR - red
plot(dvi2018)
plot(dvi2018, col=inferno(100))
plot(dvi2018, col=rocket(100))
# Calculate dvi for 2022
dvi2022 = UD2022_nir - UD2022_br # NIR - red
plot(dvi2022)
plot(dvi2022, col=inferno(100))
plot(dvi2022, col=rocket(100))

# Plot a confronto con viridis
im.multiframe(2,1)
plot(dvi2018, col=inferno(100))
plot(dvi2022, col=inferno(100))

# NDVI (standardization) 8 bit: range (0-255)
# Maximum: (NIR - red) / (NIR + red) = (255 - 0) / (255 + 0) = 1
# Minimum: NIR - red / (NIR + red) = (0 - 255) / (0 + 255) = -1

# 2018
ndvi2018 = (UD2018_nir - UD2018_br) / (UD2018_nir + UD2018_br)
# ndvi2018 = dvi2018 / (UD2018_nir + UD2018_br)
plot(ndvi2018)
# 2022
ndvi2022 = (UD2022_nir - UD2022_br) / (UD2022_nir + UD2022_br)
# ndvi2022 = dvi2022 / (UD2022_nir + UD2022_br)
plot(ndvi2022)
im.multiframe(2,1)
plot(ndvi2018)
plot(ndvi2022)


# ARGOMENTO SUCCESSIVO
# Matrice di grafici
pairs(Udine2018)    
pairs(Udine2021)
pairs(Udine2024)

# Classificazione delle immagini e calcolo frequenza
Udine2018c <-im.classify(Udine2018,2)






# Visualizzazione delle immagini per anno (2018 - 2021 - 2024) con le bande GreenBlueNirRedEdge (B3, B2, B8, B5) Vedi tu poi come voui disporlo
# Anno 2018
UD2018_bg <-UD_2018[[2]]
UD2018_bb <-UD_2018[[3]]
UD2018_nir <-UDNIR_2018[[1]]
UD2018_rededge <-UDRedE_2018[[2]]
Udine18 <-c(UD2018_bg, UD2018_bb, UD2018_nir, UD2018_rededge)
im.plotRGB(Udine18, 4,3,2) # Red Edge , Nir, Blue
# Anno 2021
UD2021_bg <-UD_2021[[2]]
UD2021_bb <-UD_2021[[3]]
UD2021_nir <-UDNIR_2021[[1]]
UD2021_rededge <-UDRedE_2021[[2]]
Udine21 <-c(UD2021_bg, UD2021_bb, UD2021_nir, UD2021_rededge)
im.plotRGB(Udine21, 4,3,2) # Red Edge , Nir, Blue
# Anno 2024
UD2024_bg <-UD_2024[[2]]
UD2024_bb <-UD_2024[[3]]
UD2024_nir <-UDNIR_2024[[1]]
UD2024_rededge <-UDRedE_2024[[2]]
Udine24 <-c(UD2024_bg, UD2024_bb, UD2024_nir, UD2024_rededge)
im.plotRGB(Udine24, 4,3,2) # Red Edge , Nir, Blue


----
# Visualizzo le immagini per l'anno 2018 - 2021 - 2024
# Nir , Green, Blue
im.multiframe(3,3)
im.plotRGB(Udine2018, 4,2,3)
im.plotRGB(Udine2021, 4,2,3)
im.plotRGB(Udine2024, 4,2,3)
# Red Edge , Nir, Blue
im.plotRGB(Udine18, 4,3,2)
im.plotRGB(Udine21, 4,3,2)
im.plotRGB(Udine24, 4,3,2)



# Ottenere un'immagine unica per ogni anno che contenga la banda del NIR per il calcolo NDVI
# Ottenere un'immagine unica per ogni anno che contenga la banda del Red Edge per il calcolo del NDRE

# Calcolo NDVI + calcolo NDRE
# NDVI cosa serve + commento risultato
# NDRE cosa serve + commento risultato
# Grafici di confronto 
# Commento finale
