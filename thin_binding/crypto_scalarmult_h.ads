pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;

package crypto_scalarmult_h is

   --  unsupported macro: crypto_scalarmult_BYTES crypto_scalarmult_curve25519_BYTES
   --  unsupported macro: crypto_scalarmult_SCALARBYTES crypto_scalarmult_curve25519_SCALARBYTES
   crypto_scalarmult_PRIMITIVE : aliased constant String := "curve25519" & ASCII.NUL;  --  ./sodium/crypto_scalarmult.h:21

   function crypto_scalarmult_bytes return stddef_h.size_t  -- ./sodium/crypto_scalarmult.h:15
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_bytes";

   function crypto_scalarmult_scalarbytes return stddef_h.size_t  -- ./sodium/crypto_scalarmult.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_scalarbytes";

   function crypto_scalarmult_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_scalarmult.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_primitive";

   function crypto_scalarmult_base (q : access unsigned_char; n : access unsigned_char) return int  -- ./sodium/crypto_scalarmult.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_base";

  -- * NOTE: Do not use the result of this function directly for key exchange.
  -- *
  -- * Hash the result with the public keys in order to compute a shared
  -- * secret key: H(q || client_pk || server_pk)
  -- *
  -- * Or unless this is not an option, use the crypto_kx() API instead.
  --  

   function crypto_scalarmult
     (q : access unsigned_char;
      n : access unsigned_char;
      p : access unsigned_char) return int  -- ./sodium/crypto_scalarmult.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult";

end crypto_scalarmult_h;
