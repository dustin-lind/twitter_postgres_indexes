SELECT (count(*) - 2) as count
FROM tweets_jsonb
WHERE 
   ( 
    to_tsvector('english',data->>'text')@@
        to_tsquery('english','coronavirus')
    OR
    to_tsvector('english',data->'extended_tweet'->>'full_text')@@
        to_tsquery('english','coronavirus')
    )
    AND
    data->>'lang' = 'en'
;
