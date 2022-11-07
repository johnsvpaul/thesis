### Retrieve transferred packed dataset (transactions)
dataTransactions <- fread(file = paste0("R/packets/packets.csv.gz"), select = c("block", "transaction_hash", "time", "gateway", "num_dcs"))

dataTransactions <- dplyr::bind_rows(dataTransactions) %>%
  mutate(
    bytes = 24 * num_dcs, # Every 24 bytes sent in an uplink or downlink packet cost 1 DC = $.00001.
    date = as.POSIXct(time, origin = "1970-01-01"), # convert unix time to standard date format
    date = round_date(date, "day"), # remove time as only date is needed
    gateway = factor(gateway)
  ) %>%
  # select all columns except these:
  select(-time, -num_dcs, -transaction_hash) %>%
  rename(hotspot = gateway)

saveRDS(dataTransactions, "R/dataTransactions.rds")
dataTransactions <- readRDS("R/dataTransactions.rds")
