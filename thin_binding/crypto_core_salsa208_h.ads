pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;

package crypto_core_salsa208_h is

   crypto_core_salsa208_OUTPUTBYTES : constant := 64;  --  ./sodium/crypto_core_salsa208.h:11

   crypto_core_salsa208_INPUTBYTES : constant := 16;  --  ./sodium/crypto_core_salsa208.h:16

   crypto_core_salsa208_KEYBYTES : constant := 32;  --  ./sodium/crypto_core_salsa208.h:21

   crypto_core_salsa208_CONSTBYTES : constant := 16;  --  ./sodium/crypto_core_salsa208.h:26

   function crypto_core_salsa208_outputbytes return stddef_h.size_t  -- ./sodium/crypto_core_salsa208.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_salsa208_outputbytes";

   function crypto_core_salsa208_inputbytes return stddef_h.size_t  -- ./sodium/crypto_core_salsa208.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_salsa208_inputbytes";

   function crypto_core_salsa208_keybytes return stddef_h.size_t  -- ./sodium/crypto_core_salsa208.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_salsa208_keybytes";

   function crypto_core_salsa208_constbytes return stddef_h.size_t  -- ./sodium/crypto_core_salsa208.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_salsa208_constbytes";

   function crypto_core_salsa208
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      k : access unsigned_char;
      c : access unsigned_char) return int  -- ./sodium/crypto_core_salsa208.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_salsa208";

end crypto_core_salsa208_h;
