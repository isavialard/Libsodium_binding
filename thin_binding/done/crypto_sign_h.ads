pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with crypto_sign_ed25519_h;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_sign_h is

   --  unsupported macro: crypto_sign_BYTES crypto_sign_ed25519_BYTES
   --  unsupported macro: crypto_sign_SEEDBYTES crypto_sign_ed25519_SEEDBYTES
   --  unsupported macro: crypto_sign_PUBLICKEYBYTES crypto_sign_ed25519_PUBLICKEYBYTES
   --  unsupported macro: crypto_sign_SECRETKEYBYTES crypto_sign_ed25519_SECRETKEYBYTES
   --  unsupported macro: crypto_sign_MESSAGEBYTES_MAX crypto_sign_ed25519_MESSAGEBYTES_MAX
   crypto_sign_PRIMITIVE : aliased constant String := "ed25519" & ASCII.NUL;  --  ./sodium/crypto_sign.h:48

  -- * THREAD SAFETY: crypto_sign_keypair() is thread-safe,
  -- * provided that sodium_init() was called before.
  -- *
  -- * Other functions, including crypto_sign_seed_keypair() are always thread-safe.
  --  

   subtype crypto_sign_state is crypto_sign_ed25519_h.crypto_sign_ed25519ph_state;  -- ./sodium/crypto_sign.h:23

   function crypto_sign_statebytes return stddef_h.size_t  -- ./sodium/crypto_sign.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_statebytes";

   function crypto_sign_bytes return stddef_h.size_t  -- ./sodium/crypto_sign.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_bytes";

   function crypto_sign_seedbytes return stddef_h.size_t  -- ./sodium/crypto_sign.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_seedbytes";

   function crypto_sign_publickeybytes return stddef_h.size_t  -- ./sodium/crypto_sign.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_publickeybytes";

   function crypto_sign_secretkeybytes return stddef_h.size_t  -- ./sodium/crypto_sign.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_secretkeybytes";

   function crypto_sign_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_sign.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_messagebytes_max";

   function crypto_sign_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_sign.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_primitive";

   function crypto_sign_seed_keypair
     (pk : access unsigned_char;
      sk : access unsigned_char;
      seed : access unsigned_char) return int  -- ./sodium/crypto_sign.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_seed_keypair";

   function crypto_sign_keypair (pk : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_sign.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_keypair";

   function crypto_sign
     (sm : access unsigned_char;
      smlen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      sk : access unsigned_char) return int  -- ./sodium/crypto_sign.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign";

   function crypto_sign_open
     (m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      sm : access unsigned_char;
      smlen : Extensions.unsigned_long_long;
      pk : access unsigned_char) return int  -- ./sodium/crypto_sign.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_open";

   function crypto_sign_detached
     (sig : access unsigned_char;
      siglen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      sk : access unsigned_char) return int  -- ./sodium/crypto_sign.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_detached";

   function crypto_sign_verify_detached
     (sig : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      pk : access unsigned_char) return int  -- ./sodium/crypto_sign.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_verify_detached";

   function crypto_sign_init (state : access crypto_sign_state) return int  -- ./sodium/crypto_sign.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_init";

   function crypto_sign_update
     (state : access crypto_sign_state;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_sign.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_update";

   function crypto_sign_final_create
     (state : access crypto_sign_state;
      sig : access unsigned_char;
      siglen_p : access Extensions.unsigned_long_long;
      sk : access unsigned_char) return int  -- ./sodium/crypto_sign.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_final_create";

   function crypto_sign_final_verify
     (state : access crypto_sign_state;
      sig : access unsigned_char;
      pk : access unsigned_char) return int  -- ./sodium/crypto_sign.h:99
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_final_verify";

end crypto_sign_h;
