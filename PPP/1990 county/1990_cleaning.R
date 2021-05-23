# PPP cleaning #################################
# created by: Iris Z. ##########################
# date: 3/4/2021 ###############################
# RE: rename variables based on codebook #######
# goal: human-readable variables; create #######
# standardized variables across years ##########
# according to PPP data needs ##################

setwd("../1990 county")
county1990 <- read_csv("R12776090_SL050.csv")

county1990 <- mutate(
  county1990, 
  pop = SE_T001_001,
  pwhite = PCT_SE_T013_003,
  pblack = PCT_SE_T013_004,
  phisp = PCT_SE_T013_008,
  pfb = PCT_SE_T110_003,
  pnative = PCT_SE_T013_006,
  popdensiity = SE_T002_001,
  popingq = STF1_P028_001,
  group_institutionalized = STF1_P028_002,
  group_inst_other = STF1_P028_007,
  gqprison = STF1_P028_003,
  unemp_m = PCT_SE_T030_003,
  unemp_f = PCT_SE_T031_003,
  unemp_black = PCT_SE_T033_003,
  unemp_hisp = PCT_SE_T037_003,
  unemp_white = PCT_SE_T032_003,
  unemp_native = PCT_SE_T034_003,
  unemp = PCT_SE_T029_003,
  ppov = PCT_SE_T099_008,
  povt_m = NA,
  povt_f = NA,
  povt_black = PCT_SE_T101_003,
  povt_white = PCT_SE_T100_003,
  povt_hisp = PCT_SE_T105_003,
  povt_native = PCT_SE_T102_003,
  ppovchld = PCT_SE_T094_003,
  pcol = PCT_SE_T117_005,
  phs = PCT_SE_T117_003,
  pnohs = PCT_SE_T117_002,
  ppubassist = PCT_SE_T062_002,
  pfemhh = PCT_SE_T016_006 + PCT_SE_T016_009,
  mhinc = SE_T043_001,
  mhmval = STF1_H023B_001,
  age18to34 = PCT_SE_T009_003,
  age35to64 = PCT_SE_T009_004,
  age65p = PCT_SE_T009_005,
  pown = PCT_SE_T073_002,
  year = 1990
)

county1990 <- 
  select(county1990,
         c(1:9, pop:year)
  )

write_csv(county1990, "county1990_cleaned.csv")

# for posterity: here is a log of how variable decisions were made ####
# pop = SE_T001_001
# pwhite = PCT_SE_T013_003,
# pblack = PCT_SE_T013_004,
# phisp = PCT_SE_T013_008,
# pfb = PCT_SE_T110_003,
# pnative = PCT_SE_T013_006,
# popdensiity = SE_T002_001,
# popingq = STF1_P028_001,
# group_institutionalized = STF1_P028_002,
# group_inst_other = STF1_P028_007,
# gqprison = STF1_P028_003,
# unemp_m = PCT_SE_T030_003,
# unemp_f = PCT_SE_T031_003,
# unemp_black = PCT_SE_T033_003,
# unemp_hisp = PCT_SE_T037_003,
# unemp_white = PCT_SE_T032_003,
# unemp_native = PCT_SE_T034_003,
# unemp = PCT_SE_T029_003,
# ppov = PCT_SE_T099_008,
# povt_m = NA,
# povt_f = NA,
# povt_black = PCT_SE_T101_003,
# povt_white = PCT_SE_T100_003,
# povt_hisp = PCT_SE_T105_003,
# povt_native = PCT_SE_T102_003,
# ppovchld = PCT_SE_T094_003,
# pcol = PCT_SE_T117_005,
# phs = PCT_SE_T117_003,
# pnohs = PCT_SE_T117_002,
# ppubassist = PCT_SE_T062_002,
# pfemhh = PCT_SE_T016_006 + PCT_SE_T016_009,
# mhinc = SE_T043_001,
# mhmval = SE_H023B_001,
# age18to34 = PCT_SE_T009_003,
# age35to64 = PCT_SE_T009_004,
# age65p = PCT_SE_T009_005,
# pown = PCT_SE_T073_002,
# year = 1990

