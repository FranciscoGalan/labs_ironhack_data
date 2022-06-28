use world;
-- SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT country.name, otra.city_name, otra.population
FROM country
INNER JOIN (SELECT city.CountryCode, city.ID, city.name as 'city_name', MAX(city.Population) as 'population' 
FROM city 
GROUP BY city.CountryCode) otra
ON country.Code = otra.CountryCode AND country.capital = otra.ID;







SELECT country.name, country.population, country.LifeExpectancy, country.GNP, country.GovernmentForm,
countrylanguage.Language
FROM country
INNER JOIN countrylanguage
ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language = 'Spanish' AND countrylanguage.IsOfficial = True;








SELECT country.name, country.Population, country.LifeExpectancy, country.GNP, country.GovernmentForm, countrylanguage.Language,
countrylanguage.IsOfficial, countrylanguage.Percentage
FROM country
INNER JOIN countrylanguage
ON country.Code = countrylanguage.CountryCode 
WHERE sp.IsOfficial = 'F'
GROUP BY sp.name, sp.Population, sp.LifeExpectancy, sp.GNP, sp.GovernmentForm, sp.Language;



SELECT co.name, co.Population, co.LifeExpectancy, co.GNP, co.GovernmentForm, la.Language, MAX(la.Max_Percentage)
FROM country co 
INNER JOIN (
SELECT cl.CountryCode, cl.Language, MAX(cl.Percentage) 'Max_Percentage'
FROM countrylanguage cl
WHERE cl.IsOfficial = 'F'
GROUP BY cl.CountryCode, cl.Language
) la ON co.Code = la.CountryCode 
GROUP BY la.Language