#### # Set-up
install.packages("tidyverse")  
library(tidyverse)  
source("https://bioconductor.org/biocLite.R")  
biocLite("phyloseq")  
library(phyloseq)  
load("phyloseq_object.RData")

#### # ggplot with correct axes, but no data
ggplot(metadata, aes(x=O2_uM, y=Depth_m))

#### # ggplot with geom_point
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point()

#### # Same as above code
ggplot(metadata) +
  geom_point(aes(x=O2_uM, y=Depth_m))

#### # Aesthetic modifications (Wrong Color)
ggplot(metadata, aes(x=O2_uM, y=Depth_m, color="Blue")) +
  geom_point()

#### # Aesthetic modification (Right Color)
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(color="Blue")

#### # Aesthetic modification (Shape/Size)
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(shape="square")

ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(size=10)

#### # ggplot of oxygen data based on uM
ggplot(metadata, aes(x=O2_uM, y=Depth_m, size=OxygenSBE_V)) +
  geom_point()

#### # phyloseq plot
plot_bar(physeq, fill="Phylum")

#### # Conversion of physeq to percentage
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))

#### # Plot physeq conversion
plot_bar(physeq_percent, fill="Phylum")

#### # Black line removal for physeq conversion
plot_bar(physeq_percent, fill="Phylum") + 
  geom_bar(aes(fill=Phylum), stat="identity")

#### # Data separation into facets
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum)

#### # Plot editing (Removal of legends and scaling of y-axes)
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum, scales="free_y") +
  theme(legend.position="none")

#### Exercise 1
#### # Plot of NH4 with purple triangles
ggplot(metadata, aes(x=NH4_uM, y=Depth_m)) +
  geom_point(color="Purple", shape=17)

#### Exercise 2
#### # Convert Celsius to Fahrenheit and create dot plot of temperature in Fahrenheit against depth
Fahr_Data = metadata %>% mutate(Temperature_F = (Temperature_C*9/5) + 32) %>% select(Temperature_F, Depth_m)

ggplot(Fahr_Data, aes(x=Temperature_F, y=Depth_m)) + geom_point()

#### Exercise 3
#### # Title addition with more descriptive x and y axis labels
plot_bar(physeq_percent, fill="Phylum") + 
  geom_bar(aes(fill=Phylum), stat="identity") + ggtitle("Phyla from 10 to 200 m in Saanich Inlet") + xlab("Sample Depth") + ylab("Percent Relative Abundance")

#### Exercise 4
#### # Select nutrient concentrations
Nutrient_Concentrations = metadata %>% select(Depth_m, O2_uM, PO4_uM, SiO2_uM, NO3_uM, NH4_uM, NO2_uM)

#### # Collapse all nutrient concentrations into depths
Nutrient_Depths = gather(Nutrient_Concentrations, "Nutrients", "uM", -1)

#### # Calculate nM from uM and create column
Nutrient_Depths$nM <- Nutrient_Depths$uM * 1000

#### # Plot faceted figure of all nutrient concentrations
ggplot(Nutrient_Depths, aes(x=Depth_m, y=nM)) + geom_point() + geom_line() + facet_wrap(~Nutrients, scales="free_y")