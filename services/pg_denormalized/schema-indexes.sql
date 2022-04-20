-- 01.sql
CREATE INDEX ON tweets_jsonb USING gin((data->'entities'->'hashtags'));
CREATE INDEX ON tweets_jsonb USING gin((data->'extended_tweet'->'entities'->'hashtags'));
-- 02.sql
/* No additional indexes */
-- 03.sql
CREATE INDEX ON tweets_jsonb ((data->>'lang'));
-- 04.sql
CREATE INDEX ON tweets_jsonb USING gin((to_tsvector('english',data->>'text')));
CREATE INDEX ON tweets_jsonb USING gin((to_tsvector('english',data->'extended_tweet'->>'full_text')));
