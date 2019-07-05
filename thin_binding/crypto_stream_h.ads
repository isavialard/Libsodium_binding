pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_stream_h is

   --  unsupported macro: crypto_stream_KEYBYTES crypto_stream_xsalsa20_KEYBYTES
   --  unsupported macro: crypto_stream_NONCEBYTES crypto_stream_xsalsa20_NONCEBYTES
   --  unsupported macro: crypto_stream_MESSAGEBYTES_MAX crypto_stream_xsalsa20_MESSAGEBYTES_MAX
   crypto_stream_PRIMITIVE : aliased constant String := "xsalsa20" & ASCII.NUL;  --  ./sodium/crypto_stream.h:36

  -- *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
  -- *  While it provides some protection against eavesdropping, it does NOT
  -- *  provide any security against active attacks.
  -- *  Unless you know what you're doing, what you are looking for is probably
  -- *  the crypto_box functions.
  --  

   function crypto_stream_keybytes return stddef_h.size_t  -- ./sodium/crypto_stream.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_keybytes";

   function crypto_stream_noncebytes return stddef_h.size_t  -- ./sodium/crypto_stream.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_noncebytes";

   function crypto_stream_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_stream.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_messagebytes_max";

   function crypto_stream_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_stream.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_primitive";

   function crypto_stream
     (c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream";

   function crypto_stream_xor
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xor";

   procedure crypto_stream_keygen (k : access unsigned_char)  -- ./sodium/crypto_stream.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_keygen";

end crypto_stream_h;
