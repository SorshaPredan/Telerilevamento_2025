### La vegetazione di Tarvisio
## Lo studio vuole verificare i cambiamenti e/o perdita di vegetazione nell zona di Tarvisio, territorio situato in Friuli Venezia Giulia, 
# a causa di stress dovuti a cambiamenti ambientali o patologie vegetali quali la processionaria del pino e il bostrico del castagno. 
# Sono stati presi in considerazione due anni nel periodo che si estende dal 01 febbraio al 30 giugno (2018 - 2022). 
# Le immagini scelte sono state prese dal sito "Copernicus Browser" utilizzando InstrumentSentinel-2 MSI: Multispectral Instrument
# https://developers.google.com/earth-engine/datasets/catalog/sentinel?hl=it
# https://code.earthengine.google.com/?scriptPath=Examples%3ADatasets%2FCOPERNICUS%2FCOPERNICUS_S2_SR_HARMONIZED&hl=it
# Il codice è stato scritto impiegando i seguenti pacchetti per analisi geospaziale e visualizzazione raster
library(terra)       # Gestione e analisi raster
library(raster)      # Compatibilità con vecchi script raster
library(ggplot2)     # Grafici e visualizzazioni
library(patchwork)   # Composizione di più grafici
library(viridis)     # Palette di colori accessibili         
                     #https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
library(imageRy)     #Pacchetto in R con specializzazione per analisi geospaziale e manipolazione di dati raster.

### IMPORTAZIONE IMMAGINI
# Le immagini selezionate coprono la zona di Malborghetto, Camporosso in Valcanale e Tarvisio, aree montuose maggiormente colpite dalla processionaria e dal bostrico.
# Per ciascun anno (2018 - 2022) sono state utilizzate 3 immagini satellite "Sentinel-2”: 
  # - True Color: con le bande B4, B3 e B2 (Red, Green, Blue: RGB); 
  # - False Color: con le bande B8, B4 e B3 (NIR, Red, Green); 
  # - False Color: con le bande B8, B5 e B2 (NIR, Red Edge, Blue).
# L'obiettivo è costruire un’unica immagine con 4 bande: b2, b3, b4, b8 (blue, red, green, nir).
# L'obiettivo è costruire un’unica immagine con 4 bande: b2, b3, b5, b8 (blue, red edge, green, nir).
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
plotRGB(Tr_2018, r=3, g=2, b=1, stretch="lin", main="Vegetazione 2018")
plotRGB(Tr_2022, r=3, g=2, b=1, stretch="lin", main="Vegetazione 2022")
# False color vegetazion (NIR/Red/Green)
plotRGB(TrNIR_2018, r="B8", g="B4", b="B3", stretch="lin", main="Vegetazione 2018")
plotRGB(TrNIR_2022, r="B8", g="B4", b="B3", stretch="lin", main="Vegetazione 2022")
# Vegetation false color (NIR/Red Edge/Blue)
plotRGB(TrRedE_2018, r="B8", g="B5", b="B2", stretch="lin", main="Vegetazione 2018")
plotRGB(TrRedE_2022, r="B8", g="B5", b="B2", stretch="lin", main="Vegetazione 2022")

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
plot(dvi2018, col=inferno (100), main="DVI - 2018")
plot(dvi2022, col=inferno (100), main="DVI - 2022")

# Calcolo NDVI: indice di differenza normalizzata delle vegetazioni impiegando i valori delle bande rosse e infrarosse delle immagini.
# Viene calcolata con la formula NDVI = (nir-red/nir+red) che mi permette di andare a confrontare i valori tra immagini che hanno una risoluzione radiometrica diversa
# Interpretazione dati relativi a NDVI: valori alti, vicini a +1 = vegetazione densa e sana; valori vicini 0= vegetazione scarsa, neve/ghiaccio o suolo nudo; valori bassi vicini a -1 = superfici non coperte da vegetazione o urbanizzate come costruzioni o strade.
# Calculate ndvi for 2018
ndvi2018 = (Tr2018_nir - Tr2018_br) / (Tr2018_nir + Tr2018_br)
ndvi2018
# ndvi2018 = dvi2018 / (Tr2018_nir + Tr2018_br)
# I risultati del 2018 sono: min -0.45, max 0.91
plot(ndvi2018)
# Calculate ndvi for 2022
ndvi2022 = (Tr2022_nir - Tr2022_br) / (Tr2022_nir + Tr2022_br)
ndvi2022
# ndvi2022 = dvi2022 / (Tr2022_nir + Tr2022_br)
# i risultati del 2022 sono: min -0.42, max 0.99
plot(ndvi2022)

