// Tweets that start with ‘we’ and contain the hashtag ‘proud’

MATCH (t:Tweet)
WHERE t.text STARTS WITH "we" AND t.text CONTAINS "#proud"
RETURN t.text;
