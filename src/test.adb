with Ada.Exceptions;
with GNAT.Exception_Actions;

package body Test is

   procedure Core_Dump is
   begin
      GNAT.Exception_Actions.Core_Dump (Ada.Exceptions.Null_Occurrence);
   end Core_Dump;

end Test;