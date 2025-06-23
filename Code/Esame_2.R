### La vegetazione di Tarvisio
## Lo scopo del lavoro è quello di osservare i cambiamenti e/o perdita di vegetazione nell zona di Tarvisio, territorio situato in Friuli Venezia Giulia, 
+ a causa di stress dovuti a cambiamenti ambientali o patologie vegetali quali la processionaria del pino e il bostrico del castagno. 
+ Sono stati presi in considerazione due anni nel periodo che si estende dal 01 febbraio al 30 giugno (2018 - 2022). 
# Le immagini scelte sono state prese dal sito "Copernicus Browser" utilizzando InstrumentSentinel-2 MSI: Multispectral Instrument
# https://developers.google.com/earth-engine/datasets/catalog/sentinel?hl=it
# https://code.earthengine.google.com/?scriptPath=Examples%3ADatasets%2FCOPERNICUS%2FCOPERNICUS_S2_SR_HARMONIZED&hl=it
# Il codice è stato scritto impiegando i seguenti pacchetti:
 #Pacchetto in R con specializzazione per analisi geospaziale e manipolazione di dati raster.
library(terra) 
library(raster)
 #Pacchetto in R per gestione dati raster, visualizzazione, importazione e modificazione delle immagini.
 #Facilita condivisione di immagini.
library(imageRy)
 #Pacchetto in R per creazione di grafici statistici.
library(ggplot2) 
 #Pacchetto in R per organizzazione e personalizzazione della disposizione di più grafici insieme.
library(patchwork)
 #Pacchetto in R progettato per creare grafici di sensibilità e analisi di potenza, spesso utilizzati in contesti di analisi statistica.
library(cblindplot)
 #Pacchetto progettato per installare pacchetti direttamente da repository come GitHub.
library(devtools) 
 #Viridis colors: Pacchetto in R usato per assegnare alle immagini rappresentate delle palette di colore
 #Utile per usare palette distinguibili anche dalle persone daltoniche.
 #https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
library(viridis)

### IMPORTAZIONE IMMAGINI
# Le immagini selezionate comprendono la zona di Malborghetto, Camporosso in Valcanale e Tarvisio, aree montuose maggiormente colpite dalla processionaria e dal bostrico.
# Per i due anni (2018 - 2022) vengono fornite 3 immagini satellite "sentinel-2”: una con i colori veri "True Color" aventi le bande B4, B3 e B2 (Red, Green, Blue: RGB); 
una in falsi colori "False Color" aventi le bande B8, B4 e B3 (NIR, Red, Green: Vicino infrarosso e 2 delle precedenti bande); una in falsi colori "False Color" aventi le bande B8, B5 e B2 (NIR, Red Edge, Blue)
# Lo scopo da portare a termine è quello di prelevare la banda b8, cioè quella del nir, dalle immagini in falsi colori per importarla in un unico oggetto assieme alle altre bande b4, b3 e b2. 
Voglio quindi costruire un’unica immagine con 4 bande: b2, b3, b4, b8 (blue, red, green, nir).
Voglio quindi costruire un’unica immagine con 4 bande: b2, b3, b5, b8 (blue, red edge, green, nir).
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

## Ricostruzione immagine per anno (2018 - 2022)
# Procedo con l’estrazione degli oggetti per la prosecuzione del progetto. Le parentesi [[]] mi permettono di estrarre la banda di interesse.
# Vado ad unire le componenti in un unico oggetto rinominato "Tarvisio2018" e "Tarvisio2022" con tutte le 4 bande insieme.
# Vado ad unire le componenti in un unico oggetto rinominato "Tarvisio2018_RE" e "Tarvisio2022_RE" con tutte le 4 bande insieme.
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

