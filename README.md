# Google_Bike_Share
Google Capstone Project - Bike share company | Excel | SQL | Tableau


## Introduction
The marketing analyst team at Cyclistic, a bike-share company in Chicago wants to design a new marketing strategy to convert casual riders into annual members. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, the team wants to understand how casual riders and annual members use Cyclistic bikes differently.
The raw dataset can be found here: https://divvy-tripdata.s3.amazonaws.com/index.html

## Key Questions
1.	How do casual and annual members differ in bike usage behavior? 
2.	Are there specific stations/routes popular among one group?
3.	What factors might motivate casual riders to become annual members?
 
## Prepare Data
The company’s last 12 months of bike ride data was used for analysis. No data integrity issues were present. The dataset contains the following 13 columns.
-	ride_id: Unique identifier for each ride.
-	rideable_type: Type of bike used (e.g., "classic_bike").
-	started_at and ended_at: Timestamps for the start and end of each ride.
-	start_station_name/id and end_station_name/id: Names and IDs of start and end stations.
-	start_lat/start_lng and end_lat/end_lng: Location coordinates of start and end locations.
-	member_casual: Rider type ("member" or "casual").

## Process Data
The dataset was too large for a spreadsheet to handle. Over 5 million records were present in 12 separate files for each month. Initial data cleaning was done in Excel Each dataset was then loaded in SQL database and was combined using UNION to a single table.
1. Removed station IDs (Not relevant for analysis)
2. Fixed date format
3. No duplicate was present
4. Added the metrics ride length, time of the day, day of the week, month and season
5. Removed incorrect data (end time preceded start time)
6.	Removed records with errors in ride length. And records that were less than a minute.
 
## Analyze Data
The analysis focused on comparing ride patterns between casual and annual members. Trends and patterns were identified to understand the behavior and preferences of casual riders

