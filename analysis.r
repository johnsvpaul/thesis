# Load a few useful packages
library(knitr)
library(tidyverse)
library(data.table)
library(ggplot2)
library(gganimate)
library(hexbin)
library(h3)
library(lubridate)
library(sp)

## Retrieve info on the hotspots
hotspotInfo <- fread(file = "R/hotspots.csv.gz", select = c("address", "owner", "first_timestamp")) %>%
       rename(
              hotspot = address,
              firstDate = first_timestamp
       ) %>%
       # remove hotspots with a date of 1970 as this is an error
       filter(firstDate != as.POSIXct("1970-01-01 00:00:00", tz = "UTC")) %>%
       mutate(
              hotspot = factor(hotspot),
              # remove time as only date is needed
              firstDate = round_date(firstDate, "day"),
              owner = factor(owner)
       ) %>%
       select(hotspot, owner, firstDate)
## Save hotspot info
saveRDS(hotspotInfo, "R/hotspotInfo.rds")
hotspotInfo <- readRDS("R/hotspotInfo.rds")
