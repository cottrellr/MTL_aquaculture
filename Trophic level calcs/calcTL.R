# Calculate the trophic level catch by getting TL from forage species and weighing it by catch
library(dplyr)
library(rfishbase)
library(ggplot2)
source('weighted_mean.R') # Calculates a weighted mean with NA in weights
# Get the catches of forage fish 

df.old <- read.csv('marinecatches.csv')
df <- df[df$size == 'Small',]

df.new <- read.csv('fao_catches_2019.csv')
df <- df.new[df.new$size == 'Small',]
# # 
yrs <- sort(unique(df$Year))


spp <- unique(df$Species)

# TL <- rep(NA, length(spp))
# 
# for(i in 1:length(spp)){ # Improve this later with the FishLife method
# 
#   ecotmp <- rfishbase::ecology(spp[i], fields = c('FoodTroph','DietTroph'))
# 
#   if(all(is.na(as.numeric(unlist(ecotmp)))) ==0){
#     TL[i]<- mean(as.numeric(unlist(ecotmp)), na.rm = TRUE)
#   }
#   print(i) # This takes a while
#   rm(ecotmp)
# }
# 
# # Calculate the trophic level over time   
# df.export <- data.frame(spp = spp, TL= TL)
# write.csv(df.export, file = 'TL_forage.csv', row.names = FALSE)
TL <- read.csv('TL_forage.csv')  

df.tot <- df %>% 
  group_by(Year, Species) %>% 
  summarise(Catch = sum(Catch, na.rm=TRUE))


# Plot the total catch over time 
df.tot %>% 
  group_by(Year) %>% 
  summarise(Catch = sum(Catch, na.rm=TRUE)) %>% 
  ggplot(aes(x= Year, y = Catch*1e-6))+geom_line()+theme_bw()+scale_y_continuous('Forage fish Catch\n (million tonnes)')


# Calculate the trophic level over time 

df.tot$TL <- NA

for(i in 1:length(spp)){
  idx <- which(as.character(df.tot$Species) == as.character(TL$spp[i]))
  df.tot$TL[idx] <- TL$TL[i]
}


df.tot %>% 
  group_by(Year) %>% 
  summarise(TL = weighted_mean(TL,Catch, na.rm = TRUE)) %>% 
  ggplot(aes(x = Year, y = TL))+geom_line(color = alpha('Darkred', alpha = 0.8), size = 1.5)+theme_classic()+
  coord_cartesian(ylim = c(2.5,3.5))

