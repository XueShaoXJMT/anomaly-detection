# Anomaly detection model based on satelite remote sensing data
The goal of this project is to design an anomaly detection model to do effective detection on local disaster based on satellite remote sensing images. 
Firstly, the input images will be converted into time series based on the time they were taken. Then the seanson-trend model is used to decompose it. After that, the values with large flactuation on the remaining residual will be chosen as anomalies, marked at its correponding position and time on the images.

The 2 .zip file is the souce image of the project.
