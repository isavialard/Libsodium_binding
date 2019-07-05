pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_aead_xchacha20poly1305_h is

   crypto_aead_xchacha20poly1305_ietf_KEYBYTES : constant := 32;  --  ./sodium/crypto_aead_xchacha20poly1305.h:14

   crypto_aead_xchacha20poly1305_ietf_NSECBYTES : constant := 0;  --  ./sodium/crypto_aead_xchacha20poly1305.h:18

   crypto_aead_xchacha20poly1305_ietf_NPUBBYTES : constant := 24;  --  ./sodium/crypto_aead_xchacha20poly1305.h:22

   crypto_aead_xchacha20poly1305_ietf_ABYTES : constant := 16;  --  ./sodium/crypto_aead_xchacha20poly1305.h:26
   --  unsupported macro: crypto_aead_xchacha20poly1305_ietf_MESSAGEBYTES_MAX (SODIUM_SIZE_MAX - crypto_aead_xchacha20poly1305_ietf_ABYTES)
   --  unsupported macro: crypto_aead_xchacha20poly1305_IETF_KEYBYTES crypto_aead_xchacha20poly1305_ietf_KEYBYTES
   --  unsupported macro: crypto_aead_xchacha20poly1305_IETF_NSECBYTES crypto_aead_xchacha20poly1305_ietf_NSECBYTES
   --  unsupported macro: crypto_aead_xchacha20poly1305_IETF_NPUBBYTES crypto_aead_xchacha20poly1305_ietf_NPUBBYTES
   --  unsupported macro: crypto_aead_xchacha20poly1305_IETF_ABYTES crypto_aead_xchacha20poly1305_ietf_ABYTES
   --  unsupported macro: crypto_aead_xchacha20poly1305_IETF_MESSAGEBYTES_MAX crypto_aead_xchacha20poly1305_ietf_MESSAGEBYTES_MAX

   function crypto_aead_xchacha20poly1305_ietf_keybytes return stddef_h.size_t  -- ./sodium/crypto_aead_xchacha20poly1305.h:16
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_keybytes";

   function crypto_aead_xchacha20poly1305_ietf_nsecbytes return stddef_h.size_t  -- ./sodium/crypto_aead_xchacha20poly1305.h:20
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_nsecbytes";

   function crypto_aead_xchacha20poly1305_ietf_npubbytes return stddef_h.size_t  -- ./sodium/crypto_aead_xchacha20poly1305.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_npubbytes";

   function crypto_aead_xchacha20poly1305_ietf_abytes return stddef_h.size_t  -- ./sodium/crypto_aead_xchacha20poly1305.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_abytes";

   function crypto_aead_xchacha20poly1305_ietf_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_aead_xchacha20poly1305.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_messagebytes_max";

   function crypto_aead_xchacha20poly1305_ietf_encrypt
     (c : access unsigned_char;
      clen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_xchacha20poly1305.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_encrypt";

   function crypto_aead_xchacha20poly1305_ietf_decrypt
     (m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_xchacha20poly1305.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_decrypt";

   function crypto_aead_xchacha20poly1305_ietf_encrypt_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      maclen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_xchacha20poly1305.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_encrypt_detached";

   function crypto_aead_xchacha20poly1305_ietf_decrypt_detached
     (m : access unsigned_char;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      mac : access unsigned_char;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_xchacha20poly1305.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_decrypt_detached";

   procedure crypto_aead_xchacha20poly1305_ietf_keygen (k : access unsigned_char)  -- ./sodium/crypto_aead_xchacha20poly1305.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_xchacha20poly1305_ietf_keygen";

  -- Aliases  
end crypto_aead_xchacha20poly1305_h;
