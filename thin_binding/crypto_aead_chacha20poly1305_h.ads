pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_aead_chacha20poly1305_h is

   crypto_aead_chacha20poly1305_ietf_KEYBYTES : constant := 32;  --  ./sodium/crypto_aead_chacha20poly1305.h:16

   crypto_aead_chacha20poly1305_ietf_NSECBYTES : constant := 0;  --  ./sodium/crypto_aead_chacha20poly1305.h:20

   crypto_aead_chacha20poly1305_ietf_NPUBBYTES : constant := 12;  --  ./sodium/crypto_aead_chacha20poly1305.h:24

   crypto_aead_chacha20poly1305_ietf_ABYTES : constant := 16;  --  ./sodium/crypto_aead_chacha20poly1305.h:29
   --  unsupported macro: crypto_aead_chacha20poly1305_ietf_MESSAGEBYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX - crypto_aead_chacha20poly1305_ietf_ABYTES, (64ULL * ((1ULL << 32) - 1ULL)))

   crypto_aead_chacha20poly1305_KEYBYTES : constant := 32;  --  ./sodium/crypto_aead_chacha20poly1305.h:94

   crypto_aead_chacha20poly1305_NSECBYTES : constant := 0;  --  ./sodium/crypto_aead_chacha20poly1305.h:98

   crypto_aead_chacha20poly1305_NPUBBYTES : constant := 8;  --  ./sodium/crypto_aead_chacha20poly1305.h:102

   crypto_aead_chacha20poly1305_ABYTES : constant := 16;  --  ./sodium/crypto_aead_chacha20poly1305.h:106
   --  unsupported macro: crypto_aead_chacha20poly1305_MESSAGEBYTES_MAX (SODIUM_SIZE_MAX - crypto_aead_chacha20poly1305_ABYTES)
   --  unsupported macro: crypto_aead_chacha20poly1305_IETF_KEYBYTES crypto_aead_chacha20poly1305_ietf_KEYBYTES
   --  unsupported macro: crypto_aead_chacha20poly1305_IETF_NSECBYTES crypto_aead_chacha20poly1305_ietf_NSECBYTES
   --  unsupported macro: crypto_aead_chacha20poly1305_IETF_NPUBBYTES crypto_aead_chacha20poly1305_ietf_NPUBBYTES
   --  unsupported macro: crypto_aead_chacha20poly1305_IETF_ABYTES crypto_aead_chacha20poly1305_ietf_ABYTES
   --  unsupported macro: crypto_aead_chacha20poly1305_IETF_MESSAGEBYTES_MAX crypto_aead_chacha20poly1305_ietf_MESSAGEBYTES_MAX

  -- -- IETF ChaCha20-Poly1305 construction with a 96-bit nonce and a 32-bit internal counter --  
   function crypto_aead_chacha20poly1305_ietf_keybytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_keybytes";

   function crypto_aead_chacha20poly1305_ietf_nsecbytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_nsecbytes";

   function crypto_aead_chacha20poly1305_ietf_npubbytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_npubbytes";

   function crypto_aead_chacha20poly1305_ietf_abytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_abytes";

   function crypto_aead_chacha20poly1305_ietf_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_messagebytes_max";

   function crypto_aead_chacha20poly1305_ietf_encrypt
     (c : access unsigned_char;
      clen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_encrypt";

   function crypto_aead_chacha20poly1305_ietf_decrypt
     (m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_decrypt";

   function crypto_aead_chacha20poly1305_ietf_encrypt_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      maclen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_encrypt_detached";

   function crypto_aead_chacha20poly1305_ietf_decrypt_detached
     (m : access unsigned_char;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      mac : access unsigned_char;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_decrypt_detached";

   procedure crypto_aead_chacha20poly1305_ietf_keygen (k : access unsigned_char)  -- ./sodium/crypto_aead_chacha20poly1305.h:89
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_ietf_keygen";

  -- -- Original ChaCha20-Poly1305 construction with a 64-bit nonce and a 64-bit internal counter --  
   function crypto_aead_chacha20poly1305_keybytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:96
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_keybytes";

   function crypto_aead_chacha20poly1305_nsecbytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:100
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_nsecbytes";

   function crypto_aead_chacha20poly1305_npubbytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_npubbytes";

   function crypto_aead_chacha20poly1305_abytes return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:108
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_abytes";

   function crypto_aead_chacha20poly1305_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_aead_chacha20poly1305.h:113
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_messagebytes_max";

   function crypto_aead_chacha20poly1305_encrypt
     (c : access unsigned_char;
      clen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:116
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_encrypt";

   function crypto_aead_chacha20poly1305_decrypt
     (m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:128
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_decrypt";

   function crypto_aead_chacha20poly1305_encrypt_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      maclen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      nsec : access unsigned_char;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:140
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_encrypt_detached";

   function crypto_aead_chacha20poly1305_decrypt_detached
     (m : access unsigned_char;
      nsec : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      mac : access unsigned_char;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      npub : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_aead_chacha20poly1305.h:153
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_decrypt_detached";

   procedure crypto_aead_chacha20poly1305_keygen (k : access unsigned_char)  -- ./sodium/crypto_aead_chacha20poly1305.h:165
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_aead_chacha20poly1305_keygen";

  -- Aliases  
end crypto_aead_chacha20poly1305_h;
