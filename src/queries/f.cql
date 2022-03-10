// Tweets that start with ‘we’ and contain the hashtag ‘proud’

match (t:Tweet) where t.text starts with "we" and t.text contains "#proud" return t;