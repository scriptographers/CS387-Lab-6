// The names of the top 5 users according to their total retweet count

MATCH (u:User)-[:SENT]->(t:Tweet)
WITH t, count(DISTINCT u) - 1 AS nu, collect(DISTINCT u) AS us
UNWIND us AS lus
WITH sum(nu) AS mnu, lus.name AS names
ORDER BY mnu desc, names asc
RETURN names, mnu
LIMIT 5;