summary(values(ndvi2018))
summary(values(ndvi2022))
im.multiframe(2,1)
plot(ndvi2018, col=inferno (100), main="NDVI - 2018")
plot(ndvi2022, col=inferno (100), main="NDVI - 2022")
dev.off()

# Visualizzazione statistica attraverso un istogramma
hist(ndvi2018, main="Histogram NDVI 2018", col="forestgreen")
hist(ndvi2022, main="Histogram NDVI 2022", col="darkred")

dev.off()

# Calcolo NDRE (Normalized Difference Red Edge) si basa sulla differenza tra le riflettanze nelle bande del Red Edge e del vicino infrarosso (NIR). 
# L'NDRE aiuta a individuare stress o alterazioni fisiologiche nelle piante prima che siano visibili ad occhio nudo, permettendo interventi più tempestivi. 
# È particolarmente utile in ambienti agricoli o forestali dove la diagnosi precoce è fondamentale per la gestione delle malattie.
# Interpretazione dati relativi a NDRE: valori elevati (vicino a +1) indicano una buona presenza di clorofilla e, quindi, una buona salute vegetale; mentre valori bassi (vicino a 0 o negativi) possono indicare stress, carenze di nutrienti, malattie o altre condizioni che riducono la quantità di clorofilla.
# Calculate ndre for 2018
ndre2018 = (Tr2018_bnir - Tr2018_bRE) / (Tr2018_bnir + Tr2018_bRE)
ndre2018
# I risultati del 2018 sono: min -0.57, max 0.72
plot(ndre2018)
# Calculate ndre for 2022
ndre2022 = (Tr2022_bnir - Tr2022_bRE) / (Tr2022_bnir + Tr2022_bRE)
ndre2022
# I risultati del 2022 sono: min -0.50, max 0.86
plot(ndre2022)

summary(values(ndre2018))
summary(values(ndre2022))
im.multiframe(2,1)
plot(ndre2018, col=inferno (100), main="NDRE - 2018")
plot(ndre2022, col=inferno (100), main="NDRE - 2022")
dev.of()

# Visualizzazione statistica attraverso un istogramma
hist(ndre2018, main="Histogram NDRE 2018", col="forestgreen")
hist(ndre2022, main="Histogram NDRE 2022", col="darkred")

dev.off() 

## Calcolo delle differenze tra i due anni considerati del NDVI e NDRE per osservare eventuali cambiamenti di vegetazione
# Valori positivi stanno ad indicare una maggiore presenza di vegetazione
diff_ndvi <- ndvi2022 - ndvi2018
diff_ndvi
plot(diff_ndvi, col=inferno (100), main="NDVI Difference (2022 - 2018)")
diff_ndre <- ndre2022 - ndre2018
diff_ndre
plot(diff_ndre, col=inferno (100), main="NDRE Difference (2022 - 2018)")

im.multiframe(2,1)
plot(diff_ndvi, col=inferno (100), main="NDVI Difference (2022 - 2018)")
plot(diff_ndre, col=inferno (100), main="NDRE Difference (2022 - 2018)")

# Classificazione delle differenze per evidenziare cambiamenti notevoli di vegetazione
ndvi_change_class <- classify(diff_ndvi, rbind(
 c(-Inf, -0.2, 1),   # forte diminuzione
 c(-0.2, 0.2, 2),    # cambiamento minimo 
 c(0.2, Inf, 3)      # forte aumento
))
plot(ndvi_change_class, col=c("red", "yellow", "blue"), main="Classificazione cambiamento NDVI")

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
Anno2022 <-ggplot(DATAFRAME, aes(x=class, y=y2022, fill=class))+ 
 geom_bar(stat="identity", color="black") + 
 ylim(c(0, 100))
