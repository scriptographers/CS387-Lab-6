// Max number of hops between the user “Jessica” and any other user connected by “Follows” relation.

match p = shortestPath((s:User {name: "Jessica"})-[:FOLLOWS*]->(t:User))
where t.name <> "Jessica" 
return max(length(p));