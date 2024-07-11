![Netflix-ELT-Digram](https://github.com/yv12/Netflix-Data---ELT-Analysis/assets/87942632/b1f05fa3-090c-40d7-b940-49c55938332e)

Project Overview:-
Title: "Netflix Content Strategy Analysis Using SQL"
Introduction
-----------------------------------------------------------------------------------------------------------
This project undertakes a thorough analysis of Netflix data to uncover viewer behaviors, content trends, and strategic insights aimed at optimizing content strategies and enhancing user experience on the platform.

Objectives
-----------------------------------------------------------------------------------------------------------
Improve Data Quality: Through cleaning and normalization.
Analyze Genre Preferences and Director Contributions: To understand content trends.
Provide Actionable Insights: For strategic decision-making at Netflix.
Scope
The project encompasses comprehensive data collection, cleaning, preparation, storage, and in-depth analysis using SQL queries. It addresses key business questions related to content production, audience engagement, and operational efficiency.

Data Collection and Loading
-----------------------------------------------------------------------------------------------------------
Data Sources
-----------------------------------------------------------------------------------------------------------
The analysis utilizes a robust Netflix dataset containing detailed information about movies, TV shows, directors, genres, countries, duration, and ratings.

Data Loading Process
-----------------------------------------------------------------------------------------------------------
Data was initially imported into Python for preprocessing and subsequently transferred to SQL Server for storage and detailed analysis.

Data Cleaning and Preparation
-----------------------------------------------------------------------------------------------------------

Handling Foreign Characters
-----------------------------------------------------------------------------------------------------------
Modified the data type of the "Title" column to 'nvarchar' to accommodate foreign characters.

Removing Duplicates
-----------------------------------------------------------------------------------------------------------
Implemented procedures to eliminate duplicate entries, ensuring enhanced data integrity.

Data Type Conversions
-----------------------------------------------------------------------------------------------------------
Converted the "Date Added" column from varchar to date for consistent date handling.

Populating Missing Values
-----------------------------------------------------------------------------------------------------------
Utilized the director column to populate missing values in the "Country" column.
Corrected misattributed values in the "Duration" column using a CASE statement.

Creating Separate Tables for Multi-Value Columns
-----------------------------------------------------------------------------------------------------------
Established separate tables for multi-value attributes such as "Listed In," "Director," "Country," and "Cast" to optimize data organization and querying efficiency.

Data Storage and Management
-----------------------------------------------------------------------------------------------------------
Raw Data Layer
-----------------------------------------------------------------------------------------------------------
Stored initial data imports for preservation and future reference.

Final Staging Layer
-----------------------------------------------------------------------------------------------------------
Maintained cleaned and transformed data, prepared for detailed analysis and reporting.

Data Analysis Using SQL
-----------------------------------------------------------------------------------------------------------
Director Analysis
-----------------------------------------------------------------------------------------------------------
Count of Movies and TV Shows by Director: Identified Rajiv Chilaka as the director with the highest number of movies released in 2021 and Jan Suter with the highest in 2018.
Directors Creating Both Horror and Comedy Movies: Identified 55 directors who have created both horror and comedy movies, with notable contributions from Poj Arnon and Kevin Smith.

Genre and Country Insights
-----------------------------------------------------------------------------------------------------------
Country with the Highest Number of Comedy Movies: Determined that the United States leads with 685 comedy movies.
Average Duration of Movies by Genre: Found that classic movies have the longest average duration (118 minutes), while movies have the shortest average duration (45 minutes).

Yearly Release Analysis
-----------------------------------------------------------------------------------------------------------
Analyzed yearly releases to identify trends in directorial output, supporting strategic planning and content scheduling decisions.

Insights and Results
-----------------------------------------------------------------------------------------------------------
Key Findings
-----------------------------------------------------------------------------------------------------------
Content Preferences: Highlighted the popularity of comedy movies in the United States.
Directorial Excellence: Recognized prolific directors and their impact on Netflix’s content diversity and viewer engagement.
Genre Analysis: Provided insights into viewer preferences based on genre and average duration.

Business Implications
-----------------------------------------------------------------------------------------------------------
Strategic Content Acquisition: Recommends focusing on acquiring comedy content from the United States.
Director Partnerships: Suggests collaborating with directors like Rajiv Chilaka and Jan Suter.
Optimized Content Length: Proposes balancing the catalog with varying movie durations to cater to diverse viewer preferences.



