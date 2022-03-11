// Names of 5 least followed users and the followers count in ascending order

match (su1:User)-[:FOLLOWS]->(su2:User)
with su2, count(su1) as cu
order by cu asc
limit 5
return su2.name, cu;