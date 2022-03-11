// Count the number of tweets CONTAINS regex “run” , ex #run, running, runs etc

MATCH (t:Tweet)
WHERE t.text CONTAINS "run"
RETURN count(t);
