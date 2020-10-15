create or replace procedure showrow(
   id int
)
language plpgsql    
as $$
begin
    /*-- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;*/

    --SELECT * FROM district WHERE code=id;
    UPDATE district
    set name = 'C2000'
    WHERE code=id;

    commit;
end;$$