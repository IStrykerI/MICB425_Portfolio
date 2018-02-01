#Comments
install.packages("tidyverse")
library(tidyverse)
#In Terminal, copy data
#cp ~/Desktop/MICB425/MICB425_Materials/Saanich... ~/Desktop/MICB425/MICB425_Portfolio

#Load Data
read.table(file="Saanich.metadata.txt")
metadata <- read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t", na.strings=c("NAN", "NA", "."))
OTUdata <- read.table(file="Saanich.OTU.txt", header=TRUE, row.names=1, sep="\t", na.strings=c("NAN", "NA", "."))
