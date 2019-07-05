pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;
with crypto_hash_sha256_h;

package crypto_auth_hmacsha256_h is

   crypto_auth_hmacsha256_BYTES : constant := 32;  --  ./sodium/crypto_auth_hmacsha256.h:15

   crypto_auth_hmacsha256_KEYBYTES : constant := 32;  --  ./sodium/crypto_auth_hmacsha256.h:19

   function crypto_auth_hmacsha256_bytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha256.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_bytes";

   function crypto_auth_hmacsha256_keybytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha256.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_keybytes";

   function crypto_auth_hmacsha256
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha256.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256";

   function crypto_auth_hmacsha256_verify
     (h : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha256.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_verify";

  -- -------------------------------------------------------------------------  
   type crypto_auth_hmacsha256_state is record
      ictx : aliased crypto_hash_sha256_h.crypto_hash_sha256_state;  -- ./sodium/crypto_auth_hmacsha256.h:39
      octx : aliased crypto_hash_sha256_h.crypto_hash_sha256_state;  -- ./sodium/crypto_auth_hmacsha256.h:40
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_auth_hmacsha256.h:38

   function crypto_auth_hmacsha256_statebytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha256.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_statebytes";

   function crypto_auth_hmacsha256_init
     (state : access crypto_auth_hmacsha256_state;
      key : access unsigned_char;
      keylen : stddef_h.size_t) return int  -- ./sodium/crypto_auth_hmacsha256.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_init";

   function crypto_auth_hmacsha256_update
     (state : access crypto_auth_hmacsha256_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_auth_hmacsha256.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_update";

   function crypto_auth_hmacsha256_final (state : access crypto_auth_hmacsha256_state; c_out : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha256.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_final";

   procedure crypto_auth_hmacsha256_keygen (k : access unsigned_char)  -- ./sodium/crypto_auth_hmacsha256.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha256_keygen";

end crypto_auth_hmacsha256_h;
