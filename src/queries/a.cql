// All users mentioned in all tweets containing at least one hashtag used by Thomas

with [(u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) where u.name = "Thomas" | h.tag] as hlist
with [(st:Tweet)-[:CONTAINS]->(sh:Hashtag) where sh.tag in hlist | st.text] as tlist
match (sst:Tweet)-[:MENTIONS]->(su:User) where sst.text in tlist
return distinct su.name;