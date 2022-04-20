SELECT
    '#' || t.hashtag as tag,
    count(*) as count
FROM (
    SELECT DISTINCT
        data->>'id' as id_tweets,
        jsonb_array_elements(data->'entities'->'hashtags')->>'text' as hashtag
    FROM tweets_jsonb
    WHERE
        to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus')
        AND
        data->>'lang' = 'en'
    UNION
    SELECT DISTINCT
        data->>'id' as id_tweets,
        jsonb_array_elements(data->'extended_tweet'->'entities'->'hashtags')->>'text' as hashtag
    FROM tweets_jsonb
    WHERE
        to_tsvector('english',data->'extended_tweet'->>'full_text')@@to_tsquery('english','coronavirus')
        AND
        data->>'lang' = 'en'
)t
GROUP BY t.hashtag
ORDER BY count DESC,t.hashtag
LIMIT 1000
;

/*
SELECT
    '#' || hashtag as tag,
    count(*) as count
FROM (
    SELECT id_tweets, hashtag
    FROM (
        SELECT DISTINCT
            data->>'id' as id_tweets,
            jsonb_array_elements(data->'entities'->'hashtags')->>'text' as hashtag,
            data->>'lang' as lang
        FROM tweets_jsonb
        WHERE
            to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus')
        UNION
        SELECT DISTINCT
            data->>'id' as id_tweets,
            jsonb_array_elements(data->'extended_tweet'->'entities'->'hashtags')->>'text' as hashtag,
            data->>'lang' as lang
        FROM tweets_jsonb
        WHERE
            to_tsvector('english',data->'extended_tweet'->>'full_text')@@to_tsquery('english','coronavirus')
    )t
    WHERE lang = 'en'
) t2
GROUP BY hashtag
ORDER BY count DESC,hashtag
LIMIT 1000
;
*/

