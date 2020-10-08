/*USER, roles, provilegies*/

-- gel all roles
SELECT * from  pg_roles;

-- Create a new role (Options: LOGIN, )
CREATE ROLE golang
LOGIN
PASSWORD '1q2w3e';

--DROP ROLE golang;
