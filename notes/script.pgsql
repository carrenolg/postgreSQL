SELECT * from weight WHERE full_name = 'Giovanny Carreño';

/*Arrays*/
SELECT ARRAY[0, 1, 2];
SELECT '{0, 1, 2}';

WITH aux_table AS (SELECT ARRAY[5,10,9] my_array)
SELECT my_array FROM aux_table;

WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT int_arr[2] FROM arr;

--sclicing an array
WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT int_arr[1:2] FROM arr;
