pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with crypto_hash_sha512_h;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_sign_ed25519_h is

   crypto_sign_ed25519_BYTES : constant := 64;  --  ./sodium/crypto_sign_ed25519.h:22

   crypto_sign_ed25519_SEEDBYTES : constant := 32;  --  ./sodium/crypto_sign_ed25519.h:26

   crypto_sign_ed25519_PUBLICKEYBYTES : constant := 32;  --  ./sodium/crypto_sign_ed25519.h:30

   crypto_sign_ed25519_SECRETKEYBYTES : constant := (32 + 32);  --  ./sodium/crypto_sign_ed25519.h:34
   --  unsupported macro: crypto_sign_ed25519_MESSAGEBYTES_MAX (SODIUM_SIZE_MAX - crypto_sign_ed25519_BYTES)

   type crypto_sign_ed25519ph_state is record
      hs : aliased crypto_hash_sha512_h.crypto_hash_sha512_state;  -- ./sodium/crypto_sign_ed25519.h:16
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_sign_ed25519.h:15

   function crypto_sign_ed25519ph_statebytes return stddef_h.size_t  -- ./sodium/crypto_sign_ed25519.h:20
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519ph_statebytes";

   function crypto_sign_ed25519_bytes return stddef_h.size_t  -- ./sodium/crypto_sign_ed25519.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_bytes";

   function crypto_sign_ed25519_seedbytes return stddef_h.size_t  -- ./sodium/crypto_sign_ed25519.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_seedbytes";

   function crypto_sign_ed25519_publickeybytes return stddef_h.size_t  -- ./sodium/crypto_sign_ed25519.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_publickeybytes";

   function crypto_sign_ed25519_secretkeybytes return stddef_h.size_t  -- ./sodium/crypto_sign_ed25519.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_secretkeybytes";

   function crypto_sign_ed25519_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_sign_ed25519.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_messagebytes_max";

   function crypto_sign_ed25519
     (sm : access unsigned_char;
      smlen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      sk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519";

   function crypto_sign_ed25519_open
     (m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      sm : access unsigned_char;
      smlen : Extensions.unsigned_long_long;
      pk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_open";

   function crypto_sign_ed25519_detached
     (sig : access unsigned_char;
      siglen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      sk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_detached";

   function crypto_sign_ed25519_verify_detached
     (sig : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      pk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_verify_detached";

   function crypto_sign_ed25519_keypair (pk : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_keypair";

   function crypto_sign_ed25519_seed_keypair
     (pk : access unsigned_char;
      sk : access unsigned_char;
      seed : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:74
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_seed_keypair";

   function crypto_sign_ed25519_pk_to_curve25519 (curve25519_pk : access unsigned_char; ed25519_pk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_pk_to_curve25519";

   function crypto_sign_ed25519_sk_to_curve25519 (curve25519_sk : access unsigned_char; ed25519_sk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_sk_to_curve25519";

   function crypto_sign_ed25519_sk_to_seed (seed : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:89
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_sk_to_seed";

   function crypto_sign_ed25519_sk_to_pk (pk : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:94
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519_sk_to_pk";

   function crypto_sign_ed25519ph_init (state : access crypto_sign_ed25519ph_state) return int  -- ./sodium/crypto_sign_ed25519.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519ph_init";

   function crypto_sign_ed25519ph_update
     (state : access crypto_sign_ed25519ph_state;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_sign_ed25519.h:102
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519ph_update";

   function crypto_sign_ed25519ph_final_create
     (state : access crypto_sign_ed25519ph_state;
      sig : access unsigned_char;
      siglen_p : access Extensions.unsigned_long_long;
      sk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:108
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519ph_final_create";

   function crypto_sign_ed25519ph_final_verify
     (state : access crypto_sign_ed25519ph_state;
      sig : access unsigned_char;
      pk : access unsigned_char) return int  -- ./sodium/crypto_sign_ed25519.h:115
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_sign_ed25519ph_final_verify";

end crypto_sign_ed25519_h;
