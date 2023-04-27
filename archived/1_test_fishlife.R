
# Calculate the time varying trophic level 
library(FishLife)
library(rfishbase)
# Add the TL data to Y_ij

## Loop through fishbase to get TL ## 


df <- FishLife::FishBase

fish_spp <- df$Z_ik

rm(df) # Free up some space?
nspp <- dim(fish_spp)[1]
TL <- rep(NA, nspp)

i <- 1

for(i in 69:nspp){
  
name <- paste(fish_spp$Genus[i],fish_spp$Species[i])  
  
ecotmp <- rfishbase::ecology(name, fields = c('FoodTroph','DietTroph'))  
  
if(all(is.na(as.numeric(unlist(ecotmp)))) ==0){
  TL[i]<- mean(as.numeric(unlist(ecotmp)), na.rm = TRUE)  
}
  print(i) # This takes a while 
}

