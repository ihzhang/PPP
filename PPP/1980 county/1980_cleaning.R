# PPP cleaning #################################
# created by: Iris Z. ##########################
# date: 3/4/2021 ###############################
# RE: rename variables based on codebook #######
# goal: human-readable variables; create #######
# standardized variables across years ##########
# according to PPP data needs ##################

setwd("../1980 county")
files <- list.files(pattern="*.csv") # makes sure cleaned .csv is not in folder before running this
county1980 <- do.call(cbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))
county1980 <- county1980[, !duplicated(colnames(county1980))]

county1980 <- mutate(
  county1980, 
  pop = rowSums(county1980[, c(which(names(county1980)=="C9L001"):which(names(county1980)=="C9L010"))]),
  pwhite = (C9L006/pop)*100,
  pblack = (C9L007/pop)*100,
  phisp = ((C9L001+C9L002+C9L003+C9L004+C9L005)/pop)*100,
  pfb = (DG6004/pop)*100,
  pnative = (C9L009/pop)*100,
  popdensiity = SE_A001_002,
  popingq = rowSums(county1980[, c(which(names(county1980)=="DXD001"):which(names(county1980)=="DXD007"))]),
  group_institutionalized = (DXD001+DXD001+DXD003+DXD004),
  group_inst_other = DXD007,
  gqprison = DXD003,
  unemp_m = (SE_T041_003/SE_T041_001)*100,
  unemp_f = (SE_T042_003/SE_T042_001)*100,
  unemp_black = (SE_T044_003/SE_T044_001)*100,
  unemp_hisp = (SE_T048_003/SE_T048_001)*100,
  unemp_white = (SE_T043_003/SE_T043_001)*100,
  unemp_native = (SE_T045_003/SE_T045_001)*100,
  unemp = (SE_T040_003/SE_T040_001)*100,
  ppov = (DI8002/pop)*100,
  povt_m = NA,
  povt_f = NA,
  povt_black = (SE_T103_002/SE_T103_001)*100,
  povt_white = (SE_T102_002/SE_T102_001)*100,
  povt_hisp = (SE_T107_002/SE_T107_001)*100,
  povt_native = (SE_T104_002/SE_T104_001)*100,
  ppovchld = NA,
  pcol = ((DX4005 + DX4010 + DX4015 + DX4020 + DX4025 + DX4030)/rowSums(county1980[, c(which(names(county1980)=="DX4001"):which(names(county1980)=="DX4030"))]))*100,
  phs = ((DX4003 + DX4008 + DX4013 + DX4018 + DX4023 + DX4028)/rowSums(county1980[, c(which(names(county1980)=="DX4001"):which(names(county1980)=="DX4030"))]))*100,
  pnohs = (100-pcol-phs),
  ppubassist = (DSN002/(DSN001+DSN002))*100,
  pfemhh= ((C7H002+C7H005+C7H007)/(rowSums(county1980[, c(which(names(county1980)=="C7H001"):which(names(county1980)=="C7H007"))]))),
  mhinc = SE_T053_001,
  mhmval = C8J001,
  age18to34 = (rowSums(county1980[, c(which(names(county1980)=="C67012"):which(names(county1980)=="C67018"))])/pop)*100,
  age35to64 = (rowSums(county1980[, c(which(names(county1980)=="C67019"):which(names(county1980)=="C67023"))])/pop)*100,
  age65p = (rowSums(county1980[, c(which(names(county1980)=="C67024"):which(names(county1980)=="C67026"))])/pop)*100,
  pown = (C7W001/(C7W001 + C7W002))*100,
  year = 1980
)

county1980 <- 
  select(county1980,
         c(1, 3:9, 23, pop:year)
  )

write_csv(county1980, "county1980_cleaned.csv")

# for posterity: here is a log of how variable decisions were made ####
# Total Population = rowSums(county1980[, c(which(names(county1980)=="C9L001"):which(names(county1980)=="C9L010"))]),
# Percent White = (C9L006/pop)*100,
# Percent Black = (C9L007/pop)*100,
# Percent Hispanic/Latino = ((C9L001+C9L002+C9L003+C9L004+C9L005)/pop)*100,
# Percent Foreign-born = (DG6004/pop)*100,
# Percent Native American = (C9L009/pop)*100,
# Population Density OR Land Area = SE_A001_002,
# Group Quarters = rowSums(county1990[, c(which(names(county1980)=="DXD001"):which(names(county1980)=="DXD007"))]),
# group_institutionalized = (DXD001+DXD001+DXD003+DXD004), 
#group_inst_other = DXD007,
# gqprison = DXD003,
# unemp_m = SE_T041_003,
# unemp_f = SE_T042_003,
# unemp_black = SE_T044_003,
# unemp_hisp = SE_T048_003,
# unemp_white = SE_T043_003,
# unemp_native = SE_T045_003,
# unemp = SE_T040_003, 
# Poverty Rate = (DI8002/pop)*100
# povt_m = NA, 
# povt_f = NA, 
# povt_black = (SE_T103_002/SE_T103_001)*100, 
# povt_white = (SE_T102_002/SE_T102_001)*100, 
# povt_hisp = (SE_T107_002/SE_T107_001)*100, 
# povt_native = (SE_T104_002/SE_T104_001)*100, 
# Child Poverty Rate = NA,
# pcol = ((DX4005 + DX4010 + DX4015 + DX4020 + DX4025 + DX4030)/rowSums(county1980[, c(which(names(county1980)=="DX4001"):which(names(county1980)=="DX4030"))]))*100
# phs = ((DX4003 + DX4008 + DX4013 + DX4018 + DX4023 + DX4028)/rowSums(county1980[, c(which(names(county1980)=="DX4001"):which(names(county1980)=="DX4030"))]))*100
# pnohs = (100-pcol-phs),
# Percent HH received Public Assistance Income = (DSN002/(DSN001+DSN002))*100,
# Percent female headed household = ((C7H002+C7H005+C7H007)/(rowSums(county1980[, c(which(names(county1980)=="C7H001"):which(names(county1980)=="C7H007"))]))),
# Median HH Income = SE_T053_001,
# Median Home Value = C8J001,
#age18-34 = (rowSums(county1980[, c(which(names(county1980)=="C67012"):which(names(county1980)=="C67018"))])/pop)*100,
#age35-64 = (rowSums(county1980[, c(which(names(county1980)=="C67019"):which(names(county1980)=="C67023"))])/pop)*100,
#age65p = (rowSums(county1980[, c(which(names(county1980)=="C67024"):which(names(county1980)=="C67026"))])/pop)*100,
# Percent homeowners = (C7W001/(C7W001 + C7W002))*100


