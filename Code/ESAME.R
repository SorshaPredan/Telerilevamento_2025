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
setwd("C:/Users/user/Desktop/Telerilevamento")
# Windowds users: C://comp/Downloads
# \ change direction
# setwd("C://nome/Downloads")

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
UD_2024 <-rast("UD_2024.tif")
UD_2024
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2024
UDNIR_2024 <-rast("UD_2024_NIR.tif")
UDNIR_2024
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2024
UDRedE_2024 <-rast("UD_2024_RedEdge.tif")
UDRedE_2024 

# Visualizzazione delle immagini tramite plot
# Visualizzo le immagini per l'anno 2018
im.multiframe(3,1)
plot(UD_2018)
plot(UDNIR_2018)
plot(UDRedE_2018)
plot1(plot(UD_2018), plot(UDNIR_2018), plot(UDRedE_2018)) # controllare 

# Visualizzo le immagini per l'anno 2021
im.multiframe(3,1)
plot(UD_2021)
plot(UDNIR_2021)
plot(UDRedE_2021)

# Visualizzo le immagini per l'anno 2024
im.multiframe(3,1)
plot(UD_2024)
plot(UDNIR_2024)
plot(UDRedE_2024)

# Visualizzazione Unica (vedere...)
im.multiframe(3,3)
plot1
plot2
plot3

# Ottenere un'immagine unica per ogni anno che contenga la banda del NIR per il calcolo NDVI
# Ottenere un'immagine unica per ogni anno che contenga la banda del Red Edge per il calcolo del NDRE

# Calcolo NDVI + calcolo NDRE
# NDVI cosa serve + commento risultato
# NDRE cosa serve + commento risultato
# Grafici di confronto 
# Commento finale
