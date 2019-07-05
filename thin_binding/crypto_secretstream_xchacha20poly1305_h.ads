pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_secretstream_xchacha20poly1305_h is

   --  unsupported macro: crypto_secretstream_xchacha20poly1305_ABYTES (1U + crypto_aead_xchacha20poly1305_ietf_ABYTES)
   --  unsupported macro: crypto_secretstream_xchacha20poly1305_HEADERBYTES crypto_aead_xchacha20poly1305_ietf_NPUBBYTES
   --  unsupported macro: crypto_secretstream_xchacha20poly1305_KEYBYTES crypto_aead_xchacha20poly1305_ietf_KEYBYTES
   --  unsupported macro: crypto_secretstream_xchacha20poly1305_MESSAGEBYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX - crypto_secretstream_xchacha20poly1305_ABYTES, (64ULL * ((1ULL << 32) - 2ULL)))
   crypto_secretstream_xchacha20poly1305_TAG_MESSAGE : constant := 16#00#;  --  ./sodium/crypto_secretstream_xchacha20poly1305.h:38

   crypto_secretstream_xchacha20poly1305_TAG_PUSH : constant := 16#01#;  --  ./sodium/crypto_secretstream_xchacha20poly1305.h:42

   crypto_secretstream_xchacha20poly1305_TAG_REKEY : constant := 16#02#;  --  ./sodium/crypto_secretstream_xchacha20poly1305.h:46
   --  unsupported macro: crypto_secretstream_xchacha20poly1305_TAG_FINAL (crypto_secretstream_xchacha20poly1305_TAG_PUSH | crypto_secretstream_xchacha20poly1305_TAG_REKEY)

   function crypto_secretstream_xchacha20poly1305_abytes return stddef_h.size_t  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:20
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_abytes";

   function crypto_secretstream_xchacha20poly1305_headerbytes return stddef_h.size_t  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_headerbytes";

   function crypto_secretstream_xchacha20poly1305_keybytes return stddef_h.size_t  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_keybytes";

   function crypto_secretstream_xchacha20poly1305_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_messagebytes_max";

   function crypto_secretstream_xchacha20poly1305_tag_message return unsigned_char  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_tag_message";

   function crypto_secretstream_xchacha20poly1305_tag_push return unsigned_char  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_tag_push";

   function crypto_secretstream_xchacha20poly1305_tag_rekey return unsigned_char  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_tag_rekey";

   function crypto_secretstream_xchacha20poly1305_tag_final return unsigned_char  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_tag_final";

   type anon1563_k_array is array (0 .. 31) of aliased unsigned_char;
   type anon1563_nonce_array is array (0 .. 11) of aliased unsigned_char;
   type anon1563_u_pad_array is array (0 .. 7) of aliased unsigned_char;
   type crypto_secretstream_xchacha20poly1305_state is record
      k : aliased anon1563_k_array;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:57
      nonce : aliased anon1563_nonce_array;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:58
      u_pad : aliased anon1563_u_pad_array;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:59
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:56

   function crypto_secretstream_xchacha20poly1305_statebytes return stddef_h.size_t  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_statebytes";

   procedure crypto_secretstream_xchacha20poly1305_keygen (k : access unsigned_char)  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_keygen";

   function crypto_secretstream_xchacha20poly1305_init_push
     (state : access crypto_secretstream_xchacha20poly1305_state;
      header : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_init_push";

   function crypto_secretstream_xchacha20poly1305_push
     (state : access crypto_secretstream_xchacha20poly1305_state;
      c : access unsigned_char;
      clen_p : access Extensions.unsigned_long_long;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long;
      tag : unsigned_char) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_push";

   function crypto_secretstream_xchacha20poly1305_init_pull
     (state : access crypto_secretstream_xchacha20poly1305_state;
      header : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_init_pull";

   function crypto_secretstream_xchacha20poly1305_pull
     (state : access crypto_secretstream_xchacha20poly1305_state;
      m : access unsigned_char;
      mlen_p : access Extensions.unsigned_long_long;
      tag_p : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      ad : access unsigned_char;
      adlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_pull";

   procedure crypto_secretstream_xchacha20poly1305_rekey (state : access crypto_secretstream_xchacha20poly1305_state)  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretstream_xchacha20poly1305_rekey";

end crypto_secretstream_xchacha20poly1305_h;
