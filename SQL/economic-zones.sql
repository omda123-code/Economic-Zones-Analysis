use BSMSN


-- 1. Which zones have the highest number of enterprises?
SELECT Zone, COUNT(*) AS NumberOfEnterprises
FROM data
GROUP BY Zone
ORDER BY NumberOfEnterprises DESC;

-- 2. Which countries are investing the most?
SELECT InvestingCountry, COUNT(*) AS NumberOfEnterprises
FROM Data
GROUP BY InvestingCountry
ORDER BY NumberOfEnterprises DESC;

-- 3. Which countries are investing the most?
SELECT InvestingCountry, COUNT(*) AS NumberOfEnterprises
FROM Data
GROUP BY InvestingCountry
ORDER BY NumberOfEnterprises DESC;

-- 4. What are the main product categories being invested in?
SELECT Products, COUNT(*) AS EnterpriseCount
FROM Data
GROUP BY Products
ORDER BY EnterpriseCount DESC;

-- 5. What types of incentives are available for enterprises?
SELECT Incentives, Gazettes
FROM IncentivesForDevelopers;

-- 6. How many incentives are related to tax exemptions?
SELECT COUNT(*) AS TaxRelatedIncentives
FROM IncentivesForDevelopers
WHERE Incentives LIKE '%tax%';

-- 7. What is the average duration of incentives?
SELECT Incentives, Explanation
FROM IncentivesForDevelopers
WHERE Explanation LIKE '%year%';

-- 8. Which zones have the highest total investment?
SELECT Zone, SUM(TotalInvestment) AS TotalInvestment
FROM [zonal-data]
GROUP BY Zone
ORDER BY TotalInvestment DESC;

-- 9. Which zones are generating the highest export earnings?
SELECT Zone, SUM(ExportEarned) AS TotalExport
FROM [zonal-data]
GROUP BY Zone
ORDER BY TotalExport DESC;

-- 10. Which zones are creating the most job opportunities?
SELECT Zone, SUM(NewJobOpportunity) AS TotalJobs
FROM [zonal-data]
GROUP BY Zone
ORDER BY TotalJobs DESC;

-- 11. What is the investment efficiency (investment per unit of land)?
SELECT Zone, 
       SUM(TotalInvestment) / SUM(Land) AS InvestmentPerLand
FROM [zonal-data]
GROUP BY Zone
ORDER BY InvestmentPerLand DESC;

-- 12. Which zones attract the highest foreign investment, and which countries are leading?
SELECT e.Zone, e.InvestingCountry, 
       COUNT(e.NameOfEnterprise) AS EnterpriseCount,
       SUM(z.TotalInvestment) AS ZoneInvestment
FROM Data e
JOIN [zonal-data] z ON e.Zone = z.Zone
GROUP BY e.Zone, e.InvestingCountry
ORDER BY ZoneInvestment DESC, EnterpriseCount DESC;

-- 13. What is the export performance by product category per zone?
SELECT e.Zone, e.Products, 
       COUNT(e.NameOfEnterprise) AS EnterpriseCount,
       SUM(z.ExportEarned) AS TotalExport
FROM Data e
JOIN [zonal-data] z ON e.Zone = z.Zone
GROUP BY e.Zone, e.Products
ORDER BY TotalExport DESC;

-- 14. Which zones are generating the most jobs relative to the number of enterprises?
SELECT e.Zone, 
       COUNT(e.NameOfEnterprise) AS EnterpriseCount,
       SUM(z.NewJobOpportunity) AS TotalJobs,
       CASE WHEN COUNT(e.NameOfEnterprise) > 0 
            THEN CAST(SUM(z.NewJobOpportunity) AS FLOAT) / COUNT(e.NameOfEnterprise) 
            ELSE 0 END AS JobsPerEnterprise
FROM Data e
JOIN [zonal-data] z ON e.Zone = z.Zone
GROUP BY e.Zone
ORDER BY JobsPerEnterprise DESC;

-- 15. Which investing countries are associated with the highest export earnings?
SELECT e.InvestingCountry, 
       SUM(z.ExportEarned) AS TotalExport,
       COUNT(e.NameOfEnterprise) AS EnterpriseCount
FROM Data e
JOIN [zonal-data] z ON e.Zone = z.Zone
GROUP BY e.InvestingCountry
ORDER BY TotalExport DESC;

-- 16. What is the average investment per enterprise in each zone?
SELECT e.Zone, 
       SUM(z.TotalInvestment) / COUNT(e.NameOfEnterprise) AS InvestmentPerEnterprise
FROM Data e
JOIN [zonal-data] z ON e.Zone = z.Zone
GROUP BY e.Zone
ORDER BY InvestmentPerEnterprise DESC;

-- 17. Which product categories bring the highest job opportunities?
SELECT e.Products, 
       SUM(z.NewJobOpportunity) AS TotalJobs
FROM Data e
JOIN [zonal-data] z ON e.Zone = z.Zone
GROUP BY e.Products
ORDER BY TotalJobs DESC;











