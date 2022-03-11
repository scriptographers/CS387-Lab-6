// Return all distinct user name A and tweet text T, where any followers of A is mentioned in T which is posted by a 3rd level follower and T contains a hashtag of > 15 characters

WITH [(u:User)<-[:FOLLOWS*3]-(u3:User)-[:SENT]->(t:Tweet)-[:CONTAINS ]->(h:Hashtag)
WHERE size(h.tag) > 15 | [u.id, t.id] ] AS temp
MATCH (t:Tweet)-[:MENTIONS]->(u2:User)-[:FOLLOWS]->(u:User)
WHERE [u.id, t.id] IN temp
RETURN u.name, t.text
