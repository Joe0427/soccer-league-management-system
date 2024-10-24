#!/bin/bash

export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF

/* 
12) Retrieve all players who either scored more than 2 goals and/or assisted 1 goal or more in a game  
*/
SELECT p.PlayerID,p.FirstName,p.LastName,gps.PlayerGoals,gps.PlayerAssists
FROM GamePlayerStats gps,Player p
WHERE gps.PlayerGoals > 2 and p.PlayerID = gps.PlayerID
UNION
SELECT p.PlayerID,p.FirstName,p.LastName,gps.PlayerGoals,gps.PlayerAssists
FROM GamePlayerStats gps, Player p
WHERE gps.PlayerAssists > 0 and p.PlayerID = gps.PlayerID;

exit;
EOF