Anno2022

dev.off()

# Creazione di un Plot Comparativo tra i due anni così da avere un grafico a barre affiancate
library(tidyr)
DATAFRAME_long <- pivot_longer(DATAFRAME, cols = c("y2018", "y2022"), 
                                names_to = "year", values_to = "percent")
# Plot comparativo
ggplot(DATAFRAME_long, aes(x=class, y=percent, fill=year))+ 
 geom_bar(stat="identity", position=position_dodge(width=0.8), color="black") + 
 ylim(0, 100) +
 labs(title="Distribuzione percentuale classi (2018 vs 2022)",
     x="Classe", y="Percentuale (%)", fill="Anno") +
 theme_minimal()

dev.off()
               
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

## Ggplot e Dataframe
class2 <-c("soil", "forest", "glacier")
y2018_RE <-c(24.368530, 74.208172, 1.423299)
y2018_RE
y2022_RE <-c(17.514033, 80.202510, 2.283457)
y2022_RE
DATAFRAME2<-data.frame(class2,y2018_RE,y2022_RE)
# Anno 2018
Anno2018_RE <-ggplot(DATAFRAME2,aes(x=class2, y=y2018_RE, fill=class2))+ 
 geom_bar(stat="identity", color="black") + 
 ylim(c(0, 100))
Anno2018_RE
# Anno 2022
Anno2022_RE <-ggplot(DATAFRAME2,aes(x=class2, y=y2022_RE, fill=class2))+ 
 geom_bar(stat="identity", color="black") + 
 ylim(c(0, 100))
Anno2022_RE

### TIMESERIES
# Si va a visualizzare la differenza pixel per pixel fra le 2 immagini usando una palette di colori per evidenziare le variazioni.
# Si osservano le differenze esistenti tra le immagini in termini di intensità dei pixel a scopo di ottenere visivamente i cambiamenti della zona d’interesse.
# Calcolo la differenza tra le immagini della banda del Nir. 
# Creo una palette di colori che va dal blu al giallo al rosso con 100 gradazioni per avere più fluidità nei passaggi da un colore all’altro. 
 #I pixel blu indicano una minore intensità nella prima immagine rispetto alla seconda, cioè una probabile diminuzione dell'intensità del nir e quindi una probabile riduzione della vegetazione.
 #I pixel gialli indicano invece una assenza di intensità.
 #I pixel rossi indicano poi una maggiore intensità nella prima immagine rispetto alla seconda, ovvero un aumento dell'intensità del nir e quindi una crescita della vegetazione.
diffnir1822<-Tarvisio2018[[4]] - Tarvisio2022[[4]]
diffnir1822
diffnir2218<-Tarvisio2022[[4]] - Tarvisio2018[[4]]
diffnir2218
cl <- colorRampPalette(c("blue", "yellow", "red"))(100)

im.multiframe(2,1)
plot(diffnir1822, col=cl, main="NIR: 2018 - 2022")
plot(diffnir1822, col=cl, main="NIR: 2022 - 2018")

### CONCLUSIONE
# I valori degli indici di vegetazione DVI, NDVI e NDRE analizzati per i due anni 2018 e 2022 mostrano una situazione in generale stabile. 
# L'indice DVI evidenzia come in entrambi gli anni i valori variano da negativi a prossimi allo zero, indicativi di suolo nudo, presenza di ghiaccio o aree urbanizzate
# fino a circa 0.7, che denota la presenza di vegetazione densa e sana. 
# Ciò significa che la distribuzione generale della vegetazione non ha subito drastici cambiamenti tra il 2018 e il 2022.
# Tuttavia sia l'indice NDVI che NDRE evidenziano un leggero incremento dei valori massimi nel 2022, indicando un miglior assorbimento nella banda del rosso, un aumento della riflettanza nel vicino infrarosso e nel Red Edge;
# quindi una maggiore attività fotosintetica e miglior stato fisiologico della vegetazione. 
# In sintesi, nonostante la presenza di potenziali patologie vegetali, l'analisi studio indica che tra il 2018 e il 2022 si è verificato un lieve miglioramento della vegetazione sia in termini di quantità (copertura) che qualità (salute fisiologica).

# FINE
