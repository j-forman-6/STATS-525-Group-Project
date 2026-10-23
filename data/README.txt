


Descriptions for variable names presented in all datasets. 
	

	

DATA SET ?daily temp.2021.csv? Contains daily average, maximum, and minimum forage canopy temperature in all plots, including treatments: Control (no open top chamber [OTC]), Constant Warming (with OTC), and Fluctuating Warming (with OTC and periodic removal). Variable nameDescriptionplotNumber descriptor for plot, main experimental unit. repRep # for each block in randomized complete block design. trtno# for Treatments (1=Control, 2=Constant Warming, and 3=Fluctuating Warming)TemptrtTemperature manipulation treatment applied to each plot: Control, Constant Warming, and Fluctuating WarmingWeedsSplit plot distinction of whether it was weedy (with chickweed) or not.DateCalendar date over which daily average, minimum, and maximum temperature was integrated over. dly.avgThe average of each hourly temperature logged with hobo sensors, in Celsius.dly.minThe minimum of each hourly temperature logged with hobo sensors, in Celsius.dly.maxThe maximum of each hourly temperature logged with hobo sensors, in Celsius.monthMonth data was collected in. 




DATA SET ?daily temp.2022.csv? Contains daily average, maximum, and minimum forage canopy temperature in all plots, including treatments: Control (no OTC), Constant Warming (with OTC), and Fluctuating Warming (with OTC and periodic removal). Variable nameDescriptionplotNumber descriptor for plot, main experimental unit. repRep # for each block in randomized complete block design. trtno# for Treatments (1=Control, 2=Constant Warming, and 3=Fluctuating Warming)TrtTemperature manipulation treatment and weed treatments applied to each plot:
?no weeds constant warming?: no chickweed, with OTC
?weeds constant warming? : with chickweed, with OTC
?no weeds control? : no chickweed, without OTC
?weeds control? : with chickweed, without OTC
?weeds fluctuating warming?: with chickweed, with OTC with periodic removalsDateCalendar date over which daily average, minimum, and maximum temperature was integrated over. dly.avgThe average of each hourly temperature logged with hobo sensors, in Celsius.dly.minThe minimum of each hourly temperature logged with hobo sensors, in Celsius.dly.maxThe maximum of each hourly temperature logged with hobo sensors, in Celsius.monthMonth data was collected in. 



Three R scripts are associated with the data files ?daily temp.2021.csv? and ?daily temp.2022.csv? : 

1) Isaacson forage paper temperature analysis.R
Analysis of temperature difference between plots with and without OTCs to determine the OTC effect on temperature. 

2) Canopy GDD.R
Calculating Growing Degree Days in plots with and without an OTC. 

3) WWwinter temps diff between warm and control.R
Calculating the monthly difference in temperature in plots with and without and OTC. 


		


DATA SET ?Isaacson_Year 1 Forage Yield.csv? Contains dry weight biomass of forages (alfalfa and orchardgrass) as well as weeds including (chickweed, wheat, and all other weeds) at each of harvest timepoints in Year 1. Variable nameDescriptionPlotNumber descriptor for plot, main experimental unit. SplitSplit plot distinction (either north or south) over which one randomly had chickweed spiked and one did not. Block	Rep # for each block in randomized complete block design. Trtno# for Treatments (1=Control, 2=Constant Warming, and 3=Fluctuating Warming)DateCalendar date when biomass data was collected Weedy	Split plot distinction of whether it was weedy (with chickweed) or not. alfalfa.gAlfalfa dry weight biomass in grams per 0.5m2.ograss.gOrchardgrass dry weight biomass in grams per 0.5m2.wheat.gWheat dry weight biomass in grams per 0.5m2.chick.gChickweed dry weight biomass in grams per 0.5m2.other.gAll other weeds dry weight biomass in grams per 0.5m2.


