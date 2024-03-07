
create or replace procedure addValueInTableAmb()
language plpgsql
as $$
declare
	ckey_number numeric := 1;
    text_code varchar(16);
	array_string varchar(16) [];
begin
	FOR text_code IN SELECT TEXTCODE FROM test.amb LOOP
		array_string := regexp_split_to_array(text_code,'\.');

        UPDATE test.amb
        SET CKEY = ckey_number,
            CNUM = CAST(array_string[cardinality(array_string) - 1] as numeric),
            CEND = CASE
                        WHEN text_code ~ '\d+\.\d+' THEN 1
                        ELSE 0
                   END
        WHERE TEXTCODE = text_code;

        ckey_number := ckey_number + 1;
    END LOOP;
END;
$$

CALL test.addValueInTableAmb();
Select * from test.amb


