// Max number of hops between the user “Jessica” and any other user connected by “Follows” relation.

match p = (s:User)-[:FOLLOWS*]->(t:User)
where s.name = "Jessica" and t.name <> "Jessica" 
with p, length(p) as lp, reduce(l = [], n in nodes(p) | l + n.name) as names
unwind names as unames
with p, lp, collect(distinct unames) as dnames
with p, lp, size(dnames) as dlp 
where lp = dlp
return dlp order by dlp desc limit 1;