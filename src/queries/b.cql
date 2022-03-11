// Max number of hops between the user “Jessica” and any other user connected by “Follows” relation.

match p = (s:User)-[:FOLLOWS*]->(t:User)
where s.name = "Jessica" and t.name <> "Jessica" 
with distinct p as dp
with dp, length(dp) as plen
return dp, plen order by plen desc limit 5; 