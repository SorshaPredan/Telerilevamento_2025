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
setwd("C:\Users\user\Desktop\Telerilevamento\ImmaginiESAME")
setwd("~/Desktop")
# Windowds users: C://comp/Downloads
# \
# setwd("C://nome/Downloads")

# Immagini True color + commento
# immagini False color per il calcolo NDVI
# immagini False color per il calcolo NDRE

# Importo l'immagine "True color" (RGB) per l'ANNO 2018
UD_2018 <- rast("UD_2018.tif")
UD_2018
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2018
UDNIR_2018 <-rast("UD_2018_NIR.tif")
UDNIR_2018
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2018
UDRedE_2018 <-rast("UD_2018_RedEdge.tif")
UDRedE_2018

# Importo l'immagine "True color" (RGB) per l'ANNO 2021
UD_2021 <-rast()
UD_2021
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2021
UDNIR_2021 <-rast()
UDNIR_2021
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2021
UDRedE_2021 <-rast()
UDRedE_2021 

# Importo l'immagine "True color" (RGB) per l'ANNO 2024
UD_2024 <-rast()
UD_2024
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2024
UDNIR_2024 <-rast()
UDNIR_2024
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2024
UDRedE_2024 <-rast()
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

# Visualizzazione Unica
im.multiframe(3,3)
plot1
plot2
plot3

# Calcolo NDVI + calcolo NDRE
# NDVI cosa serve + commento risultato
# NDRE cosa serve + commento risultato
# Grafici di confronto 
# Commento finale
