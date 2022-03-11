// Delete all users mentioned in a tweet by ‘Thomas’. 
// Note: This should also delete all relationships of mentioned users (cascade delete)

with [(u:User)-[:SENT]->(t:Tweet) where u.name = "Thomas" | t.text] as tlist
with [(st:Tweet)-[:MENTIONS]->(su:User) where st.text in tlist | su.name] as ulist
match (ssu:User) where ssu.name in ulist
detach delete ssu;