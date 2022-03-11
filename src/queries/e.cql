// The names of the top 5 users according to their total retweet count

match (u:User)-[:SENT]->(t:Tweet) 
with t, count(distinct u) as nu, collect(distinct u) as us
unwind us as lus
with max(nu) as mnu, lus.name as names 
order by mnu desc, names asc 
return names limit 5;