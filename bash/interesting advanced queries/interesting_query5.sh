#!/bin/bash

export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

/*
5) Get players who received yellow cards using the EXISTS operator.
*/
SELECT p.PlayerID, p.FirstName, p.LastName, t.TeamName
FROM Player p
JOIN Team t ON p.TeamID = t.TeamID
WHERE EXISTS (
    SELECT *
    FROM GamePlayerStats gps
    JOIN Player p2 ON gps.PlayerID = p2.PlayerID
    WHERE p2.TeamID = t.TeamID
    AND gps.PlayerYellowCards > 0
);



exit;
EOF
