A = LOAD 'user-links-small.txt' AS (user1_link:int, user2_link:int);
B = LOAD 'user-wall-small.txt' AS (user1_wall:int, user2_wall:int, time:int);
-- Group the data (multiple relations involved..)
C = COGROUP A BY user1_link, B BY user1_wall;
-- generate new group and count the degree and number of posts
D = FOREACH C GENERATE group AS user, COUNT(A) AS degree, COUNT(B) AS posts;
-- filter out users not appearing in user-links-small
E = FILTER D BY degree != 0;
F = GROUP E BY degree;
-- get the filtered user count, degree and number of wall posts
G = FOREACH F GENERATE COUNT(E) AS users_num, group AS degree, E.posts AS posts;
-- calculate average number of wall posts
H = FOREACH G GENERATE degree, AVG(posts);
-- order by increasing order of degree
I = ORDER H BY degree ASC;
STORE I into 'question-2-output';
