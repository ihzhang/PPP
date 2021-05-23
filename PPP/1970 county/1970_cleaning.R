# PPP cleaning #################################
# created by: Iris Z. ##########################
# date: 3/4/2021 ###############################
# RE: rename variables based on codebook #######
# goal: human-readable variables; create #######
# standardized variables across years ##########
# according to PPP data needs ##################

setwd("1970 county")
files <- list.files(pattern="*.csv") # makes sure cleaned .csv is not in folder before running this
county1970 <- do.call(cbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))
county1970 <- county1970[, !duplicated(colnames(county1970))]

county1970 <- mutate(
  county1970, 
  pwhite = (SE_T012_002/SE_T012_001)*100,
  pblack = (SE_T012_003/SE_T012_001)*100,
  phisp = (SE_T013_002/SE_T013_001)*100,
  pfb = (SE_T132_003/SE_T132_001)*100,
  pnative = NA,
  pop = SE_T001_001,
  popden = SE_T002_001,
  popingq = SE_T020_001,
  group_institutionalized = SE_T020_002, 
  group_inst_other = SE_T020_005,
  unemp_m = (SE_T057_003/SE_T057_001)*100,
  unemp_f = (SE_T058_003/SE_T058_001)*100,
  unemp_black = (SE_T060_003/SE_T060_001)*100,
  unemp_hisp = (SE_T062_003/SE_T062_001)*100,
  unemp_white = (SE_T059_003/SE_T059_001)*100,
  unemp_native = NA,
  unemp = (SE_T056_003/SE_T056_001)*100,
  ppov = (SE_T080_003/SE_T080_001)*100,
  povt_m = NA,
  povt_f = NA,
  povt_black = (SEORG_PB089_005/SEORG_PB089_001)*100,
  povt_white = (SEORG_PW089_005/SEORG_PW089_001)*100,
  povt_hisp = (SEORG_PH089_005/SEORG_PH089_001)*100,
  povt_native = NA,
  ppovchild = (SE_T099_003/SE_T099_001)*100,
  pcol = ((SE_T022_013 + SE_T022_014)/SE_T022_001)*100,
  phs = (SE_T022_010/SE_T022_001)*100,
  pnohs = (100-pcol-phs),
  ppubassist = (SE_T080_006/SE_T080_001)*100,
  pfhh = (SEORG_PT019_012/SEORG_PT019_001)*100,
  mhinc = SE_T085_001, # avg for 1970
  mhmval = SE_T122_002,
  age18to34 = ((SE_T007_006 + SE_T007_007)/SE_T007_001)*100,
  age35to64 = ((SE_T007_008 + SE_T007_009 + SE_T007_010)/SE_T007_001)*100,
  age65p = ((SE_T007_011 + SE_T007_012)/SE_T007_001)*100,
  pown = (SE_T108_002/SE_T108_001)*100,
  year = 1970
)

county1970 <- 
  select(county1970,
         c(1:8, pwhite:year)
  )

write_csv(county1970, "county1970_cleaned.csv")

# for posterity: here is a log of how variable decisions were made ####
# Percent White = (SE_T012_002/SE_T012_001)*100,
# Percent Black = (SE_T012_003/SE_T012_00)*100,
# Percent Hispanic/Latino = (SE_T013_002/SE_T013_001)*100,
# Percent Foreign-born = (SE_T132_003/SE_T132_001)*100,
# Percent Native American = NA,
# SE_Total Population = SE_T001_001,
# Population Density OR Land Area = SE_T002_001,
# Group Quarters = SE_T020_001
# group_institutionalized = SE_T020_002, 
#group_inst_other = SE_T020_005,
# unemp_m = (SE_T057_003/SE_T057_001)*100,
# unemp_f = (SE_T058_003/SE_T058_001)*100,
# unemp_black = (SE_T060_003/SE_T060_001)*100,
# unemp_hisp = (SE_T062_003/SE_T062_001)*100,
# unemp_white = (SE_T059_003/SE_T059_001)*100,
# unemp_native = NA,
# unemp = SE_T056_002, 
# Poverty Rate = (SE_T080_003/SE_T080_001)*100
# povt_m = NA, 
# povt_f = NA, 
# povt_black = (SE_PB089_005/SE_PB089_001)*100, 
# povt_white = (SE_PW089_005/SE_PW089_001)*100, 
# povt_hisp = (SE_PH089_005/SE_PH089_001)*100, 
# povt_native = NA, 
# Child Poverty Rate = (SE_T099_003/SE_T099_001)*100,
# pcol = ((SE_T022_013 + SE_T022_014)/SE_T022_001)*100
# phs = (SE_T022_010/SE_T022_001)*100
# pnohs = (100-pcol-phs),
# Percent HH received Public Assistance Income = (SE_T080_006/SE_T080_001)*100,
# Percent female headed household = (SE_PT019_012)/SE_PT019_001)*100,
# Median HH Income = SE_T085_001,
# Median Home Value = SE_T122_002,
#age18-34 = ((SE_T007_006 + SE_T007_007)/SE_T007_001)*100,
#age35-64 = ((SE_T007_008 + SE_T007_009 + SE_T007_010)/SE_T007_001)*100,
#age65p = ((SE_T007_011 + SE_T007_012)/SE_T007_001)*100,
# Percent homeowners = (SE_T108_002/SE_T108_001)*100


