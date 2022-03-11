// Update the name of user “Ashley” to “Ash”

match (u:User {name: 'Ashley'})
set u.name = 'Ash';