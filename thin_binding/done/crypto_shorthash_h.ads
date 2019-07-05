pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_shorthash_h is

   --  unsupported macro: crypto_shorthash_BYTES crypto_shorthash_siphash24_BYTES
   --  unsupported macro: crypto_shorthash_KEYBYTES crypto_shorthash_siphash24_KEYBYTES
   crypto_shorthash_PRIMITIVE : aliased constant String := "siphash24" & ASCII.NUL;  --  ./sodium/crypto_shorthash.h:24

   function crypto_shorthash_bytes return stddef_h.size_t  -- ./sodium/crypto_shorthash.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_bytes";

   function crypto_shorthash_keybytes return stddef_h.size_t  -- ./sodium/crypto_shorthash.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_keybytes";

   function crypto_shorthash_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_shorthash.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_primitive";

   function crypto_shorthash
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_shorthash.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash";

   procedure crypto_shorthash_keygen (k : access unsigned_char)  -- ./sodium/crypto_shorthash.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_keygen";

end crypto_shorthash_h;
