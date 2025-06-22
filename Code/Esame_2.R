# Titolo del progetto
# Scopo del progetto: osservare i cambiamenti e/o perdita di vegetazione nel zona di Tarvisio in Friuli, a causa di stress dovuti a cambiamenti ambientali e patologie vegetali quali la processionaria del pino e il bostrico del castagno.
+ sono stati presi in considerazione due anni (2018 - 2022). Le immagini sono state selezionate da Sentinel....
# pacchetti utilizzati (commento a cosa servono)
library(terra)
library(imageRy)
library(raster)
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

# Correlazione tra immagini
pairs(Tarvisio2018)    
pairs(Tarvisio2022)

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

# Calcolo delle differenze per osservare eventuali cambiamenti di vegetazione
diff_ndvi <- ndvi2022 - ndvi2018
diff_ndvi
plot(diff_ndvi)
diff_ndre <- ndre2022 - ndre2018
diff_ndre
plot(diff_ndre)


# Classificazione delle immagini e calcolo della frequenza
im.classify
Tarvisio_2018 <-im.classify(Tarvisio2018, num_clusters=3)
Tarvisio_2018
# class 1 = soil (violet)
# class 2 = forest (yellow)
# class 3 = glacier (green)
Tarvisio_2022 <-im.classify(Tarvisio2022, num_clusters=3)
Tarvisio_2022
# class 1 = soil (yellow)
# class 2 = forest (violet)
# class 3 = glacier (green)

# Frequency year 2018
f2018 <- freq(Tarvisio_2018)
tot2018 <- ncell(Tarvisio_2018)
prop2018 <- f2018 / tot2018
perc2018 <- prop2018 * 100
perc2018
# percentages 2018:
# soil = 23%
# forest = 76%
# glacier = 1.4%

# Frequency year 2022
f2022 <- freq(Tarvisio_2022)
tot2022 <- ncell(Tarvisio_2022)
prop2022 <- f2022 / tot2022
perc2022 <- prop2022 * 100
perc2022
# percentages 2022:
# soil = 17%
# forest = 81%
# glacier = 2.3%

# Ggplot e Dataframe
class <-c("soil", "forest", "glacier")
y2018 <-c(22.82045, 75.77918, 1.40037)
y2018
y2022 <-c(16.963336, 80.782776, 2.253888)
y2022
DATAFRAME<-data.frame(class,y2018,y2022)
# Anno 2018
Anno2018 <-ggplot(DATAFRAME,aes(x=class, y=y2018, fill=class))+ 
 geom_bar(stat="identity", color="black") + 
 ylim(c(0, 100))
Anno2018
# Anno 2022
Anno2022 <-ggplot(DATAFRAME,aes(x=class, y=y2022, fill=class))+ 
 geom_bar(stat="identity", color="black") + 
 ylim(c(0, 100))
Anno2022

# Analisi multivariata
pcimage18<-im.pca(Tarvisio2018)
pcimage18
pcimage22<-im.pca(Tarvisio2022)
pcimage22



# PCA workflow
# 1. Sample
sampleT <- spatSample(Tarvisio2018, 100)
sampleT
# 2. PCA
pca <- prcomp(sampleT)
summary(pca)
# 3. map
pcmap <- predict(Tarvisio2018, pca, index=c(1:3))




