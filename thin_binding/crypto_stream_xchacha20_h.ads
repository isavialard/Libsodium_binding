pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package crypto_stream_xchacha20_h is

   crypto_stream_xchacha20_KEYBYTES : constant := 32;  --  ./sodium/crypto_stream_xchacha20.h:23

   crypto_stream_xchacha20_NONCEBYTES : constant := 24;  --  ./sodium/crypto_stream_xchacha20.h:27
   --  unsupported macro: crypto_stream_xchacha20_MESSAGEBYTES_MAX SODIUM_SIZE_MAX

  -- *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
  -- *  While it provides some protection against eavesdropping, it does NOT
  -- *  provide any security against active attacks.
  -- *  Unless you know what you're doing, what you are looking for is probably
  -- *  the crypto_box functions.
  --  

   function crypto_stream_xchacha20_keybytes return stddef_h.size_t  -- ./sodium/crypto_stream_xchacha20.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xchacha20_keybytes";

   function crypto_stream_xchacha20_noncebytes return stddef_h.size_t  -- ./sodium/crypto_stream_xchacha20.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xchacha20_noncebytes";

   function crypto_stream_xchacha20_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_stream_xchacha20.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xchacha20_messagebytes_max";

   function crypto_stream_xchacha20
     (c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_xchacha20.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xchacha20";

   function crypto_stream_xchacha20_xor
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_xchacha20.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xchacha20_xor";

   function crypto_stream_xchacha20_xor_ic
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      ic : x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_xchacha20.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xchacha20_xor_ic";

   procedure crypto_stream_xchacha20_keygen (k : access unsigned_char)  -- ./sodium/crypto_stream_xchacha20.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_xchacha20_keygen";

end crypto_stream_xchacha20_h;
