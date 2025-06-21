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
Tarvisio_2018 <- rast("Tr_2018.tif")
Tarvisio_2018
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2018
TarvisioNIR_2018 <-rast("Tr_2018_NIR.tif")
TarvisioNIR_2018
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2018
TarvisioRedE_2018 <-rast("Tr_2018_RedEdge.tif")
TarvisioRedE_2018

# Importo l'immagine "True color" (RGB) per l'ANNO 2022
# From 2022-02-01 to 2022-06-30
Tarvisio_2022 <- rast("Tr_2022.tif")
Tarvisio_2022
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2022
TarvisioNIR_2022 <-rast("Tr_2022_NIR.tif")
TarvisioNIR_2022
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2022
TarvisioRedE_2022 <-rast("Tr_2022_RedEdge.tif")
TarvisioRedE_2022

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
plotRGB(Tarvisio_2018, r=3, g=2, b=1, stretch="lin")
plotRGB(Tarvisio_2022, r=3, g=2, b=1, stretch="lin")
# False color vegetazion (NIR/Red/Green)
plotRGB(TarvisioNIR_2018, r="B8", g="B4", b="B3", stretch="lin")
plotRGB(TarvisioNIR_2022, r="B8", g="B4", b="B3", stretch="lin")
# Vegetation false color (NIR/Red Edge/Blue)
plotRGB(TarvisioRedE_2018, r="B8", g="B5", b="B2", stretch="lin")
plotRGB(TarvisioRedE_2022, r="B8", g="B5", b="B2", stretch="lin")

# Ricostruzione immagine per anno (2018 - 2022) con le bande RGBNir (B4, B3, B2, B8)
# Anno 2018
Tr2018_br <-Tarvisio_2018[[1]]
Tr2018_bg <-Tarvisio_2018[[2]]
Tr2018_bb <-Tarvisio_2018[[3]]
Tr2018_nir <-TarvisioNIR_2018[[1]]
Tarvisio2018 <-c(Tr2018_br, Tr2018_bg, Tr2018_bb, Tr2018_nir)
# Bande Red Edge
Tr2018_bnir <-TarvisioRedE_2018[[1]]
Tr2018_bRE <-TarvisioRedE_2018[[2]]
Tr2018_bb <-TarvisioRedE_2018[[3]]
Tr2018_bg <-TarvisioNIR_2018[[3]]
Tarvisio2018_RE <-c(Tr2018_bnir, Tr2018_bRE, Tr2018_bb, Tr2018_bg)
# Anno 2022
Tr2022_br <-Tarvisio_2022[[1]]
Tr2022_bg <-Tarvisio_2022[[2]]
Tr2022_bb <-Tarvisio_2022[[3]]
Tr2022_nir <-TarvisioNIR_2022[[1]]
Tarvisio2022 <-c(Tr2022_br, Tr2022_bg, Tr2022_bb, Tr2022_nir)
# Bande Red Edge
Tr2022_bnir <-TarvisioRedE_2022[[1]]
Tr2022_bRE <-TarvisioRedE_2022[[2]]
Tr2022_bb <-TarvisioRedE_2022[[3]]
Tr2022_bg <-TarvisioNIR_2022[[3]]
Tarvisio2022_RE <-c(Tr2022_bnir, Tr2022_bRE, Tr2022_bb, Tr2022_bg)


# Calculate dvi for 2018
dvi2018 = Tr2018_nir - Tr2018_br # NIR - red
plot(dvi2018)
dvi2022 = Tr2022_nir - Tr2022_br # NIR - red
plot(dvi2022)
im.multiframe(2,1)
plot(dvi2018, col=inferno (100))
plot(dvi2018, col=inferno (100))



