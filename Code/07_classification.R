# R code classifying images

# install.packages("patchwork")
library(terra)
library(imageRy)
library(ggplot2) # package needed for the final graph (histograms)
library(patchwork) # package needed to couple graphs

im.list()

mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 <- flip(mato1992)
plot(mato1992)

mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 <- flip(mato2006)
plot(mato2006)

im.classify
mato1992c = im.classify(mato1992, num_clusters=2)
# class 1 = human (violet)
# class 2 = forest (yellow)

mato2006c = im.classify(mato2006, num_clusters=2)
# class 1 = forest (yellow)
# class 2 = human (violet)

# Frequency
f1992 <- freq(mato1992c)
tot1992 <- ncell(mato1992c)
prop1992 <- f1992 / tot1992
perc1992 <- prop1992 * 100

# percentages 1992:
# human = 83% 
# forest = 17%

perc1992 <- freq(mato1992c) * 100 / ncell(mato1992c)

# Exercise: calculate the percentages for 2006
f2006 <- freq(mato2006c)
tot2006 <- ncell(mato2006c)
prop2006 <- f2006 / tot2006
perc2006 <- prop2006 * 100
perc2006 <- freq(mato2006c) * 100 / ncell(mato2006c)

# percentages 2006:
# human = 55% 
# forest = 45%

# Istogramm
class <- c("Forest", "Human")
y1992 <- c(17,83)
y2006 <- c(45,55)
tabout <- data.frame(class, y1992, y2006)
tabout

library(ggplot2)
ggplot(tabout, aes(x=class, y=y1992, color=class)) + 
 geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=y2006, color=class)) + 
 geom_bar(stat="identity", fill="white")

library(patchwork)
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + 
 geom_bar(stat="identity", fill="white") +
 ylim(c(0,100)) +
 coord_flip()
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + 
 geom_bar(stat="identity", fill="white") +
 ylim(c(0,100)) +
 coord_flip()

p1 + p2
# with coord_flip()
p1 / p2

# Solar Orbiter 

im.list()

solar <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# Exercise: classify the image in three classes - im.classify()
solarc <- im.classify(solar, num_clusters=3)

# Plot che original image beside the classified one
dev.off()
im.multiframe(1,2)
plot(solar)
plot(solarc)

# 3 = low (yellow)
# 1 = high (green)
# 2 = medium (violet)

solarcs <- subst(solarc, c(3,1,2) , c("c1_low", "c3_high", "c2_medium"))
plot(solarcs) 

# Exercise: calculate the percentages of the Sun energy classes with one line of code
percsolar <- freq(solarc) * 100 / ncell(solarcs)

percsolar <- freq(solarcs)$count * 100 / ncell(solarcs)

# [1] 37.33349 41.44658 21.21993
# [1] 38 41 21

# create dataframe
class <- (c("c1_low", "c2_medium", "c3_high"))
perc < - c(38,41,21)
tabsol <- data.frame(class, perc)

# final ggplot
ggplot(tabout, aes(x=class, y=perc, fill=class, color=class)) + 
 geom_bar(stat="identity") + coord_flip()
# + scale_y_reverse()
