// Find the tweet containing a maximum number of hashtags, return the tweet text and the number of hashtags it contains.

match (u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) 
with t, collect(distinct h.tag) as htags
with t, size(htags) as nh
return t.text, nh order by nh desc limit 1;