pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;

package crypto_verify_16_h is

   crypto_verify_16_BYTES : constant := 16;  --  ./sodium/crypto_verify_16.h:11

   function crypto_verify_16_bytes return stddef_h.size_t  -- ./sodium/crypto_verify_16.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_verify_16_bytes";

   function crypto_verify_16 (x : access unsigned_char; y : access unsigned_char) return int  -- ./sodium/crypto_verify_16.h:16
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_verify_16";

end crypto_verify_16_h;
