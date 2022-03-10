// Find all users Jessica follows
match (u1:User)-[:FOLLOWS]-(u2:User) where u1.name = "Jessica" return u2;

// All tweets by Thomas
match (u:User)-[:SENT]-(t:Tweet) where u.name = "Thomas" return t;

// All hashtags used by Thomas
match (u:User)-[:SENT]-(t:Tweet)-[:CONTAINS]-(h:Hashtag) 
where u.name = "Thomas" return h;

// Hashtags used by Thomas per tweet
match (u:User)-[:SENT]-(t:Tweet)-[:CONTAINS]-(h:Hashtag) 
where u.name = "Thomas" return t, collect(h);

// Get list of hashtags used by Thomas as a list
with [(u:User)-[:SENT]-(t:Tweet)-[:CONTAINS]-(h:Hashtag) where u.name = "Thomas" | h.tag] as hlist
return hlist;

// All tweets containing at least one hashtag used by Thomas
with [(u:User)-[:SENT]-(t:Tweet)-[:CONTAINS]-(h:Hashtag) where u.name = "Thomas" | h.tag] as hlist
match (st:Tweet)-[:CONTAINS]-(sh:Hashtag) where sh.tag in hlist
return st;

// All users mentioned in all tweets containing at least one hashtag used by Thomas


