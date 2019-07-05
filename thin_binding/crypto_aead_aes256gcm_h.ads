pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_aead_aes256gcm_h is

   crypto_aead_aes256gcm_KEYBYTES : constant := 32;  --  ./sodium/crypto_aead_aes256gcm.h:37

   crypto_aead_aes256gcm_NSECBYTES : constant := 0;  --  ./sodium/crypto_aead_aes256gcm.h:41

   crypto_aead_aes256gcm_NPUBBYTES : constant := 12;  --  ./sodium/crypto_aead_aes256gcm.h:45

   crypto_aead_aes256gcm_ABYTES : constant := 16;  --  ./sodium/crypto_aead_aes256gcm.h:49
   --  unsupported macro: crypto_aead_aes256gcm_MESSAGEBYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX - crypto_aead_aes256gcm_ABYTES, (16ULL * ((1ULL << 32) - 2ULL)))

  -- * WARNING: Despite being the most popular AEAD construction due to its
  -- * use in TLS, safely using AES-GCM in a different context is tricky.
  -- *
  -- * No more than ~ 350 GB of input data should be encrypted with a given key.
  -- * This is for ~ 16 KB messages -- Actual figures vary according to
  -- * message sizes.
  -- *
  -- * In addition, nonces are short and repeated nonces would totally destroy
  -- * the security of this scheme.
  -- *
  -- * Nonces should thus come from atomic counters, which can be difficult to
  -- * set up in a distributed environment.
  -- *
  -- * Unless you absolutely need AES-GCM, use crypto_aead_xchacha20poly1305_ietf_*()
  -- * instead. It doesn't have any of these limitations.
  -- * Or, if you don't need to authenticate additional data, just stick to
  -- * crypto_secretbox().
  --  

   function crypto_aead_aes256gcm_is_available return int  -- ./sodium/crypto_aead_aes256gcm.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_is_available";

   function crypto_aead_aes256gcm_keybytes return stddef_h.size_t  -- ./sodium/crypto_aead_aes256gcm.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_keybytes";

   function crypto_aead_aes256gcm_nsecbytes return stddef_h.size_t  -- ./sodium/crypto_aead_aes256gcm.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_nsecbytes";

   function crypto_aead_aes256gcm_npubbytes return stddef_h.size_t  -- ./sodium/crypto_aead_aes256gcm.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_npubbytes";

   function crypto_aead_aes256gcm_abytes return stddef_h.size_t  -- ./sodium/crypto_aead_aes256gcm.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_abytes";

   function crypto_aead_aes256gcm_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_aead_aes256gcm.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_messagebytes_max";

   type anon855_opaque_array is array (0 .. 511) of aliased unsigned_char;
   type crypto_aead_aes256gcm_state_u is record
      opaque : aliased anon855_opaque_array;  -- ./sodium/crypto_aead_aes256gcm.h:60
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_aead_aes256gcm.h:59

   subtype crypto_aead_aes256gcm_state is crypto_aead_aes256gcm_state_u;  -- ./sodium/crypto_aead_aes256gcm.h:61

   function crypto_aead_aes256gcm_statebytes return stddef_h.size_t  -- ./sodium/crypto_aead_aes256gcm.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_statebytes";

   function crypto_aead_aes256gcm_encrypt
     (c : access unsigned_char;
      clen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_aes256gcm.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_encrypt";

   function crypto_aead_aes256gcm_decrypt
     (m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_aes256gcm.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_decrypt";

   function crypto_aead_aes256gcm_encrypt_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      maclen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_aes256gcm.h:91
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_encrypt_detached";

   function crypto_aead_aes256gcm_decrypt_detached
     (m : access unsigned_char;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      mac : access unsigned_char;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_aes256gcm.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_decrypt_detached";

  -- -- Precomputation interface --  
   function crypto_aead_aes256gcm_beforenm (ctx_u : access crypto_aead_aes256gcm_state; k : access unsigned_char) return int  -- ./sodium/crypto_aead_aes256gcm.h:118
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_beforenm";

   function crypto_aead_aes256gcm_encrypt_afternm
     (c : access unsigned_char;
      clen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      ctx_u : access constant crypto_aead_aes256gcm_state) return int  -- ./sodium/crypto_aead_aes256gcm.h:123
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_encrypt_afternm";

   function crypto_aead_aes256gcm_decrypt_afternm
     (m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      ctx_u : access constant crypto_aead_aes256gcm_state) return int  -- ./sodium/crypto_aead_aes256gcm.h:135
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_decrypt_afternm";

   function crypto_aead_aes256gcm_encrypt_detached_afternm
     (c : access unsigned_char;
      mac : access unsigned_char;
      maclen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      ctx_u : access constant crypto_aead_aes256gcm_state) return int  -- ./sodium/crypto_aead_aes256gcm.h:147
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_encrypt_detached_afternm";

   function crypto_aead_aes256gcm_decrypt_detached_afternm
     (m : access unsigned_char;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      mac : access unsigned_char;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      ctx_u : access constant crypto_aead_aes256gcm_state) return int  -- ./sodium/crypto_aead_aes256gcm.h:160
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_decrypt_detached_afternm";

   procedure crypto_aead_aes256gcm_keygen (k : access unsigned_char)  -- ./sodium/crypto_aead_aes256gcm.h:172
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_aes256gcm_keygen";

end crypto_aead_aes256gcm_h;
