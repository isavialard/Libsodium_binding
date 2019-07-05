pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;
with crypto_auth_hmacsha512_h;

package crypto_auth_hmacsha512256_h is

   crypto_auth_hmacsha512256_BYTES : constant := 32;  --  ./sodium/crypto_auth_hmacsha512256.h:15

   crypto_auth_hmacsha512256_KEYBYTES : constant := 32;  --  ./sodium/crypto_auth_hmacsha512256.h:19

   function crypto_auth_hmacsha512256_bytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha512256.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_bytes";

   function crypto_auth_hmacsha512256_keybytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha512256.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_keybytes";

   function crypto_auth_hmacsha512256
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha512256.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256";

   function crypto_auth_hmacsha512256_verify
     (h : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha512256.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_verify";

  -- -------------------------------------------------------------------------  
   subtype crypto_auth_hmacsha512256_state is crypto_auth_hmacsha512_h.crypto_auth_hmacsha512_state;  -- ./sodium/crypto_auth_hmacsha512256.h:38

   function crypto_auth_hmacsha512256_statebytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha512256.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_statebytes";

   function crypto_auth_hmacsha512256_init
     (state : access crypto_auth_hmacsha512256_state;
      key : access unsigned_char;
      keylen : stddef_h.size_t) return int  -- ./sodium/crypto_auth_hmacsha512256.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_init";

   function crypto_auth_hmacsha512256_update
     (state : access crypto_auth_hmacsha512256_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_auth_hmacsha512256.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_update";

   function crypto_auth_hmacsha512256_final (state : access crypto_auth_hmacsha512256_state; c_out : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha512256.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_final";

   procedure crypto_auth_hmacsha512256_keygen (k : access unsigned_char)  -- ./sodium/crypto_auth_hmacsha512256.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512256_keygen";

end crypto_auth_hmacsha512256_h;
