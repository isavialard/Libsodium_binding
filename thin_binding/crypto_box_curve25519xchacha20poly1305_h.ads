pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_box_curve25519xchacha20poly1305_h is

   crypto_box_curve25519xchacha20poly1305_SEEDBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xchacha20poly1305.h:16

   crypto_box_curve25519xchacha20poly1305_PUBLICKEYBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xchacha20poly1305.h:20

   crypto_box_curve25519xchacha20poly1305_SECRETKEYBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xchacha20poly1305.h:24

   crypto_box_curve25519xchacha20poly1305_BEFORENMBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xchacha20poly1305.h:28

   crypto_box_curve25519xchacha20poly1305_NONCEBYTES : constant := 24;  --  ./sodium/crypto_box_curve25519xchacha20poly1305.h:32

   crypto_box_curve25519xchacha20poly1305_MACBYTES : constant := 16;  --  ./sodium/crypto_box_curve25519xchacha20poly1305.h:36
   --  unsupported macro: crypto_box_curve25519xchacha20poly1305_MESSAGEBYTES_MAX (crypto_stream_xchacha20_MESSAGEBYTES_MAX - crypto_box_curve25519xchacha20poly1305_MACBYTES)
   --  unsupported macro: crypto_box_curve25519xchacha20poly1305_SEALBYTES (crypto_box_curve25519xchacha20poly1305_PUBLICKEYBYTES + crypto_box_curve25519xchacha20poly1305_MACBYTES)

   function crypto_box_curve25519xchacha20poly1305_seedbytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_seedbytes";

   function crypto_box_curve25519xchacha20poly1305_publickeybytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_publickeybytes";

   function crypto_box_curve25519xchacha20poly1305_secretkeybytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_secretkeybytes";

   function crypto_box_curve25519xchacha20poly1305_beforenmbytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_beforenmbytes";

   function crypto_box_curve25519xchacha20poly1305_noncebytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_noncebytes";

   function crypto_box_curve25519xchacha20poly1305_macbytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_macbytes";

   function crypto_box_curve25519xchacha20poly1305_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_messagebytes_max";

   function crypto_box_curve25519xchacha20poly1305_seed_keypair
     (pk : access unsigned_char;
      sk : access unsigned_char;
      seed : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_seed_keypair";

   function crypto_box_curve25519xchacha20poly1305_keypair (pk : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_keypair";

   function crypto_box_curve25519xchacha20poly1305_easy
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_easy";

   function crypto_box_curve25519xchacha20poly1305_open_easy
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_open_easy";

   function crypto_box_curve25519xchacha20poly1305_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_detached";

   function crypto_box_curve25519xchacha20poly1305_open_detached
     (m : access unsigned_char;
      c : access unsigned_char;
      mac : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_open_detached";

  -- -- Precomputation interface --  
   function crypto_box_curve25519xchacha20poly1305_beforenm
     (k : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:97
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_beforenm";

   function crypto_box_curve25519xchacha20poly1305_easy_afternm
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:103
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_easy_afternm";

   function crypto_box_curve25519xchacha20poly1305_open_easy_afternm
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_open_easy_afternm";

   function crypto_box_curve25519xchacha20poly1305_detached_afternm
     (c : access unsigned_char;
      mac : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:119
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_detached_afternm";

   function crypto_box_curve25519xchacha20poly1305_open_detached_afternm
     (m : access unsigned_char;
      c : access unsigned_char;
      mac : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:128
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_open_detached_afternm";

  -- -- Ephemeral SK interface --  
   function crypto_box_curve25519xchacha20poly1305_sealbytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:143
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_sealbytes";

   function crypto_box_curve25519xchacha20poly1305_seal
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      pk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:146
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_seal";

   function crypto_box_curve25519xchacha20poly1305_seal_open
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xchacha20poly1305.h:153
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xchacha20poly1305_seal_open";

end crypto_box_curve25519xchacha20poly1305_h;
