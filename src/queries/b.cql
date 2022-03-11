// Max number of hops between the user “Jessica” and any other user connected by “Follows” relation.

match p = shortestPath((s:User)-[:FOLLOWS*]->(t:User))
where s.name = "Jessica" and t.name <> "Jessica"
return length(p) order by length(p) desc limit 1; 