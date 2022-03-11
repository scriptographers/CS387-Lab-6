// All users with more number of followers than “Jessica”

MATCH (u1:User)-[:FOLLOWS]->(u2:User)
WHERE u2.name = "Jessica"
WITH count(*) AS jc
MATCH (su1:User)-[:FOLLOWS]->(su2:User)
WITH su2, count(su1) AS cu, jc
WHERE cu > jc
RETURN DISTINCT su2.name;
