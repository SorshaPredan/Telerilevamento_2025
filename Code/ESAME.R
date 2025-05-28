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

# Immagini True color + commento
# immagini False color per il calcolo NDVI
# immagini False color per il calcolo NDRE

# Importo l'immagine "True color" (RGB) per l'ANNO 2018
UD_2018 <-rast()
UD_2018
# Importo l'immagine "False color" (NIR, Red, Green) per l'ANNO 2018
UDNIR_2018 <-rast()
UDNIR_2018
# Importo l'immagine "False color" (NIR, Red Edge, Blue) per l'ANNO 2018
UDRedE_2018 <-rast()
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

# Calcolo NDVI + calcolo NDRE
# NDVI cosa serve + commento risultato
# NDRE cosa serve + commento risultato
# Grafici di confronto 
# Commento finale
