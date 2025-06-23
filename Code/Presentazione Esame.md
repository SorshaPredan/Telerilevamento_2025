# La vegetazione di Tarvisio

Lo scopo del lavoro è quello di osservare i cambiamenti e/o perdita di vegetazione nell zona di Tarvisio, territorio situato in Friuli Venezia Giulia, a causa di stress dovuti a cambiamenti ambientali o patologie vegetali quali la processionaria del pino e il bostrico del castagno. 
Sono stati presi in considerazione due anni nel periodo che si estende dal 01 febbraio al 30 giugno (2018 - 2022). 
Le immagini scelte sono state prese dal sito "Copernicus Browser" utilizzando InstrumentSentinel-2 MSI: Multispectral Instrument
- https://developers.google.com/earth-engine/datasets/catalog/sentinel?hl=it
- https://code.earthengine.google.com/?scriptPath=Examples%3ADatasets%2FCOPERNICUS%2FCOPERNICUS_S2_SR_HARMONIZED&hl=it



``` r
im.list() # make a list
gr = im.import("greenland") # to import the image
```

Then, we might calculate the difference of values of two images

``` r
grdif = gr[[4]] - gr[[1]]
```

This will create the following output image:

<img src="../Pics/output.jpeg" width=100% />

> Note 1: If you want to put pdf files you can rely on: https://stackoverflow.com/questions/39777166/display-pdf-image-in-markdown

> Note 2: Infrormation abou the Copernicus program can be found at: https://www.copernicus.eu/it

> Here are the [Sentinel data used](https://dataspace.copernicus.eu/explore-data/data-collections/sentinel-data/sentinel-2)
