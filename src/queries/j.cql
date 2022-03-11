// Return all distinct user name A and tweet text T, where any followers of A is mentioned in T which is posted by a 3rd level follower and T contains a hashtag of > 15 characters

with [(u:User)<-[:FOLLOWS*3]-(u3:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) where size(h.tag) > 15 | u.id AS uid, t.id AS tid ] AS temp
match (t:tweet)-[:MENTIONS]->(u2:User)-[:FOLLOWS]->(u:User)
where u.id = temp.uid and t.id = temp.tid
return u.name, t.text
