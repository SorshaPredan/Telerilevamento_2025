# Titolo del progetto
# Scopo del progetto diviso in tre anni (2018 - 2021 - 2024)
# pacchetti utilizzati (commento a cosa servono)
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)
library(viridis)
library(cblindplot)
library(devtools) # Da rivedere a cosa serve

# Exporting data
# \ change direction
# Windowds users: C://comp/Downloads
# setwd("C://nome/Downloads")
setwd("C:/Users/user/Desktop/Telerilevamento/Immagini")

# Immagini True color :
  # B4 = Red
  # B3 = Green
  # B2 = Blue
# immagini False color per il calcolo NDVI
  # B8 = NIR 
  # B4 = Red
  # B3 = Green
# immagini False color per il calcolo NDRE
  # B8 = NIR 
  # B5 = Red Edge
  # B2 = Blue

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

# Importo l'immagine "True color" (RGB) per l'ANNO 2021
# From 2021-02-01 to 2021-06-30
UD_2021 <-rast("UD_2021.tif")
UD_2021
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2021
UDNIR_2021 <-rast("UD_2021_NIR.tif")
UDNIR_2021
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2021
UDRedE_2021 <-rast("UD_2021_RedEdge.tif")
UDRedE_2021 

# Importo l'immagine "True color" (RGB) per l'ANNO 2024
# From 2024-02-01 to 2024-06-30
UD_2024 <-rast("UD_2024.tif")
UD_2024
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2024
UDNIR_2024 <-rast("UD_2024_NIR.tif")
UDNIR_2024
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2024
UDRedE_2024 <-rast("UD_2024_RedEdge.tif")
UDRedE_2024 

# Visualizzazione immagine vegetazione
# True Color Vegetation (RGB naturale)
# stretch="lin" : aggiusta la dimensione dell'immagine
im.multiframe(3,3)
plotRGB(UD_2018, r=3, g=2, b=1, stretch="lin")
plotRGB(UD_2021, r=3, g=2, b=1, stretch="lin")
plotRGB(UD_2024, r=3, g=2, b=1, stretch="lin")
# False color vegetazion (NIR/Red/Green)
plotRGB(UDNIR_2018, r="B8", g="B4", b="B3", stretch="lin")
plotRGB(UDNIR_2021, r="B8", g="B4", b="B3", stretch="lin")
plotRGB(UDNIR_2024, r="B8", g="B4", b="B3", stretch="lin")
# Vegetation false color (NIR/Red Edge/Blue)
plotRGB(UDRedE_2018, r="B8", g="B5", b="B2", stretch="lin")
plotRGB(UDRedE_2021, r="B8", g="B5", b="B2", stretch="lin")
plotRGB(UDRedE_2024, r="B8", g="B5", b="B2", stretch="lin")

-----
# Visualizzazione delle immagini per anno (2018 - 2021 - 2024) con le bande RGBNir (B4, B3, B2, B8)
# Anno 2018
UD2018_br <-UD_2018[[1]]
UD2018_bg <-UD_2018[[2]]
UD2018_bb <-UD_2018[[3]]
UD2018_nir <-UDNIR_2018[[1]]
Udine2018 <-c(UD2018_br, UD2018_bg, UD2018_bb, UD2018_nir)
# Anno 2021
UD2021_br <-UD_2021[[1]]
UD2021_bg <-UD_2021[[2]]
UD2021_bb <-UD_2021[[3]]
UD2021_nir <-UDNIR_2021[[1]]
Udine2021 <-c(UD2021_br, UD2021_bg, UD2021_bb, UD2021_nir)
# Anno 2024
UD2024_br <-UD_2024[[1]]
UD2024_bg <-UD_2024[[2]]
UD2024_bb <-UD_2024[[3]]
UD2024_nir <-UDNIR_2024[[1]]
Udine2024 <-c(UD2024_br, UD2024_bg, UD2024_bb, UD2024_nir)

# Visualizzazione immagine in funzione del NIR
# Vegetazione rossa: Nir , Green, Blue
im.multiframe(3,1)
im.plotRGB(Udine2018, 4,2,3) 
im.plotRGB(Udine2021, 4,2,3) 
im.plotRGB(Udine2024, 4,2,3) 
# Vegetazione blu: Red, Green, Nir
im.multiframe(3,1)
im.plotRGB(Udine2018, 1,2,4)
im.plotRGB(Udine2021, 1,2,4)
im.plotRGB(Udine2024, 1,2,4)
# Vegetazione verde: Red, Nir, Bue
im.multiframe(3,1)
im.plotRGB(Udine2018, 1,4,3)
im.plotRGB(Udine2021, 1,4,3)
im.plotRGB(Udine2024, 1,4,3)

# vedere se fare prima il calcolo DVI - NDVI e NDRE e fare gli argomenti successivi
# Calcolo DVI e NDVI
# commento NDVI
# Anno 2018
# Anno 2021
# Anno 2024





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
