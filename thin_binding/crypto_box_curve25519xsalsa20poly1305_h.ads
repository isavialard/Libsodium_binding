pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_box_curve25519xsalsa20poly1305_h is

   crypto_box_curve25519xsalsa20poly1305_SEEDBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xsalsa20poly1305.h:15

   crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xsalsa20poly1305.h:19

   crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xsalsa20poly1305.h:23

   crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES : constant := 32;  --  ./sodium/crypto_box_curve25519xsalsa20poly1305.h:27

   crypto_box_curve25519xsalsa20poly1305_NONCEBYTES : constant := 24;  --  ./sodium/crypto_box_curve25519xsalsa20poly1305.h:31

   crypto_box_curve25519xsalsa20poly1305_MACBYTES : constant := 16;  --  ./sodium/crypto_box_curve25519xsalsa20poly1305.h:35
   --  unsupported macro: crypto_box_curve25519xsalsa20poly1305_MESSAGEBYTES_MAX (crypto_stream_xsalsa20_MESSAGEBYTES_MAX - crypto_box_curve25519xsalsa20poly1305_MACBYTES)

   crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES : constant := 16;  --  ./sodium/crypto_box_curve25519xsalsa20poly1305.h:64
   --  unsupported macro: crypto_box_curve25519xsalsa20poly1305_ZEROBYTES (crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES + crypto_box_curve25519xsalsa20poly1305_MACBYTES)

   function crypto_box_curve25519xsalsa20poly1305_seedbytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_seedbytes";

   function crypto_box_curve25519xsalsa20poly1305_publickeybytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_publickeybytes";

   function crypto_box_curve25519xsalsa20poly1305_secretkeybytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_secretkeybytes";

   function crypto_box_curve25519xsalsa20poly1305_beforenmbytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_beforenmbytes";

   function crypto_box_curve25519xsalsa20poly1305_noncebytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_noncebytes";

   function crypto_box_curve25519xsalsa20poly1305_macbytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_macbytes";

  -- Only for the libsodium API - The NaCl compatibility API would require BOXZEROBYTES extra bytes  
  -- Only for the libsodium API - The NaCl compatibility API would require BOXZEROBYTES extra bytes  
   function crypto_box_curve25519xsalsa20poly1305_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_messagebytes_max";

   function crypto_box_curve25519xsalsa20poly1305_seed_keypair
     (pk : access unsigned_char;
      sk : access unsigned_char;
      seed : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_seed_keypair";

   function crypto_box_curve25519xsalsa20poly1305_keypair (pk : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_keypair";

   function crypto_box_curve25519xsalsa20poly1305_beforenm
     (k : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_beforenm";

   function crypto_box_curve25519xsalsa20poly1305_boxzerobytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_boxzerobytes";

   function crypto_box_curve25519xsalsa20poly1305_zerobytes return stddef_h.size_t  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_zerobytes";

   function crypto_box_curve25519xsalsa20poly1305
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305";

   function crypto_box_curve25519xsalsa20poly1305_open
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      pk : access unsigned_char;
      sk : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_open";

   function crypto_box_curve25519xsalsa20poly1305_afternm
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_afternm";

   function crypto_box_curve25519xsalsa20poly1305_open_afternm
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_box_curve25519xsalsa20poly1305.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_box_curve25519xsalsa20poly1305_open_afternm";

end crypto_box_curve25519xsalsa20poly1305_h;
