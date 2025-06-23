# La vegetazione di Tarvisio

L'obiettivo dell'analisi studio è di osservare i cambiamenti e/o perdita di vegetazione nell zona di Tarvisio, territorio situato in Friuli Venezia Giulia, a causa di stress dovuti a cambiamenti ambientali o patologie vegetali quali la processionaria del pino e il bostrico del castagno. 
Sono stati presi in considerazione due anni nel periodo che si estende dal 01 febbraio al 30 giugno (2018 - 2022). 
Le immagini scelte sono state prese dal sito "Copernicus Browser" utilizzando InstrumentSentinel-2 MSI: Multispectral Instrument
- https://developers.google.com/earth-engine/datasets/catalog/sentinel?hl=it
- https://code.earthengine.google.com/?scriptPath=Examples%3ADatasets%2FCOPERNICUS%2FCOPERNICUS_S2_SR_HARMONIZED&hl=it

``` r
library(terra)       # Gestione e analisi raster
library(raster)      # Compatibilità con vecchi script raster
library(ggplot2)     # Grafici e visualizzazioni
library(patchwork)   # Composizione di più grafici
library(viridis)     # Palette di colori accessibili         
                     # https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
library(imageRy)     # Pacchetto in R con specializzazione per analisi geospaziale e manipolazione di dati raster
```
## Importazione Immagini
Le immagini selezionate coprono la zona di Malborghetto, Camporosso in Valcanale e Tarvisio, aree montuose maggiormente colpite dalla processionaria e dal bostrico.
``` r
Exporting data
\ change direction
Windowds users: C://comp/Downloads
setwd("C://nome/Downloads")
setwd("C:/Users/user/Desktop/Telerilevamento/Immagini")
```
- L'obiettivo è costruire un’unica immagine con 4 bande: b2, b3, b4, b8 (blue, red, green, nir).
- L'obiettivo è costruire un’unica immagine con 4 bande: b2, b3, b5, b8 (blue, red edge, green, nir).

