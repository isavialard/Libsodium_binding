pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package core_h is

   function sodium_init return int  -- ./sodium/core.h:12
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_init";

  -- ----  
   function sodium_set_misuse_handler (handler : access procedure) return int  -- ./sodium/core.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_set_misuse_handler";

   procedure sodium_misuse  -- ./sodium/core.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_misuse";

end core_h;
