pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_auth_h is

   --  unsupported macro: crypto_auth_BYTES crypto_auth_hmacsha512256_BYTES
   --  unsupported macro: crypto_auth_KEYBYTES crypto_auth_hmacsha512256_KEYBYTES
   crypto_auth_PRIMITIVE : aliased constant String := "hmacsha512256" & ASCII.NUL;  --  ./sodium/crypto_auth.h:24

   function crypto_auth_bytes return stddef_h.size_t  -- ./sodium/crypto_auth.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_bytes";

   function crypto_auth_keybytes return stddef_h.size_t  -- ./sodium/crypto_auth.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_keybytes";

   function crypto_auth_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_auth.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_primitive";

   function crypto_auth
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth";

   function crypto_auth_verify
     (h : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_verify";

   procedure crypto_auth_keygen (k : access unsigned_char)  -- ./sodium/crypto_auth.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_keygen";

end crypto_auth_h;
