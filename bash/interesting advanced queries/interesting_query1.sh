#!/bin/bash

export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

/* 
5) A special trophy is given to those who got the most amount of hattricks or higher (3 goals or more in a single game). 
The competition Admin (Joseph Guirguis) wants to find who got the most amount of hattricks (more than 3 in a game counts as a hattrick).
*/

SELECT p.PlayerID, p.FirstName, p.LastName, p.PlayerPosition, t.TeamName,COUNT(gps.PlayerID) AS hattricks
FROM GamePlayerStats gps, Player p, Game g, Team t
WHERE p.PlayerID = gps.PlayerID AND gps.PlayerGoals >= 3 AND g.GameID = gps.GameID AND p.TeamID = t.TeamID
GROUP BY p.PlayerID, p.FirstName, p.LastName, p.PlayerPosition, t.TeamName
ORDER BY hattricks DESC;

exit;
EOF
