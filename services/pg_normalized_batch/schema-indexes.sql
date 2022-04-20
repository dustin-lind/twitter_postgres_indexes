CREATE INDEX idx_1 ON tweet_tags (tag, id_tweets); -- check

CREATE INDEX idx_2 ON tweet_tags (id_tweets, tag); -- check

CREATE INDEX idx_3 ON tweets (id_tweets, lang); -- check

CREATE INDEX idx_4 on tweets (lang);

CREATE INDEX idx_5 ON tweets USING gin(to_tsvector('english',text)); -- check

