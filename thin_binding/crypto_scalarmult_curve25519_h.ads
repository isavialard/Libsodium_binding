pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;

package crypto_scalarmult_curve25519_h is

   crypto_scalarmult_curve25519_BYTES : constant := 32;  --  ./sodium/crypto_scalarmult_curve25519.h:12

   crypto_scalarmult_curve25519_SCALARBYTES : constant := 32;  --  ./sodium/crypto_scalarmult_curve25519.h:16

   function crypto_scalarmult_curve25519_bytes return stddef_h.size_t  -- ./sodium/crypto_scalarmult_curve25519.h:14
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_curve25519_bytes";

   function crypto_scalarmult_curve25519_scalarbytes return stddef_h.size_t  -- ./sodium/crypto_scalarmult_curve25519.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_curve25519_scalarbytes";

  -- * NOTE: Do not use the result of this function directly for key exchange.
  -- *
  -- * Hash the result with the public keys in order to compute a shared
  -- * secret key: H(q || client_pk || server_pk)
  -- *
  -- * Or unless this is not an option, use the crypto_kx() API instead.
  --  

   function crypto_scalarmult_curve25519
     (q : access unsigned_char;
      n : access unsigned_char;
      p : access unsigned_char) return int  -- ./sodium/crypto_scalarmult_curve25519.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_curve25519";

   function crypto_scalarmult_curve25519_base (q : access unsigned_char; n : access unsigned_char) return int  -- ./sodium/crypto_scalarmult_curve25519.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_scalarmult_curve25519_base";

end crypto_scalarmult_curve25519_h;
