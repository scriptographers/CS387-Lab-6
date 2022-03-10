// Count the number of tweets contains regex “run” , ex #run, running, runs etc

match (t:Tweet) where  t.text contains "run" return count(t);