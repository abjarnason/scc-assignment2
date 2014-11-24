A = LOAD 'user-links-small.txt' AS (user1:int, user2:int);
B = GROUP A BY user1;
-- count how many friends a user has
C = FOREACH B GENERATE COUNT($1);
-- group users by number of friends
D = GROUP C BY $0;
-- output the groups and number of users in each group
E = FOREACH D GENERATE group, COUNT($1);
-- sort in increasing order of degree
F = ORDER E BY group ASC;
STORE F into 'question-1-out';
