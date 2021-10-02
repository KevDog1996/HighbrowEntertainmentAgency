--1. Create an agent phone list
SELECT
	Concat(AgentFirstName, ' ', AgentLastName) AS AgentName,
	AgentPhone
FROM
	Agents;
--2. Create a list of customers by city
SELECT
	CONCAT(CustFirstName, ' ', CustLastName) AS CustName,
	CustAreaCode
FROM
	Customers
ORDER BY
	CustAreaCode DESC;
--3. Create a list of when an agent received their first review (180 days after being hired)
SELECT
	CONCAT(AgentFirstName, ' ', AgentLastName) AS AgentName,
	DateHired,
	DATEADD(day,180,DateHired) AS ReviewDay
FROM
	Agents;
--4. Create a report of the net price per contract that lists our fee (contract price * our fee (12%)) and the net amount per contract (contract price - (contract price * our fee (12%)) 
SELECT
    Convert(Decimal(10,2),SUM(ContractPrice * .12)) AS ContractFee,
    Convert(Decimal(10,2),SUM(ContractPrice - (ContractPrice * .12))) AS NetAmount
FROM
    Engagements
GROUP BY
    EngagementID;
--5. Create a report of all engagements that last more than 3 days
SELECT
	EngagementID,
	StartDate,
	EndDate
FROM
	Engagements
WHERE
	DATEDIFF(day, StartDate, EndDate) >= day(3);
--6. Create a report of all October engagments that occured in 2017
SELECT
	EngagementID,
	StartDate
FROM
	Engagements
WHERE
	Month(StartDate) = 10
AND
	Year(StartDate) = 2017;
--7. Create a report of all October engagements that occured between noon and five pm

Select
	EngagementID,	
	Convert(Varchar(10),Cast(StartDate AS TIME),0) as StartTime,
	Convert(Varchar(10),Cast(StartDate AS TIME),0) as EndTime
From
	Engagements
where
	Month(StartDate) = 10
and 
	Cast(StartDate As Time) >= '12:00:00'
and 
	Cast(EndDate As Time) <= '17:00:00'
and
	Day(EndDate) = Day (StartDate);

--8. Create a list of all customers and the groups they have booked
Select
	Concat(C.CustFirstName, ' ' ,C.CustLastName) as Customer,
	G.GroupStageName
From
	Customers C
Join(
	Select 
		C.CustID, G.GroupID
	From 
		Customers C
	Join
		Engagements E on C.CustID = E.CustID
	Join
		Groups G on E.GroupID = G.GroupID
	Group by G.GroupID, C.CustID
	) X on X.CustID = C.CustID
Join Groups G on G.GroupID = X.GroupID
Order by CustLastName, G.GroupStageName;

--9. Create a list of all agents that have no contracts

Select
	*
From
	Agents A
Left Join Engagements E on A.AgentID = E.AgentID
Where E.AgentID is Null;

--10. Create a list of all customers with no bookings

Select
	C.CustID,
	CONCAT(CustFirstName, ' ', CustLastName),
	EngagementID
From
	Customers C
Left Join
	Engagements E on C.CustID = E.CustID
Where E.CustID Is Null;

--11. Create a list of all performers that have never been booked

Select
	P.PerfFirstName,
	P.PerfLastName
	
From 
	Groups G
Left Join
	Engagements E on G.GroupID = E.GroupID
Join
	GroupMemberList L on G.GroupID = L.GroupID
Join
	Performers P on P.PerfID = L.PerfID
Where
	E.EngagementID Is Null;

--12. Create a list of each customers last booking 
Select
	Concat(
		C.CustLastName, 
		', ', 
		C.CustFirstName
	) as CustomerName,
	Convert(
		varchar,
		X.MostRecentDate,
		101
	) as MostRecentDate
From 
	Engagements E
Join(

	Select
		E.CustID,
		Max(E.StartDate) as MostRecentDate
	From Engagements E
	Group By E.CustID
) X on X.MostRecentDate = E.StartDate and X.CustID = E.CustID
Join
	Customers C on C.CustID = E.CustID
Order By C.CustLastName;

--13. Create a list of customers who like country or country rock

Select
	CustFirstName,
	CustLastName,
	StyleName
From
	MusicalPreferences P
Join
	MusicStyle S on S.StyleID = P.StyleID
Join
	Customers C on C.CustID = P.CustID
Where
	PreferenceRating = 1 and (S.StyleName = 'Country' or S.StyleName = 'Country Rock');

--14. Create a report of the number of engagements each group has performed for us

Select
	G.GroupStageName,
	ISNULL(X.NumberOF,0) as 'Number of proformances'
From 
	Groups G
Left Join
	(
		Select
			GroupId,
			Count(EngagementID) as NumberOF
		From
			Engagements
		Group By GroupID
	) X ON G.GroupID = X.GroupID
Order By GroupStageName;

--15. Create a report of the average agent salary

Select 
	Avg(A.Salary) AS AverageAgentSalary
From
	Agents A;

--16. Show our earliest October engagment in 2017

Select
	EngagementID,
	StartDate
From 
	Engagements E
Where
	StartDate = (
					Select
						Min(StartDate)
					from 
						Engagements 
					Where 
						Year(StartDate) = 2017
					AND
						Month(StartDate) = 10
				);

--17. Show the value of our October 2017 bookings

Select
	Sum(ContractPrice)
From 
	Engagements
Where
	Month(StartDate) = 10 and Year(StartDate) = 2017;

--18. Create a report of our agent sales and commissions. Report should have agent full name, the total contract proce for that agent, and the earned commission for that agent

Select 
	Concat(A.AgentFirstName, ' ', A.AgentLastName) as AgentName,
	TotalContracts,
	TotalCommissions
From
	Agents A
Join
	(
		Select
			A.AgentID,
			IsNull(Sum(E.ContractPrice),0) as TotalContracts,
			Round(ISNull(Sum(E.ContractPrice * A.CommissionRate), 0),2) as TotalCommissions
		From 
			Agents A
		Left Join
			Engagements E on E.AgentID = A.AgentID
		Group By A.AgentID
	) X on A.AgentID = X.AgentID
Order By AgentName;

--19. Show only those agents who have a commission greater than $1000

Select 
	Concat(A.AgentLastName, ', ', A.AgentFirstName) as AgentName,
	TotalCommissions
From
	Agents A
Join
	(
		Select
			A.AgentID,
			Round(ISNull(Sum(E.ContractPrice * A.CommissionRate), 0),2) as TotalCommissions
		From 
			Agents A
		Left Join
			Engagements E on E.AgentID = A.AgentID
		Group By A.AgentID
	) X on A.AgentID = X.AgentID
Where TotalCommissions > 1000
Order By AgentName;
