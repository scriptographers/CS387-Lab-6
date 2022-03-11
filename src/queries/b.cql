// Max number of hops between the user “Jessica” and any other user connected by “Follows” relation.

match p = (s:User)-[:FOLLOWS*]->(t:User)
where s.name = "Jessica" and t.name <> "Jessica" 
with reduce(l = [], n in nodes(p) | l + n.name) as names
unwind names as unames
with collect(distinct unames) as dnames
with size(dnames) as lp 
return lp order by lp desc limit 1;