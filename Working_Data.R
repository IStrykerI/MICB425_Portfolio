#Day 1
install.packages("tidyverse")
library(tidyverse)
#In Terminal, copy data
#cp ~/Desktop/MICB425/MICB425_Materials/Saanich... ~/Desktop/MICB425/MICB425_Portfolio

#Load Data
read.table(file="Saanich.metadata.txt")
metadata <- read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t", na.strings=c("NAN", "NA", "."))
OTUdata <- read.table(file="Saanich.OTU.txt", header=TRUE, row.names=1, sep="\t", na.strings=c("NAN", "NA", "."))

#Day 2
install.packages("tidyverse")
library(tidyverse)
#data %>% function
#function(data)

#Select O2_uM data
metadata %>% select(O2_uM)

#Select variables with O2 or oxygen in name
metadata %>% select(matches("O2|oxygen"))

#Filter rows (Samples where oxygen = 0)
metadata %>% filter(O2_uM == 0)

#Filter rows (Samples where oxygen = 0)
metadata %>% filter(O2_uM == 0) %>% select(Depth_m)

#Find depths where methane is above 100 nM while temperature is below 10. Print out table showing only depth, methane, and temperature data
metadata %>% filter(Temperature_C < 10, CH4_nM > 100) %>% select(Depth_m, CH4_nM, Temperature_C)

#Mutate data
metadata %>% mutate(N2O_uM = N2O_nM/1000) %>% select(N2O_uM, N2O_nM)

#Convert all variables that are in nM to uM. Output a table showing only the original nM and converted uM variables
#Show nM columns
metadata %>% select(matches("nM"))
Conversion_Table = metadata %>% mutate(N2O_uM = N2O_nM/1000, Std_N2O_uM = Std_N2O_nM/1000, CH4_uM = CH4_nM/1000, Std_CH4_uM = Std_CH4_nM/1000) %>% select(N2O_uM, N2O_nM, Std_N2O_uM, Std_N2O_nM, CH4_uM, CH4_nM, Std_CH4_uM, Std_CH4_nM)
