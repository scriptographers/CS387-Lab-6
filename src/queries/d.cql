// Names of 5 least followed users and the followers count in ascending order

CALL {
MATCH (su1:User)-[:FOLLOWS]->(su2:User)
WITH su2, count(su1) AS cnt
 ORDER BY cnt asc, su2.name asc
RETURN su2.name AS users, cnt
UNION all
WITH [(su1:User)-[:FOLLOWS]->(su2:User) | su2.name] AS hf
UNWIND (hf) AS uhf
WITH collect(DISTINCT uhf) AS dhf
MATCH (u:User)
WHERE NOT u.name IN dhf
RETURN u.name AS users, 0 AS cnt
}
RETURN users, cnt ORDER BY cnt asc, users asc
LIMIT 5;
