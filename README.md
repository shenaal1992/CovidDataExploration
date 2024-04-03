# COVID-19 Data Analysis SQL Queries

## Overview
These SQL queries are designed to analyze COVID-19 data, focusing on aspects such as vaccinations, cases, deaths, and population statistics. The queries are intended to provide insights into the spread of COVID-19 and the effectiveness of vaccination efforts.

## Queries Description

1. **Ordering Covid Vaccinations Data**
   - Two identical queries ordering the `covid_vaccinations` data by specific columns.

2. **Selecting Specific Columns from Covid Deaths Data**
   - Selects specific columns (`location`, `date`, `total_cases`, `new_cases`, `total_deaths`, `population`) from the `covid_deaths` table, ordered by location and date.

3. **Calculating Death Percentage for Sri Lanka**
   - Calculates the death percentage for Sri Lanka based on total cases and total deaths.
   
4. **Calculating Total Cases vs Population Percentage**
   - Computes the percentage of the population that contracted COVID-19 in Sri Lanka.

5. **Finding Countries with Highest Infection Rate**
   - Identifies countries with the highest infection rate compared to their population.

6. **Finding Countries with Highest Death Count**
   - Lists countries with the highest death count as a percentage of their population.

7. **Finding Continent with Highest Death Count**
   - Shows the continent with the highest death count as a percentage of its population.

8. **Global COVID-19 Numbers**
   - Presents global COVID-19 statistics including total cases, total deaths, and death percentage by date.

9. **Analyzing Total Population vs Vaccinations**
   - Analyzes the total population vs. vaccinations administered, including rolling vaccination counts.

10. **Using Common Table Expressions (CTEs)**
    - Utilizes Common Table Expressions to calculate population percentages vaccinated.

11. **Temporary Table Usage**
    - Demonstrates the use of temporary tables to compute population percentages vaccinated.

12. **Creating a View**
    - Creates a view to simplify querying population percentages vaccinated.

## Usage
These queries can be directly executed in a SQL environment connected to a database containing COVID-19 data. Ensure that the necessary tables (`covid_vaccinations` and `covid_deaths`) are present in the database and have appropriate data before executing the queries.
