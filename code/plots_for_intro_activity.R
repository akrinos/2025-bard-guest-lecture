pacman::p_load(dplyr,tidyverse,ggplot2,ncdf4,
               patchwork,sf,maps,ggnewscale)

combined_data = read.csv("data/combined_data.csv")
world <- map_data("world")

cruise_traject_chlorophyll = ggplot(data = world) +
  geom_polygon(data=world, mapping=aes(long, lat, group = group), fill = "white", colour = "black") + 
  coord_sf(xlim = c(-85, -60), ylim = c(29, 42), expand = FALSE) +
  geom_point(data=combined_data,
            aes(y=Latitude,x=Longitude,
                color=Chlorophyll_ug_l ),size=2)+
  ggtitle("Cruise trajectory with proxy\nfor microbes (phytoplankton)") + 
  xlab("Longitude")+ylab("Latitude")+theme_bw(base_size=16) +
  scale_color_gradient(low = "#ffffc5", high = "#06402B", na.value = NA, name = "Chlorophyll (ug/L)")

cruise_traject_temperature = ggplot(data = world) +
  geom_polygon(data=world, mapping=aes(long, lat, group = group), fill = "white", colour = "black") + 
  coord_sf(xlim = c(-85, -60), ylim = c(29, 42), expand = FALSE) +
  geom_point(data=combined_data,
            aes(y=Latitude,x=Longitude,
                color=Water_Temp_C ),size=2)+
  ggtitle("Cruise trajectory with temperature") + 
  xlab("Longitude")+ylab("Latitude")+theme_bw(base_size=16) +
  scale_color_gradient(low = "#ffffc5", high = "#900d09", 
                       na.value = NA, name = "Temperature (°C)")

cruise_traject_chlorophyll / cruise_traject_temperature + plot_annotation(tag_levels = 'A') 
