pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_secretbox_xsalsa20poly1305_h is

   crypto_secretbox_xsalsa20poly1305_KEYBYTES : constant := 32;  --  ./sodium/crypto_secretbox_xsalsa20poly1305.h:15

   crypto_secretbox_xsalsa20poly1305_NONCEBYTES : constant := 24;  --  ./sodium/crypto_secretbox_xsalsa20poly1305.h:19

   crypto_secretbox_xsalsa20poly1305_MACBYTES : constant := 16;  --  ./sodium/crypto_secretbox_xsalsa20poly1305.h:23
   --  unsupported macro: crypto_secretbox_xsalsa20poly1305_MESSAGEBYTES_MAX (crypto_stream_xsalsa20_MESSAGEBYTES_MAX - crypto_secretbox_xsalsa20poly1305_MACBYTES)

   crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES : constant := 16;  --  ./sodium/crypto_secretbox_xsalsa20poly1305.h:55
   --  unsupported macro: crypto_secretbox_xsalsa20poly1305_ZEROBYTES (crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES + crypto_secretbox_xsalsa20poly1305_MACBYTES)

   function crypto_secretbox_xsalsa20poly1305_keybytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_keybytes";

   function crypto_secretbox_xsalsa20poly1305_noncebytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_noncebytes";

   function crypto_secretbox_xsalsa20poly1305_macbytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_macbytes";

  -- Only for the libsodium API - The NaCl compatibility API would require BOXZEROBYTES extra bytes  
  -- Only for the libsodium API - The NaCl compatibility API would require BOXZEROBYTES extra bytes  
   function crypto_secretbox_xsalsa20poly1305_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_messagebytes_max";

   function crypto_secretbox_xsalsa20poly1305
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305";

   function crypto_secretbox_xsalsa20poly1305_open
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_open";

   procedure crypto_secretbox_xsalsa20poly1305_keygen (k : access unsigned_char)  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_keygen";

   function crypto_secretbox_xsalsa20poly1305_boxzerobytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_boxzerobytes";

   function crypto_secretbox_xsalsa20poly1305_zerobytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xsalsa20poly1305.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xsalsa20poly1305_zerobytes";

end crypto_secretbox_xsalsa20poly1305_h;