### True Color Vegetation (RGB naturale)
![image](https://github.com/user-attachments/assets/a506d472-ce8e-4245-a065-22d3fbd7432a)
### False color vegetazion (NIR/Red/Green)
![image](https://github.com/user-attachments/assets/6e7d0d4b-284c-4bc2-bcb4-3ee248fca3bc)
### False color vegetation (NIR/Red Edge/Blue)
![image](https://github.com/user-attachments/assets/480a91fe-fd66-4082-917d-5c685950ff4e)

## Visualizzazione della vegetazione in funzione del NIR
Usando la funzione "im.plotRGB()" del pacchetto "imageRy", vado a sostituire il nir con le altre bande rgb per osservare come varia la visualizzazione della vegetazione presente.
### Plot a confronto
### Vegetazione rossa: Nir , Green, Blue
Nir su red: questo comporta una visualizzazione che evidenzia le caratteristiche della vegetazione poichè la vegetazione riflette molto di più nel nir rispetto alle altre superfici, andando a facilitarne l'identificazione. Si può anche capirne le condizioni di salute poichè più queste sono in buona salute, più il nir viene riflesso, e più l'immagine sarà luminosa.
![image](https://github.com/user-attachments/assets/ec45f47e-2738-422b-b601-0ec6086f201c)
### Vegetazione blu: Red, Green, Nir
Nir sul blu: la vegetazione sarà visivamente di colore blu. Inoltre, il suolo diventerà di colore giallo andando a fornire un ottimo contrasto tra vegetazione e suolo.
![image](https://github.com/user-attachments/assets/0a56033a-6390-44b2-a21b-fcf933144eef)
## Vegetazione verde: Red, Nir, Bue
Nir sul green: la vegetazione sarà visivamente di colore verde, dando un aspetto più naturale all’immagine.
![image](https://github.com/user-attachments/assets/559a7691-b25a-48e8-9eb4-a8e941763541)

## Calcolo dell'Indice di variabilità: DVI e NDVI e NDRE
### Calcolo DVI: Indice di differenza di vegetazione.
Questo indice va a sfruttare l'alta capacità di riflettanza dell'infrarosso (nir) e l'alta capacità di assorbimento del rosso (red) per determinare, attraverso una differenza nir-red, la biomassa/densità di vegetazione presente.
``` r
### Calculate dvi for 2018
dvi2018 = Tr2018_nir - Tr2018_br # NIR - red
dvi2018
I risultati del 2018 sono: min -0.20, max 0.69
### Calculate dvi for 2022
dvi2022 = Tr2022_nir - Tr2022_br # NIR - red
dvi2022
I risultati del 2022 sono: min -0.19, max 0.67
```
![image](https://github.com/user-attachments/assets/938071fd-8ec8-4f78-93b8-b62354bda341)

### Calcolo NDVI: indice di differenza normalizzata delle vegetazioni impiegando i valori delle bande rosse e infrarosse delle immagini.
Viene calcolata con la formula NDVI = (nir-red/nir+red) che mi permette di andare a confrontare i valori tra immagini che hanno una risoluzione radiometrica diversa.
``` r
### Calculate ndvi for 2018
ndvi2018 = (Tr2018_nir - Tr2018_br) / (Tr2018_nir + Tr2018_br)
ndvi2018
ndvi2018 = dvi2018 / (Tr2018_nir + Tr2018_br)
I risultati del 2018 sono: min -0.45, max 0.91
### Calculate ndvi for 2022
ndvi2022 = (Tr2022_nir - Tr2022_br) / (Tr2022_nir + Tr2022_br)
ndvi2022
ndvi2022 = dvi2022 / (Tr2022_nir + Tr2022_br)
I risultati del 2022 sono: min -0.42, max 0.99
```
![image](https://github.com/user-attachments/assets/bd11476d-51bd-4921-a7a6-c171e1735034)

### Calculate NDRE (Normalized Difference Red Edge) si basa sulla differenza tra le riflettanze nelle bande del Red Edge e del vicino infrarosso (NIR). 
L'NDRE aiuta a individuare stress o alterazioni fisiologiche nelle piante prima che siano visibili ad occhio nudo, permettendo interventi più tempestivi.
``` r
### Calculate ndre for 2018
ndre2018 = (Tr2018_bnir - Tr2018_bRE) / (Tr2018_bnir + Tr2018_bRE)
ndre2018
I risultati del 2018 sono: min -0.57, max 0.72
### Calculate ndre for 2022
ndre2022 = (Tr2022_bnir - Tr2022_bRE) / (Tr2022_bnir + Tr2022_bRE)
ndre2022
I risultati del 2022 sono: min -0.50, max 0.86
```
![image](https://github.com/user-attachments/assets/9921bd55-2fc2-4ddd-81cf-9dbe3bef05e5)

## Ggplot e Dataframe 
Costruisco un dataframe con al suo interno le classi e gli oggetti "y2018", "y2022", con al loro interno le percentuali della classificazione calcolate in precedenza.
I dati sono poi impiegati per creare due grafici a barre per confrontare le distribuzioni delle classi delle immagini a disposizione.
``` r
Si crea un grafico a barre utilizzando “ggplot” (dal pacchetto di funzioni "ggplot2") per rappresentare la distribuzione delle percentuali nelle 3 classi ("soil", "forest", "glacier").
 #"aes()" si usa per specificare l'estetica del grafico, così si specifica che nell'asse x viene inserito l'oggetto "class" e in y l'oggetto "y2018" e "y2022".
 #"fill=" specifica che il riempimento delle barre è dato dall'oggetto "class".
 #"geom_bar()" specifica che tipo di grafico si usa, ovvero quello a barre.
 #"color=black" indica che il bordo delle barre sono colorate con il nero.
 #"ylim(c(0, 100))" indica che la scala sull'asse y è impostata da 0 a 100.
```

``` r
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
```
![image](https://github.com/user-attachments/assets/efb23b17-854a-40dd-8f46-8456e786ea8c)

## Conclusione
I valori degli indici di vegetazione DVI, NDVI e NDRE analizzati per i due anni 2018 e 2022 mostrano una situazione in generale stabile, con tendenze di miglioramento nella salute vegetativa localizzato.
L'indice DVI evidenzia come in entrambi gli anni i valori variano da negativi a prossimi allo zero, indicativi di suolo nudo, presenza di ghiaccio o aree urbanizzate) fino a circa 0.7, che denota la presenza di vegetazione densa e sana. 
Ciò significa che la distribuzione generale della vegetazione non ha subito drastici cambiamenti tra il 2018 e il 2022.
Tuttavia sia l'indice NDVI che NDRE evidenziano un leggero incremento dei valori massimi nel 2022, indicando un miglior assorbimento nella banda del rosso, un aumento della riflettanza nel vicino infrarosso e nel Red Edge; quindi una maggiore attività fotosintetica e miglior stato fisiologico della vegetazione. 
In sintesi, nonostante la presenza di potenziali patologie vegetali, l'analisi studio indica che tra il 2018 e il 2022 si è verificato un lieve miglioramento della vegetazione sia in termini di quantità (copertura) che qualità (salute fisiologica).

# Fine
