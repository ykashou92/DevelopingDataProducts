Developing Data Products Course Project - Earthquake App
========================================================
author: Yanal Kashou
date: 28/8/2016
autosize: true

Overview
========================================================
This shiny web application was created to fulfill the project requirements for the Developing Data Products MOOC offered on Coursera by John's Hopkins University as part of their Data Science Specialization.

We needed to create a web application using the shiny framework and have it deployed. 

In the project outline, we were told the app is totally up to us, and hence I decided to use the USGS Earthquake Feed as my source.

You can manually download the dataset from their website for free at:
<http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv> 

The dataset is automatically updated every 15 minutes and hence you will find the most recent earthquakes on the news in this dataset.


The Dataset
========================================================


```r
#An Example of how the dataset looks after subsetting
eq <- read.csv("all_month.csv", header = TRUE, sep = ",")
eq$loc <- paste(eq$latitude, eq$longitude, sep = ":")
eq.subset <- eq[ -c(11:13 ,15:22) ]
str(eq.subset)
```

```
'data.frame':	8563 obs. of  12 variables:
 $ time     : Factor w/ 8556 levels "2016-08-01T13:03:57.000Z",..: 8556 8555 8554 8553 8552 8551 8550 8549 8548 8547 ...
 $ latitude : num  59.8 61.3 34.3 33.5 38.8 ...
 $ longitude: num  -152 -151 -117 -117 -123 ...
 $ depth    : num  60 33.6 8.88 7.46 0.98 7.37 15.2 2.02 2.4 9.79 ...
 $ mag      : num  1.4 1.6 1.46 0.04 1.05 1.42 1 1.41 1.22 1.06 ...
 $ magType  : Factor w/ 16 levels "","mb","Mb","mb_lg",..: 8 8 8 8 5 8 8 8 8 8 ...
 $ nst      : int  24 21 9 13 9 23 7 14 14 23 ...
 $ gap      : num  68.4 50.4 300 140 129 ...
 $ dmin     : num  0.2542 0.4905 0.2017 0.0255 0.0132 ...
 $ rms      : num  0.55 0.65 0.17 0.15 0.03 0.17 0.24 0.12 0.1 0.21 ...
 $ place    : Factor w/ 5038 levels "0km E of Manley Hot Springs, Alaska",..: 946 2746 3474 212 3498 1831 3640 4296 4324 1453 ...
 $ loc      : chr  "59.7609:-152.1138" "61.3012:-150.658" "34.258:-116.7943333" "33.4665:-116.6606667" ...
```

The Application
========================================================

The application uses the `shinydashboard` package for it's layout.  
The sidebar has 3 main menu items, Documentation, Widgets and Source Code.  
Documentation provides an idea of what the app is all about and Source Code links to the source files. While the Widgets menu has 3 menu sub-items:  
* __Map Controller__  
A very fluid earthquake display map with Magnitude and Observation Sliders  
* __Table Explorer__  
A drop down menu of tables to display, 3 static, and 1 dynamic.  
* __Chart Plotter__  
A frequency histogram plot of earthquake count and magnitude with a reactive slider input for the number of bins to display.  



Source Code
========================================================
This presentation was made using RStudio Presenter and is Published on __RPubs__ with the following URL:  
<http://rpubs.com/ykashou92/earthquake-app-presentation>

The app was deployed on __shinyapp.io__ and the URL is:  
<http://ykashou92.shinyapps.io/earthquake-app>
  
Finally the link to the __GitHub__ repository is:  
<https://github.com/ykashou92/DevelopingDataProducts>

