pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_stream_salsa208_h is

   crypto_stream_salsa208_KEYBYTES : constant := 32;  --  ./sodium/crypto_stream_salsa208.h:22

   crypto_stream_salsa208_NONCEBYTES : constant := 8;  --  ./sodium/crypto_stream_salsa208.h:27
   --  unsupported macro: crypto_stream_salsa208_MESSAGEBYTES_MAX SODIUM_SIZE_MAX

  -- *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
  -- *  While it provides some protection against eavesdropping, it does NOT
  -- *  provide any security against active attacks.
  -- *  Unless you know what you're doing, what you are looking for is probably
  -- *  the crypto_box functions.
  --  

   function crypto_stream_salsa208_keybytes return stddef_h.size_t  -- ./sodium/crypto_stream_salsa208.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_salsa208_keybytes";

   function crypto_stream_salsa208_noncebytes return stddef_h.size_t  -- ./sodium/crypto_stream_salsa208.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_salsa208_noncebytes";

   function crypto_stream_salsa208_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_stream_salsa208.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_salsa208_messagebytes_max";

   function crypto_stream_salsa208
     (c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_salsa208.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_salsa208";

   function crypto_stream_salsa208_xor
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_salsa208.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_salsa208_xor";

   procedure crypto_stream_salsa208_keygen (k : access unsigned_char)  -- ./sodium/crypto_stream_salsa208.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_salsa208_keygen";

end crypto_stream_salsa208_h;
