// Delete all users mentioned in a tweet by ‘Thomas’.
// Note: This should also delete all relationships of mentioned users (cascade delete)

WITH [(u:User)-[:SENT]->(t:Tweet)
WHERE u.name = "Thomas" | t.text] AS tlist
WITH [(st:Tweet)-[:MENTIONS]->(su:User)
WHERE st.text IN tlist | su.name] AS ulist
MATCH (ssu:User)
WHERE ssu.name IN ulist
DETACH DELETE ssu;
