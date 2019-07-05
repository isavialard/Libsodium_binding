pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_shorthash_siphash24_h is

   crypto_shorthash_siphash24_BYTES : constant := 8;  --  ./sodium/crypto_shorthash_siphash24.h:16

   crypto_shorthash_siphash24_KEYBYTES : constant := 16;  --  ./sodium/crypto_shorthash_siphash24.h:20

   crypto_shorthash_siphashx24_BYTES : constant := 16;  --  ./sodium/crypto_shorthash_siphash24.h:32

   crypto_shorthash_siphashx24_KEYBYTES : constant := 16;  --  ./sodium/crypto_shorthash_siphash24.h:36

  -- -- 64-bit output --  
  -- -- 64-bit output --  
   function crypto_shorthash_siphash24_bytes return stddef_h.size_t  -- ./sodium/crypto_shorthash_siphash24.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_siphash24_bytes";

   function crypto_shorthash_siphash24_keybytes return stddef_h.size_t  -- ./sodium/crypto_shorthash_siphash24.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_siphash24_keybytes";

   function crypto_shorthash_siphash24
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_shorthash_siphash24.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_siphash24";

   function crypto_shorthash_siphashx24_bytes return stddef_h.size_t  -- ./sodium/crypto_shorthash_siphash24.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_siphashx24_bytes";

   function crypto_shorthash_siphashx24_keybytes return stddef_h.size_t  -- ./sodium/crypto_shorthash_siphash24.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_siphashx24_keybytes";

   function crypto_shorthash_siphashx24
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_shorthash_siphash24.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_shorthash_siphashx24";

end crypto_shorthash_siphash24_h;
