SELECT * 
FROM CovidDataExploration.dbo.covid_vaccinations
ORDER BY 3,4

SELECT * 
FROM CovidDataExploration.dbo.covid_vaccinations
ORDER BY 3,4

-- Select the data that using

SELECT location,date, total_cases, new_cases,total_deaths, population
FROM CovidDataExploration.dbo.covid_deaths
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
SELECT 
	location,
	date,	
	total_cases ,
	total_deaths, 
	(CAST(total_deaths AS FLOAT)/CAST(total_cases AS FLOAT))*100 AS Death_percentage
FROM CovidDataExploration.dbo.covid_deaths
WHERE location LIKE '%Sri Lanka%'
ORDER BY 2

-- Looking for Total Cases vs Population
-- Shows what percentage of population got covid

SELECT 
	location,
	date,
	population,
	total_cases , 
	(CAST(total_cases AS FLOAT)/CAST(population AS FLOAT))*100 AS Cases_Percentage
FROM CovidDataExploration.dbo.covid_deaths
WHERE location LIKE '%Sri Lanka%'
ORDER BY 2

-- Lookig at countries with Highest Infection Rate compared to Population
SELECT
	location,
	population,
	MAX(CAST(total_cases AS FLOAT)) AS HighestInfectionCount,
	MAX(CAST(total_cases AS FLOAT)/CAST(population AS FLOAT))*100 AS InfectionPercentage
FROM CovidDataExploration.dbo.covid_deaths
GROUP BY location,population
ORDER BY InfectionPercentage DESC

-- Showing Countries with Highest Deat Count
SELECT
	location,
	population,
	MAX(CAST(total_deaths AS FLOAT)) AS HighestDeathCount,
	MAX(CAST(total_deaths AS FLOAT)/CAST(population AS FLOAT))*100 AS DeathPercentage
FROM CovidDataExploration.dbo.covid_deaths
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY DeathPercentage DESC

-- Showing Continent with Highest Deat Count
SELECT
	location,
	population,
	MAX(CAST(total_deaths AS FLOAT)) AS HighestDeathCount,
	MAX(CAST(total_deaths AS FLOAT)/CAST(population AS FLOAT))*100 AS DeathPercentage
FROM CovidDataExploration.dbo.covid_deaths
WHERE continent IS NULL
GROUP BY location,population
ORDER BY HighestDeathCount DESC

-- Global Numbers
SELECT
	date,
	SUM(CAST(new_cases AS FLOAT)) AS Total_cases_by_date,
	SUM(CAST(new_deaths AS FLOAT)) AS Total_deaths_by_date,
	(SUM(CAST(new_deaths AS FLOAT))/SUM(CAST(new_cases AS FLOAT)))*100 AS Death_percentage_by_date
FROM CovidDataExploration.dbo.covid_deaths
WHERE continent IS NOT NULL 
GROUP BY date
HAVING SUM(CAST(new_cases AS FLOAT))>SUM(CAST(new_deaths AS FLOAT))
-- Otherwise it will give zero devision Error
ORDER BY 1,2

-- Looking at Total Population vs Vaccinations

SELECT	dea.continent, 
		dea.location, 
		dea.date,
		dea.population,
		vac.new_vaccinations,
		SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) 
		AS Rolling_vaccinate_count
FROM	covid_deaths AS dea
JOIN	covid_vaccinations AS vac
		ON	dea.location = vac.location
			AND dea.date = vac.date
WHERE	dea.continent IS NOT NULL
ORDER BY	2,3

-- Using CTE
WITH Pop_vs_Vac(continent, 
				location, 
				date,
				population,
				new_vaccinations,
				Rolling_vaccinate_count)
AS 
(SELECT	dea.continent, 
		dea.location, 
		dea.date,
		dea.population,
		vac.new_vaccinations,
		SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) 
		AS Rolling_vaccinate_count
FROM	covid_deaths AS dea
JOIN	covid_vaccinations AS vac
		ON	dea.location = vac.location
			AND dea.date = vac.date
WHERE	dea.continent IS NOT NULL)

SELECT	*,(Rolling_vaccinate_count/population)*100
FROM Pop_vs_Vac
ORDER BY 2,3


-- TEMP Table
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(	continent NVARCHAR(255), 
	location NVARCHAR(255), 
	date DATETIME,
	population NUMERIC,
	new_vaccinations NUMERIC,
	Rolling_vaccinate_count NUMERIC
)

INSERT INTO #PercentPopulationVaccinated
SELECT	dea.continent, 
		dea.location, 
		dea.date,
		dea.population,
		vac.new_vaccinations,
		SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) 
		AS Rolling_vaccinate_count
FROM	covid_deaths AS dea
JOIN	covid_vaccinations AS vac
		ON	dea.location = vac.location
			AND dea.date = vac.date
WHERE	dea.continent IS NOT NULL

SELECT	*,(Rolling_vaccinate_count/population)*100
FROM #PercentPopulationVaccinated
ORDER BY 2,3

-- CREATE VIEW
CREATE VIEW PercentPopulationVaccinated AS 
SELECT	dea.continent, 
		dea.location, 
		dea.date,
		dea.population,
		vac.new_vaccinations,
		SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) 
		AS Rolling_vaccinate_count
FROM	covid_deaths AS dea
JOIN	covid_vaccinations AS vac
		ON	dea.location = vac.location
			AND dea.date = vac.date
WHERE	dea.continent IS NOT NULL

SELECT * 
FROM PercentPopulationVaccinated