// All users mentioned in all tweets containing at least one hashtag used by Thomas

WITH [(u:User)-[:SENT]->(t:Tweet)-[:CONTAINS ]->(h:Hashtag)
WHERE u.name = "Thomas" | h.tag] AS hlist
WITH [(st:Tweet)-[:CONTAINS ]->(sh:Hashtag)
WHERE sh.tag IN hlist | st.text] AS tlist
MATCH (sst:Tweet)-[:MENTIONS]->(su:User)
WHERE sst.text IN tlist
RETURN DISTINCT su.name;
