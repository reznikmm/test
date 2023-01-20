with Ada.Exceptions;
with GNAT.Exception_Actions;
procedure Test is
begin
   GNAT.Exception_Actions.Core_Dump (Ada.Exceptions.Null_Occurrence);
end Test;
