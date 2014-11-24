links = LOAD 'user-links-small.txt' AS (user1_link:int, user2_link:int);
posts = LOAD 'user-wall-small.txt' AS (user1_wall:int, user2_wall:int, time:int);
-- Group the data (multiple relations involved..)
cogrouping = COGROUP links BY user1_link, posts BY user1_wall;
-- generate new group and count the degree and number of posts
data = FOREACH cogrouping GENERATE group AS user, COUNT(links) AS degree, COUNT(posts) AS posts;
-- filter out users not appearing in user-links-small
filtered = FILTER data BY degree != 0;
group_by_degree = GROUP filtered BY degree;
-- get the filtered user count, degree and number of wall posts
generate_posts = FOREACH group_by_degree GENERATE COUNT(filtered) AS number_of_users, group AS degree, filtered.posts AS posts;
-- calculate average number of wall posts
generate_avg = FOREACH generate_posts GENERATE degree, AVG(posts);
-- order by increasing order of degree
sorted = ORDER generate_avg BY degree ASC;
STORE sorted into 'question-2-output';
