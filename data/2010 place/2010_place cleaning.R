acs <- read_csv("2010 place/acs1014.csv")
gq <- read_csv("2010 place/gqtype.csv")

names(acs)[1:55]
names(gq)

gq <- gq %>% 
  select(Geo_FIPS, SE_T067_001:SE_T067_011)

acs <- acs %>%
  left_join(gq, by = "Geo_FIPS")
rm(gq)

acs <- acs %>%
  mutate(pop = SE_A00001_001,
         popdensity = SE_A00002_002,
         pwhite = PCT_SE_A04001_003,
         pblack = PCT_SE_A04001_004,
         pnative = PCT_SE_A04001_005,
         phisp = PCT_SE_A04001_010,
         pfemhh = PCT_SE_A10008_006 + PCT_SE_A10008_009,
         pnohs = PCT_SE_A12002_002,
         pcol = PCT_SE_A04001_005+PCT_SE_A04001_006+PCT_SE_A04001_007+PCT_SE_A04001_008,
         unemp = PCT_SE_A17002_006,
         unemp_m = PCT_SE_A17002A_006,
         unemp_f = PCT_SE_A17002B_006,
         unemp_black = PCT_SE_A17006B_003,
         unemp_native = PCT_SE_A17006C_003,
         unemp_hisp = PCT_SE_A17006H_003,
         unemp_white = PCT_SE_A17006I_003,
         mhinc = SE_A14006_001,
         ppubassist = PCT_SE_A10014_002,
         pown = PCT_SE_A10060_002,
         ppov = PCT_SE_A13002_002,
         ppovchild = PCT_SE_A13003A_002,
         povt_white = PCT_SE_A13001I_002,
         povt_black = PCT_SE_A13001B_002,
         povt_native = PCT_SE_A13001C_002,
         povt_hisp = PCT_SE_A13001H_002,
         pfb = PCT_SE_A06001_003,
         popingq = SE_T067_002,
         group_institutionalized = SE_T067_003,
         group_inst_other = SE_T067_006,
         gqinprison = SE_T067_004
         )

acs <- acs %>% 
  select(-c(starts_with("PCT_SE_") | starts_with("SE_")))

acs <- acs %>% 
  rename(place_fips = Geo_FIPS,
         state = Geo_STATE,
         place_name = Geo_NAME) %>%
  select(-starts_with("Geo_"))

write.csv(acs, "2010 place/2010 place data.csv", row.names = F, na = "")
