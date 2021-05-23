# PPP cleaning #################################
# created by: Iris Z. ##########################
# date: 3/4/2021 ###############################
# RE: rename variables based on codebook #######
# goal: human-readable variables; create #######
# standardized variables across years ##########
# according to PPP data needs ##################
rm(list = ls())
county2000 <- read_csv("2000 county/R12776476_SL050.csv")

county2000 <- mutate(
  county2000, 
  pop = SE_T001_001,
  pwhite = PCT_SE_T015_003,
  pblack = PCT_SE_T015_004,
  phisp = PCT_SE_T015_010,
  pfb = PCT_SE_T201_003,
  pnative = PCT_SE_T015_005,
  popdensity = SE_T003_001,
  popingq = SE_T039_002,
  group_institutionalized = SE_T039_003,
  group_inst_other = SE_T039_006,
  gqprison = SE_T039_004,
  unemp_m = PCT_SE_T074_003,
  unemp_f = PCT_SE_T075_003,
  unemp_black = PCT_SE_T077_003,
  unemp_hisp = PCT_SE_T083_003,
  unemp_white = PCT_SE_T076_003,
  unemp_native = PCT_SE_T078_003,
  unemp = PCT_SE_T073_003,
  ppov = ((SE_T183_002 + SE_T183_005)/(SE_T183_001 + SE_T183_004))*100,
  povt_m = PCT_SE_T183_002,
  povt_f = PCT_SE_T183_005,
  povt_black = PCT_SE_T187_002,
  povt_white = PCT_SE_T186_002,
  povt_hisp = PCT_SE_T193_002,
  povt_native = PCT_SE_T190_002,
  ppovchld = PCT_SE_T180_002,
  pcol = PCT_SE_T043_005,
  phs = PCT_SE_T043_003,
  pnohs = PCT_SE_T043_002,
  ppubassist = PCT_SF3_P064002,
  pfemhh = PCT_SE_T020_006 + PCT_SE_T020_009,
  mhinc = SE_T093_001,
  mhmval = SE_T163_001,
  age18to34 = PCT_SE_T009_003,
  age35to64 = PCT_SE_T009_004,
  age65p = PCT_SE_T009_005,
  pown = PCT_SE_T156_002,
  year = 2000
)

county2000 <- 
  select(county2000,
         c(1:11, pop:year)
  )

write_csv(county2000, "county2000_cleaned.csv")
