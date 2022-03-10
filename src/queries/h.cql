// Find the tweet containing a maximum number of hashtags, return the tweet text and the number of hashtags it contains.

match (u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) 
with t, collect(h.id) as hids
with t, size(hids) as nh
order by nh desc
limit 1
return t, nh;