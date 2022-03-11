// Update the name of user “Ashley” to “Ash”

MATCH (u:User {name: "Ashley"})
SET u.name = "Ash";
