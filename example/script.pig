A = LOAD 'data_1.txt' AS (name,count);
B = ORDER A by count;
C = LIMIT B 10;
dump C;