## Visualizzazione della vegetazione in funzione del NIR
# Usando la funzione "im.plotRGB()" del pacchetto "imageRy", vado a sostituire il nir con le altre bande rgb per osservare come varia la visualizzazione della vegetazione presente.
# Plot a confronto
## Vegetazione rossa: Nir , Green, Blue
# Nir su red: questo comporta una visualizzazione che evidenzia le caratteristiche della vegetazione poichè la vegetazione riflette molto di più nel nir rispetto alle altre superfici, andando a facilitarne l'identificazione. Si può anche capirne le condizioni di salute poichè più queste sono in buona salute, più il nir viene riflesso, e più l'immagine sarà luminosa.
im.multiframe(2,1)
im.plotRGB(Tarvisio2018, 4,2,3) 
im.plotRGB(Tarvisio2022, 4,2,3) 
## Vegetazione blu: Red, Green, Nir
# Nir sul blu: la vegetazione sarà visivamente di colore blu. Inoltre, il suolo diventerà di colore giallo andando a fornire un ottimo contrasto tra vegetazione e suolo. 
im.multiframe(2,1)
im.plotRGB(Tarvisio2018, 1,2,4)
im.plotRGB(Tarvisio2022, 1,2,4)
## Vegetazione verde: Red, Nir, Bue
# Nir sul green: la vegetazione sarà visivamente di colore verde, dando un aspetto più naturale all’immagine.
im.multiframe(2,1)
im.plotRGB(Tarvisio2018, 1,4,3)
im.plotRGB(Tarvisio2022, 1,4,3)

dev.off()

### CORRELAZIONE TRA IMMAGINI
# Mediante la funzione "pairs()" si crea una matrice di grafici a dispersione mostrando le relazioni bivariate tra ogni coppia di banda presente nell'oggetto.
# Ogni cella interna alla matrice contiene un grafico a dispersione andando a visualizzare la correlazione di Pearson tra le bande. 
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

### CALCOLO dell’INDICE DI VARIABILITA': DVI E NDVI E NDRE.
# Calcolo DVI: Indice di differenza di vegetazione. 
# Questo indice va a sfruttare l'alta capacità di riflettanza dell'infrarosso (nir) e l'alta capacità di assorbimento del rosso (red) per determinare, attraverso una differenza nir-red, la biomassa/densità di vegetazione presente.
# Si può anche determinare lo stato di salute della pianta in base all'accrescimento del rosso o infrarosso (NOTA: se aumenta da rosso a nir la pianta è sana).
# Calculate dvi for 2018
dvi2018 = Tr2018_nir - Tr2018_br # NIR - red
dvi2018
# I risultati del 2018 sono: min -0.20, max 0.69
plot(dvi2018)
# Calculate dvi for 2022
dvi2022 = Tr2022_nir - Tr2022_br # NIR - red
dvi2022
# I risultati del 2022 sono: min -0.19, max 0.67
plot(dvi2022)

# Plot a confronto con il pacchetto viridis
im.multiframe(2,1)
plot(dvi2018, col=inferno (100))
plot(dvi2022, col=inferno (100))


# Calculate NDVI: indice di differenza normalizzata delle vegetazioni impiegando i valori delle bande rosse e infrarosse delle immagini.
# Viene calcolata con la formula NDVI = (nir-red/nir+red) che mi permette di andare a confrontare i valori tra immagini che hanno una risoluzione radiometrica diversa
# Interpretazione dati relativi a NDVI: valori alti, vicini a +1 = vegetazione densa e sana; valori vicini 0= vegetazione scarsa, neve/ghiaccio o suolo nudo; 
valori bassi vicini a -1 = superfici non coperte da vegetazione o urbanizzate come costruzioni o strade.
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

## Calcolo delle differenze tra i due anni considerati del NDVI e NDRE per osservare eventuali cambiamenti di vegetazione
# Valori positivi stanno ad indicare una maggiore presenza di vegetazione
diff_ndvi <- ndvi2022 - ndvi2018
diff_ndvi
plot(diff_ndvi)
diff_ndre <- ndre2022 - ndre2018
diff_ndre
plot(diff_ndre)


