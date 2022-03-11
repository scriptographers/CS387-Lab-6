// All users with more number of followers than “Jessica”

match (u1:User)-[:FOLLOWS]->(u2:User) where u2.name = "Jessica"
with count(*) as jc
match (su1:User)-[:FOLLOWS]->(su2:User)
with su2, count(su1) as cu, jc
where cu > jc
return su2.name;