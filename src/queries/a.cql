// All users mentioned in all tweets containing at least one hashtag used by Thomas

with [(u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) where u.name = "Thomas" | h.id] as hlist
with [(st:Tweet)-[:CONTAINS]->(sh:Hashtag) where sh.id in hlist | st.id] as tlist
match (sst:Tweet)-[:MENTIONS]->(su:User) where sst.id in tlist
return distinct su;