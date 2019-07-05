pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_secretbox_xchacha20poly1305_h is

   crypto_secretbox_xchacha20poly1305_KEYBYTES : constant := 32;  --  ./sodium/crypto_secretbox_xchacha20poly1305.h:15

   crypto_secretbox_xchacha20poly1305_NONCEBYTES : constant := 24;  --  ./sodium/crypto_secretbox_xchacha20poly1305.h:19

   crypto_secretbox_xchacha20poly1305_MACBYTES : constant := 16;  --  ./sodium/crypto_secretbox_xchacha20poly1305.h:23
   --  unsupported macro: crypto_secretbox_xchacha20poly1305_MESSAGEBYTES_MAX (crypto_stream_xchacha20_MESSAGEBYTES_MAX - crypto_secretbox_xchacha20poly1305_MACBYTES)

   function crypto_secretbox_xchacha20poly1305_keybytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_keybytes";

   function crypto_secretbox_xchacha20poly1305_noncebytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_noncebytes";

   function crypto_secretbox_xchacha20poly1305_macbytes return stddef_h.size_t  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_macbytes";

   function crypto_secretbox_xchacha20poly1305_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_messagebytes_max";

   function crypto_secretbox_xchacha20poly1305_easy
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_easy";

   function crypto_secretbox_xchacha20poly1305_open_easy
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_open_easy";

   function crypto_secretbox_xchacha20poly1305_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_detached";

   function crypto_secretbox_xchacha20poly1305_open_detached
     (m : access unsigned_char;
      c : access unsigned_char;
      mac : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox_xchacha20poly1305.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_xchacha20poly1305_open_detached";

end crypto_secretbox_xchacha20poly1305_h;
