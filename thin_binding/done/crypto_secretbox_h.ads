pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_secretbox_h is

   --  unsupported macro: crypto_secretbox_KEYBYTES crypto_secretbox_xsalsa20poly1305_KEYBYTES
   --  unsupported macro: crypto_secretbox_NONCEBYTES crypto_secretbox_xsalsa20poly1305_NONCEBYTES
   --  unsupported macro: crypto_secretbox_MACBYTES crypto_secretbox_xsalsa20poly1305_MACBYTES
   crypto_secretbox_PRIMITIVE : aliased constant String := "xsalsa20poly1305" & ASCII.NUL;  --  ./sodium/crypto_secretbox.h:28
   --  unsupported macro: crypto_secretbox_MESSAGEBYTES_MAX crypto_secretbox_xsalsa20poly1305_MESSAGEBYTES_MAX
   --  unsupported macro: crypto_secretbox_ZEROBYTES crypto_secretbox_xsalsa20poly1305_ZEROBYTES
   --  unsupported macro: crypto_secretbox_BOXZEROBYTES crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES

   function crypto_secretbox_keybytes return stddef_h.size_t  -- ./sodium/crypto_secretbox.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_keybytes";

   function crypto_secretbox_noncebytes return stddef_h.size_t  -- ./sodium/crypto_secretbox.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_noncebytes";

   function crypto_secretbox_macbytes return stddef_h.size_t  -- ./sodium/crypto_secretbox.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_macbytes";

   function crypto_secretbox_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_secretbox.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_primitive";

   function crypto_secretbox_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_secretbox.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_messagebytes_max";

   function crypto_secretbox_easy
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_easy";

   function crypto_secretbox_open_easy
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_open_easy";

   function crypto_secretbox_detached
     (c : access unsigned_char;
      mac : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_detached";

   function crypto_secretbox_open_detached
     (m : access unsigned_char;
      c : access unsigned_char;
      mac : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_open_detached";

   procedure crypto_secretbox_keygen (k : access unsigned_char)  -- ./sodium/crypto_secretbox.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_keygen";

  -- -- NaCl compatibility interface ; Requires padding --  
   function crypto_secretbox_zerobytes return stddef_h.size_t  -- ./sodium/crypto_secretbox.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_zerobytes";

   function crypto_secretbox_boxzerobytes return stddef_h.size_t  -- ./sodium/crypto_secretbox.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_boxzerobytes";

   function crypto_secretbox
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox";

   function crypto_secretbox_open
     (m : access unsigned_char;
      c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_secretbox.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_secretbox_open";

end crypto_secretbox_h;