DATA SET ?Isaacson_Year 2 Forage Yield.csv? Contains dry weight biomass of forages (alfalfa and orchardgrass) as well as weeds including (chickweed, wheat, and all other weeds) at each of harvest timepoints in Year 2.Variable nameDescriptionPlotNumber descriptor for plot, main experimental unit. Block	Rep # for each block in randomized complete block design. Trtno# for Treatments (1=Control, 2=Constant Warming, and 3=Fluctuating Warming)TrtTemperature manipulation treatment and weed treatments applied to each plot:
Control-weeds: No OTC, no added chickweed
Constant-weeds: With an OTC, no added chickweed
Control+weeds: No OTC, with added chickweed
Constant+weeds: With an OTC, with added chickweed
Fluctuating+weeds: With an OTC (with periodic removal), with added chickweedDateCalendar date when biomass data was collected Weedy	Plot distinction of whether it was weedy (with chickweed) or not. alfalfa.gAlfalfa dry weight biomass in grams per 0.5m2.ograss.gOrchardgrass dry weight biomass in grams per 0.5m2.chick.gChickweed dry weight biomass in grams per 0.5m2.other.gAll other weeds dry weight biomass in grams per 0.5m2.


1 R scripts associated with ?Isaacson_Year 1 Forage Yield.csv? and ?Isaacson_Year 2 Forage Yield.csv?
1. Isaacson_Years 1and2  Forage Yield.R
Analysis of forage dry matter yield and weed biomass in OTC treatments.



DATA SET ?Alfalfa winterinjury_compiled_all trts.csv? Contains winter injury rating for alfalfa plants in both years 1 and 2.Variable nameDescriptionPlotNumber descriptor for plot, main experimental unit. RepRep # for each block in randomized complete block design. YearYear the data was collected, either 2021 or 2022.PlantID number for individual plants within each plotTreatmentTreatments including Control (no OTC), Constant Warming (with OTC), and Fluctuating Warming(with OTC but with periodic removal)DateCalendar date when biomass data was collected Weedy	Split plot distinction of whether it was weedy (with chickweed) or not. RatingWinter injury rating where 0=the plant is completely brown and dead,  and 5=No signs of injury. Data is calculated based on 0.5 increments and than converted to a 0 to 1 scale in the associated R script. 

R script associated with ?Alfalfa winterinjury_compiled_all trts.csv?
1. Alflalfa winter injury GLMM.R
Calculated the difference in winter injury rating of alfalfa plants in the Control, Constant Warming, and Fluctuating Warming treatments. 


DATA SET ?Chick.injury.compiled.csv? Contains winter injury rating for chickweed plants in both years 1 and 2.Variable nameDescriptionPlotNumber descriptor for plot, main experimental unit. BlockRep # for each block in randomized complete block design. YearYear the data was collected, either 2021 or 2022. PlantID number for individual plants within each plotTreatmentTreatments including Control (no OTC), Constant Warming (with OTC), and Fluctuating Warming(with OTC but with periodic removal)RatingWinter injury rating where 0=the plant is completely brown and dead,  and 5=No signs of injury. Data is calculated based on 0.5 increments and than converted to a 0 to 1 scale in the associated R script. 


R script associated with ?Chick.injury.compiled.csv?
1. Chick.injury_compiled-cl.R
Calculated the difference in winter injury rating of chickweed plants in the Control, Constant Warming, and Fluctuating Warming treatments. 

DATA SETS ?2036_18_YEAR=2020.csv? 2036_18_YEAR=2021?, and ?2036_18_YEAR=2022??Contains daily precipitation data for our site over the course of our study.Variable nameDescriptionDateCalendar date over which precipitation total was measuredPrecip.inTotal amount of precipitation over a 24 hour period (per day) in inches.  
R scripts associated with data files ?2036_18_YEAR=2020.csv? 2036_18_YEAR=2021?, and ?2036_18_YEAR=2022?
1. ambient precip figures.R 
File to summarize and create figure for precipitation received at experimental site over duration study. 



DATA SETS ?2036_18_YEAR=2020.csv? , ?2036_18_YEAR=2021.csv?, ?2036_18_YEAR=2022.csv?Contains daily maximum, minimum, and average air temperature data for our site over the course of our study.Variable nameDescriptionDateCalendar date over which precipitation total was measuredTmaxCMaximum daily temperature in Celsius. TminCMinimum daily temperature in Celsius.TavgCAverage daily temperature in Celsius.

R scripts associated with data files ?2036_18_YEAR=2020.csv? , ?2036_18_YEAR=2021.csv?, ?2036_18_YEAR=2022.csv?
1. ambient temp.R
File to summarize and create figure for air temperature at experimental site over study duration. 



Data sets associated with ?Effect of increasing temperature and temperature fluctuations on alfalfa and orchardgrass in the establishment year.?


