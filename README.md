# MTL_aquaculture

This is the repository for Cottrell et al "Time to rethink trophics levels in aquaculture policy" in Reviews in Aquaculture https://doi.org/10.1111/raq.12535. 

**Current code errors**

Due to problems with accessing "sealifebase" in rfishbase (see issue https://github.com/ropensci/rfishbase/issues/244 ) the code for the comparisons between farmed and wild species of the same taxon does not currently run (working on a solution).

However - trophic level calculations for aquaculture taxa are available and reproducible for:
- The entire fed sector ("data/outputs/sector_trophic_levels_sensitivity.csv"") - filter by "All variables" (see Figure 1 in paper)
- Individual taxa ("data/outputs/taxon_TLs.csv")

| Scripts | Description                               |
|---------|-------------------------------------------|
|1_calcTL.R | Query fishbase for trophic levels of forage fish |
|2_MTL_analayses.Rmd | Calculate effective trophic levels for aggregate fed aquaculture and by taxon|



