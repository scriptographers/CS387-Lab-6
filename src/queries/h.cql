// Find the tweet containing a maximum number of hashtags, return the tweet text and the number of hashtags it contains.

MATCH (u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag)
WITH t, collect(DISTINCT h.tag) AS htags
WITH t, size(htags) AS nh
RETURN t.text, nh ORDER BY nh desc
LIMIT 1;
