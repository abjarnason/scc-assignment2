A = LOAD 'user-links-small.txt' AS (user1_link:int, user2_link:int);
B = LOAD 'user-wall-small.txt' AS (user1_wall:int, user2_wall:int, time:int);
C = COGROUP A BY user1_link, B BY user1_wall;
D = FOREACH C GENERATE group AS user, COUNT(A) AS degree, COUNT(B) AS posts;
E = GROUP D BY degree;
F = FOREACH E GENERATE COUNT(D) AS user_number, group AS degree, $1.posts AS posts;
G = FOREACH F GENERATE degree, AVG(posts);
H = ORDER G BY degree ASC;
STORE H into 'question-2-output';
