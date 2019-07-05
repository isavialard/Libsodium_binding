pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;
with crypto_hash_sha512_h;

package crypto_auth_hmacsha512_h is

   crypto_auth_hmacsha512_BYTES : constant := 64;  --  ./sodium/crypto_auth_hmacsha512.h:15

   crypto_auth_hmacsha512_KEYBYTES : constant := 32;  --  ./sodium/crypto_auth_hmacsha512.h:19

   function crypto_auth_hmacsha512_bytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha512.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_bytes";

   function crypto_auth_hmacsha512_keybytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha512.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_keybytes";

   function crypto_auth_hmacsha512
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha512.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512";

   function crypto_auth_hmacsha512_verify
     (h : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha512.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_verify";

  -- -------------------------------------------------------------------------  
   type crypto_auth_hmacsha512_state is record
      ictx : aliased crypto_hash_sha512_h.crypto_hash_sha512_state;  -- ./sodium/crypto_auth_hmacsha512.h:39
      octx : aliased crypto_hash_sha512_h.crypto_hash_sha512_state;  -- ./sodium/crypto_auth_hmacsha512.h:40
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_auth_hmacsha512.h:38

   function crypto_auth_hmacsha512_statebytes return stddef_h.size_t  -- ./sodium/crypto_auth_hmacsha512.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_statebytes";

   function crypto_auth_hmacsha512_init
     (state : access crypto_auth_hmacsha512_state;
      key : access unsigned_char;
      keylen : stddef_h.size_t) return int  -- ./sodium/crypto_auth_hmacsha512.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_init";

   function crypto_auth_hmacsha512_update
     (state : access crypto_auth_hmacsha512_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_auth_hmacsha512.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_update";

   function crypto_auth_hmacsha512_final (state : access crypto_auth_hmacsha512_state; c_out : access unsigned_char) return int  -- ./sodium/crypto_auth_hmacsha512.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_final";

   procedure crypto_auth_hmacsha512_keygen (k : access unsigned_char)  -- ./sodium/crypto_auth_hmacsha512.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_auth_hmacsha512_keygen";

end crypto_auth_hmacsha512_h;
