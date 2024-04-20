Updating ECB Monetary Policy and Central Bank Information shocks originally constructed in:
Jarocinski, M. and Karadi, P. (2020) Deconstructing  Monetary Policy Surprises - The Role of Information Shocks, AEJ:Macro, DOI: 10.1257/mac.20180090

Updated shocks:
shocks/shocks_ecb_mpd_me_d.csv - Monetary Policy and Central Bank Information shocks, by Governing Council meeting, indexed by date
shocks/shocks_ecb_mpd_me_m.csv - Monetary Policy and Central Bank Information shocks, aggregated to monthly frequency (zero if no shocks in a given month)

Construction of the shocks:
shocks/main.m - Matlab script (calls other Matlab functions)

Source data: 
Dataset_EA-MPD.xlsx - financial variables "surprises" around ECB Governing Council announcements from 1999 to 2023, created by Altavilla,, Brugnolini, Gürkaynak, Motto, Ragusa (2019) Measuring euro area monetary policy,
Journal of Monetary Economics, https://doi.org/10.1016/j.jmoneco.2019.08.016.

To replicate the computation of the shocks download Dataset_EA-MPD.xlsx from
https://www.ecb.europa.eu/pub/pdf/annex/Dataset_EA-MPD.xlsx and place it in source_data/

---

Definitions of the variables in shocks_ecb_mpd_me_d.csv and shocks_ecb_mpd_me_m.csv:

pc1 - surprise in the "policy indicator", ie the 1st principal component of the Monetary Event-window changes in overnight index swaps (OIS) with maturities 1-, 3-, 6-months and 1-year (Identifiers: OIS1M, OIS3M, OIS6M, OIS1Y)

STOXX50 - Monetary Event-window changes in the Euro Stoxx 50

MP_pm,CBI_pm - Monetary Policy and Central Bank Information shocks obtained with simple ("Poor Man's") sign restrictions.

MP_median,CBI_median - Monetary Policy and Central Bank Information shocks obtained with the median rotation that implements the sign restrictions.

The variables satisfy

MP_pm + CBI_pm = pc1
-> this is a much more restrictive decomposition assuming that only one of the shocks is present in each monetary policy announcement

MP_median + CBI_median = pc1
-> this is the more general decomposition that allows both shocks to be present in each monetary policy announcement


Construction of the shocks:

For the definition of Monetary Policy and Central Bank Information shocks and the motivation behind the sign restrictions see:
Jarocinski, M. and Karadi, P. (2020) Deconstructing  Monetary Policy Surprises - The Role of Information Shocks, AEJ:Macro, DOI: 10.1257/mac.20180090


Marek Jarocinski marek.jarocinski@ecb.europa.eu
Peter Karadi peter.karadi@ecb.europa.eu
