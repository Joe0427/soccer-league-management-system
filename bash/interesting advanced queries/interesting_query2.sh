#!/bin/bash

export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

/* 
VIEW #4
6) I am the Manager (username specified when querying by view of a specific Team (team is known from which manager we are querying) and I want to see the players who scored higher than 
0.5 to see who is providing the most value playing in the 'FIRSTTEAM' so that I can later adjust salaries and the First Team lineup.
*/

CREATE VIEW GoodPlayerPerformance AS
SELECT tm.Username,p.FirstName, p.LastName,p.PlayerPosition, t.TeamName, AVG(gps.PlayerGoals) AS GoalsPerGame
FROM Player p, GamePlayerStats gps, Team t, TeamManagement tm
WHERE p.PlayerID = gps.PlayerID AND p.TeamID = t.TeamID AND tm.TeamID = p.TeamID
GROUP BY tm.Username,p.FirstName, p.LastName,p.PlayerPosition, t.TeamName
HAVING AVG(gps.PlayerGoals) > 0.5
ORDER BY GoalsPerGame DESC;

exit;
EOF
