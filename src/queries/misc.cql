// Find all users Jessica follows
match (u1:User)-[:FOLLOWS]->(u2:User) where u1.name = "Jessica" return u2;

// Number of followers of Jessica
match (u1:User)-[:FOLLOWS]->(u2:User) where u2.name = "Jessica"
with count(*) as jc
return jc;

// #followers per user
match (su1:User)-[:FOLLOWS]->(su2:User)
with su2, count(su1) as cu
return su2, cu;

// All tweets by Thomas
match (u:User)-[:SENT]->(t:Tweet) where u.name = "Thomas" return t;

// All hashtags used by Thomas
match (u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) 
where u.name = "Thomas" return h;

// Hashtags used by Thomas per tweet
match (u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) 
where u.name = "Thomas" return t, collect(h);

// Get list of hashtags used by Thomas as a list
with [(u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) where u.name = "Thomas" | h.tag] as hlist
return hlist;

// All tweets containing at least one hashtag used by Thomas
with [(u:User)-[:SENT]->(t:Tweet)-[:CONTAINS]->(h:Hashtag) where u.name = "Thomas" | h.tag] as hlist
match (st:Tweet)-[:CONTAINS]->(sh:Hashtag) where sh.tag in hlist
return st;

// Total number of times a tweet was tweeted by a distinct user and the users who tweeted it
match (u:User)-[:SENT]->(t:Tweet) 
with t, count(distinct u) as nu, collect(distinct u) as us
order by nu desc
return t, nu, us;

// All users mentioned by Thomas in his tweets
with [(u:User)-[:SENT]->(t:Tweet) where u.name = "Thomas" | t.text] as tlist
match (st:Tweet)-[:MENTIONS]->(su:User) where st.text in tlist
return distinct su.name;

// Shortest path between Jessica and all other users
match (s:User{name : "Jessica"}), (t:User), p = shortestPath((s)-[:FOLLOWS*]->(t))
where t.name <> "Jessica" 
return p;

// Longest paths from a node to all other nodes without repetitions
match p = (s:User)-[:FOLLOWS*]->(t:User)
where s.name = "Jessica" and t.name <> "Jessica" 
with p, length(p) as lp, reduce(l = [], n in nodes(p) | l + n.name) as names
unwind names as unames
with p, lp, collect(distinct unames) as dnames
with p, lp, size(dnames) as dlp 
where lp = dlp
return dlp order by dlp desc limit 1;