# PPP cleaning #################################
# created by: Iris Z. ##########################
# date: 3/4/2021 ###############################
# RE: rename variables based on codebook #######
# goal: human-readable variables; create #######
# standardized variables across years ##########
# according to PPP data needs ##################
rm(list = ls())
setwd("../PPP")

library("tidyr")

county2010 <- read_csv("2010 county/R12776803_SL050.csv")
acs2010 <- read_csv("2010 county/R12797711_SL050_ACS.csv")

acs2010 <- acs2010 %>%
  select(Geo_QName, SE_A12002_001:PCT_SE_A13001I_003)

county2010 <- 
  left_join(county2010, acs2010, by = "Geo_QName")

county2010 <- mutate(
  county2010, 
  pop = SE_T001_001,
  pwhite = PCT_SE_T055_003,
  pblack = PCT_SE_T055_004,
  phisp = PCT_SE_T055_010,
  pfb = NA,
  pnative = PCT_SE_T055_005,
  popdensity = SE_T002_002,
  popingq = SE_T067_002,
  group_institutionalized = SE_T067_003,
  group_inst_other = SE_T067_006,
  gqprison = SE_T067_004,
  unemp_m = PCT_SE_A17005A_003,
  unemp_f = PCT_SE_A17005B_003,
  unemp_black = PCT_SE_A17006B_003,
  unemp_hisp = PCT_SE_A17006H_003,
  unemp_white = PCT_SE_A17006I_003,
  unemp_native = PCT_SE_A17006C_003,
  unemp = PCT_SE_A17005_003,
  ppov = PCT_SE_A13002_002,
  povt_m = NA,
  povt_f = NA,
  povt_black = PCT_SE_A13001B_002,
  povt_white = PCT_SE_A13001I_002,
  povt_hisp = PCT_SE_A13001H_002,
  povt_native = PCT_SE_A13001C_002,
  ppovchld = PCT_SE_A13003A_002,
  pcol = PCT_SE_A12002_005,
  phs = PCT_SE_A12002_003,
  pnohs = PCT_SE_A12002_002,
  ppubassist = PCT_SE_A10014_002,
  pfemhh = PCT_SE_T058_006,
  mhinc = NA,
  mhmval = NA,
  age18to34 = PCT_SE_T011_003,
  age35to64 = PCT_SE_T011_004,
  age65p = PCT_SE_T011_005,
  pown = PCT_SE_T069_002,
  year = 2010
)

county2010 <- 
  select(county2010,
         c(1:11, pop:year)
  )

write_csv(county2010, "county2010_cleaned.csv")

setwd("../")
# combine files 
county1970 <- read_csv("1970 county/county1970_cleaned.csv")
county1980 <- read_csv("1980 county/county1980_cleaned.csv")
county1990 <- read_csv("1990 county/county1990_cleaned.csv")
county2000 <- read_csv("2000 county/county2000_cleaned.csv")
county2010 <- read_csv("2010 county/county2010_cleaned.csv")

names(county1970)
names(county1980)
names(county1990)
names(county2000)
names(county2010)

county1970 <- county1970 %>% select(c(Geo_FIPS, pwhite:year))
county1980 <- county1980 %>% select(c(STATEA, COUNTYA, pop:year)) %>%
  mutate(Geo_FIPS = paste0(STATEA, sprintf("%03s", COUNTYA))) %>%
  select(-c(STATEA, COUNTYA))
county1990 <- county1990 %>% select(c(Geo_FIPS, pop:year))
county2000 <- county2000 %>% select(c(Geo_FIPS, pop:year))
county2010 <- county2010 %>% select(c(Geo_FIPS, pop:year))

county1970$gqprison <- NA
county1980 <- county1980 %>% select(39, 1:38)
names(county1970)[8] <- "popdensity"
names(county1980)[8] <- "popdensity"
names(county1990)[8] <- "popdensity"
county1970 <- county1970 %>% select(1:11, 39, 12:38)
names(county1970)[32] <- "pfemhh"
county1970 <- county1970 %>% select(1, 7, 2:6, 8:39)

names(county1970) <- names(county2010)
names(county1980) <- names(county2010)
names(county1990) <- names(county2010)
names(county2000) <- names(county2010)

all <- base::rbind(county1970, 
             county1980, 
             county1990, 
             county2000, 
             county2010)

write.csv(all, "county_all.csv", row.names = F, na = "")

counties <- read.csv("county_all.csv", header = T, na = "")
counties_wide <- counties %>%
  pivot_wider(values_from = c(pop:pown),
              names_from = year)

cor(counties_wide$pop_2000, counties_wide$gqprison_2000, use = "complete.obs")
plot(counties_wide$gqprison_2000, counties_wide$pop_2000)
plot(counties_wide$gqprison_2000, counties_wide$unemp_2000)
plot(counties_wide$gqprison_2000, counties_wide$pblack_2000)

counties_wide <- counties_wide %>%
  mutate(pop_2000non = pop_2000-gqprison_2000,
         pblack_2000non = ((pblack_2000/100)*pop_2000/pop_2000non)*100)

plot(counties_wide$gqprison_2000, counties_wide$pblack_2000non)

summary(counties_wide$pblack_2000)
summary(counties_wide$pblack_2000non)
#counties are more black when prisoner population is not taken into account 

