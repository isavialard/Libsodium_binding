pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_box_h is

   --  unsupported macro: crypto_box_SEEDBYTES crypto_box_curve25519xsalsa20poly1305_SEEDBYTES
   --  unsupported macro: crypto_box_PUBLICKEYBYTES crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES
   --  unsupported macro: crypto_box_SECRETKEYBYTES crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES
   --  unsupported macro: crypto_box_NONCEBYTES crypto_box_curve25519xsalsa20poly1305_NONCEBYTES
   --  unsupported macro: crypto_box_MACBYTES crypto_box_curve25519xsalsa20poly1305_MACBYTES
   --  unsupported macro: crypto_box_MESSAGEBYTES_MAX crypto_box_curve25519xsalsa20poly1305_MESSAGEBYTES_MAX
   crypto_box_PRIMITIVE : aliased constant String := "curve25519xsalsa20poly1305" & ASCII.NUL;  --  ./sodium/crypto_box.h:47
   --  unsupported macro: crypto_box_BEFORENMBYTES crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES
   --  unsupported macro: crypto_box_SEALBYTES (crypto_box_PUBLICKEYBYTES + crypto_box_MACBYTES)
   --  unsupported macro: crypto_box_ZEROBYTES crypto_box_curve25519xsalsa20poly1305_ZEROBYTES
   --  unsupported macro: crypto_box_BOXZEROBYTES crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES

  -- * THREAD SAFETY: crypto_box_keypair() is thread-safe,
  -- * provided that sodium_init() was called before.
  -- *
  -- * Other functions are always thread-safe.
  --  

   function crypto_box_seedbytes return stddef_h.size_t  -- ./sodium/crypto_box.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_seedbytes";

   function crypto_box_publickeybytes return stddef_h.size_t  -- ./sodium/crypto_box.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_publickeybytes";

   function crypto_box_secretkeybytes return stddef_h.size_t  -- ./sodium/crypto_box.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_secretkeybytes";

   function crypto_box_noncebytes return stddef_h.size_t  -- ./sodium/crypto_box.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_noncebytes";

   function crypto_box_macbytes return stddef_h.size_t  -- ./sodium/crypto_box.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_macbytes";

   function crypto_box_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_box.h:45
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_messagebytes_max";

   function crypto_box_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_box.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_primitive";

   function crypto_box_seed_keypair
     (pk : access unsigned_char;
      sk : access unsigned_char;
      seed : access unsigned_char) return int  -- ./sodium/crypto_box.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_seed_keypair";

   function crypto_box_keypair (pk : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_keypair";

   function crypto_box_easy
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_easy";

   function crypto_box_open_easy
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_open_easy";

   function crypto_box_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_detached";

   function crypto_box_open_detached
     (m : access unsigned_char;
      c : access unsigned_char;
      mac : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_open_detached";

  -- -- Precomputation interface --  
   function crypto_box_beforenmbytes return stddef_h.size_t  -- ./sodium/crypto_box.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_beforenmbytes";

   function crypto_box_beforenm
     (k : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_beforenm";

   function crypto_box_easy_afternm
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box.h:100
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_easy_afternm";

   function crypto_box_open_easy_afternm
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box.h:105
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_open_easy_afternm";

   function crypto_box_detached_afternm
     (c : access unsigned_char;
      mac : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_detached_afternm";

   function crypto_box_open_detached_afternm
     (m : access unsigned_char;
      c : access unsigned_char;
      mac : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box.h:117
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_open_detached_afternm";

  -- -- Ephemeral SK interface --  
   function crypto_box_sealbytes return stddef_h.size_t  -- ./sodium/crypto_box.h:127
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_sealbytes";

   function crypto_box_seal
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      pk : access unsigned_char) return int  -- ./sodium/crypto_box.h:130
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_seal";

   function crypto_box_seal_open
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:135
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_seal_open";

  -- -- NaCl compatibility interface ; Requires padding --  
   function crypto_box_zerobytes return stddef_h.size_t  -- ./sodium/crypto_box.h:144
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_zerobytes";

   function crypto_box_boxzerobytes return stddef_h.size_t  -- ./sodium/crypto_box.h:148
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_boxzerobytes";

   function crypto_box
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:151
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box";

   function crypto_box_open
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box.h:157
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_open";

   function crypto_box_afternm
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box.h:163
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_afternm";

   function crypto_box_open_afternm
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box.h:168
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_open_afternm";

end crypto_box_h;