### CLASSIFICAZIONE DELLE IMMAGINI E CALCOLO DELLA FREQUENZA
# Si classificano le immagini impiegando la funzione "im.classify()" e successivamente si svolge il calcolo della relativa frequenza, proporzione e percentuale del numero dei pixel.
# La funzione impiegata fa parte del pacchetto "imageRy".
# Si procede con la classificazione delle immagini attraverso un algoritmo che permette di creare dei gruppi/cluster basandosi sulla riflettanza del pixel (che, a sua volta, è in funzione di che oggetto si trova su quel pixel, cioè se 
una pianta o una porzione di suolo, per es.).
# La funzione prende i pixel dell'immagine in maniera randomica e pertanto i colori dei cluster delle classificazioni possono risultare diversi a ogni visualizzazione. 
im.classify
# Anno 2018
Tarvisio_2018 <-im.classify(Tarvisio2018, num_clusters=3)
Tarvisio_2018
# class 1 = soil (violet)
# class 2 = forest (yellow)
# class 3 = glacier (green)
# Anno 2022
Tarvisio_2022 <-im.classify(Tarvisio2022, num_clusters=3)
Tarvisio_2022
# class 1 = soil (yellow)
# class 2 = forest (violet)
# class 3 = glacier (green)

# Frequency year 2018
# Per calcolare il numero dei pixel presenti tra le diverse classificazioni scelte, si calcola la frequenza delle classi attraverso l’uso della funzione "freq()".
# Calcolo del numero totale di celle nell'immagine impiegando la funzione "ncell()".
# Eseguo il calcolo della proporzione per ogni anno a disposizione dato dalle immagini. Si calcola la proporzione rispetto al totale e si usa l'= vista la funzione matematica
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

### GGPLOT E DATAFRAME 
# Creo il vettore "class" a cui attribuisco tre nomi: "soil", "forest", "glacier" (suolo, foresta, ghiacciaio).
# Vettore y2018 e y2022 a cui sono attribuite le relative percentuali calcolate in precedenza.
# Costruisco un dataframe con al suo interno le classi e gli oggetti "y2018", "y2022", con al loro interno le percentuali della classificazione calcolate in precedenza.
# I dati sono poi impiegati per creare due grafici a barre per confrontare le distribuzioni delle classi nelle immagini a disposizione.
class <-c("soil", "forest", "glacier")
y2018 <-c(22.82045, 75.77918, 1.40037)
y2018
y2022 <-c(16.963336, 80.782776, 2.253888)
y2022
DATAFRAME<-data.frame(class,y2018,y2022)
# Si crea un grafico a barre utilizzando “ggplot” (dal pacchetto di funzioni "ggplot2") per rappresentare la distribuzione delle percentuali nelle 3 classi ("soil", "forest", "glacier").
 #"aes()" si usa per specificare l'estetica del grafico, così si specifica che nell'asse x viene inserito l'oggetto "class" e in y l'oggetto "y2018" e "y2022".
 #"fill=" specifica che il riempimento delle barre è dato dall'oggetto "class".
 #"geom_bar()" specifica che tipo di grafico si usa, ovvero quello a barre.
 #"color=black" indica che il bordo delle barre sono colorate con il nero.
 #"ylim(c(0, 100))" indica che la scala sull'asse y è impostata da 0 a 100.
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

## Classificazione e calcolo della frequenza con banda del Red Edge
im.classify
# Anno 2018
Tarvisio_2018_RE <-im.classify(Tarvisio2018_RE, num_clusters=3)
Tarvisio_2018_RE
# class 1 = soil (yellow)
# class 2 = forest (green)
# class 3 = glacier (violet)
# Anno 2022
Tarvisio_2022_RE <-im.classify(Tarvisio2022_RE, num_clusters=3)
Tarvisio_2022_RE
# class 1 = soil (violet)
# class 2 = forest (yellow)
# class 3 = glacier (green)

# Frequency year 2018
f2018_RE <- freq(Tarvisio_2018_RE)
tot2018_RE <- ncell(Tarvisio_2018_RE)
prop2018_RE <- f2018_RE / tot2018_RE
perc2018_RE <- prop2018_RE * 100
perc2018_RE
# percentages 2018:
# soil = 24.4%
# forest = 74%
# glacier = 1.4%
# Frequency year 2022
f2022_RE <- freq(Tarvisio_2022_RE)
tot2022_RE <- ncell(Tarvisio_2022_RE)
prop2022_RE <- f2022_RE / tot2022_RE
perc2022_RE <- prop2022_RE * 100
perc2022_RE
# percentages 2022:
# soil = 18%
# forest = 80%
# glacier = 2.3%



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




