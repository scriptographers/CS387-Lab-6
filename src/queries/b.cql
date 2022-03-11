// Max number of hops between the user “Jessica” and any other user connected by “Follows” relation.

MATCH p = shortestPath((s:User {name: "Jessica"})-[:FOLLOWS*]->(t:User))
WHERE t.name <> "Jessica"
RETURN max(length(p)) AS hops;
