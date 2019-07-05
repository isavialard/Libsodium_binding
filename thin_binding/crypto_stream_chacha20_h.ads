pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package crypto_stream_chacha20_h is

   crypto_stream_chacha20_KEYBYTES : constant := 32;  --  ./sodium/crypto_stream_chacha20.h:23

   crypto_stream_chacha20_NONCEBYTES : constant := 8;  --  ./sodium/crypto_stream_chacha20.h:27
   --  unsupported macro: crypto_stream_chacha20_MESSAGEBYTES_MAX SODIUM_SIZE_MAX

   crypto_stream_chacha20_ietf_KEYBYTES : constant := 32;  --  ./sodium/crypto_stream_chacha20.h:61

   crypto_stream_chacha20_ietf_NONCEBYTES : constant := 12;  --  ./sodium/crypto_stream_chacha20.h:65
   --  unsupported macro: crypto_stream_chacha20_ietf_MESSAGEBYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX, 64ULL * (1ULL << 32))
   --  unsupported macro: crypto_stream_chacha20_IETF_KEYBYTES crypto_stream_chacha20_ietf_KEYBYTES
   --  unsupported macro: crypto_stream_chacha20_IETF_NONCEBYTES crypto_stream_chacha20_ietf_NONCEBYTES
   --  unsupported macro: crypto_stream_chacha20_IETF_MESSAGEBYTES_MAX crypto_stream_chacha20_ietf_MESSAGEBYTES_MAX

  -- *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
  -- *  While it provides some protection against eavesdropping, it does NOT
  -- *  provide any security against active attacks.
  -- *  Unless you know what you're doing, what you are looking for is probably
  -- *  the crypto_box functions.
  --  

   function crypto_stream_chacha20_keybytes return stddef_h.size_t  -- ./sodium/crypto_stream_chacha20.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_keybytes";

   function crypto_stream_chacha20_noncebytes return stddef_h.size_t  -- ./sodium/crypto_stream_chacha20.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_noncebytes";

   function crypto_stream_chacha20_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_stream_chacha20.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_messagebytes_max";

  -- ChaCha20 with a 64-bit nonce and a 64-bit counter, as originally designed  
   function crypto_stream_chacha20
     (c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_chacha20.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20";

   function crypto_stream_chacha20_xor
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_chacha20.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_xor";

   function crypto_stream_chacha20_xor_ic
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      ic : x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_chacha20.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_xor_ic";

   procedure crypto_stream_chacha20_keygen (k : access unsigned_char)  -- ./sodium/crypto_stream_chacha20.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_keygen";

  -- ChaCha20 with a 96-bit nonce and a 32-bit counter (IETF)  
  -- *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
  -- *  While it provides some protection against eavesdropping, it does NOT
  -- *  provide any security against active attacks.
  -- *  Unless you know what you're doing, what you are looking for is probably
  -- *  the crypto_box functions.
  --  

   function crypto_stream_chacha20_ietf_keybytes return stddef_h.size_t  -- ./sodium/crypto_stream_chacha20.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_ietf_keybytes";

   function crypto_stream_chacha20_ietf_noncebytes return stddef_h.size_t  -- ./sodium/crypto_stream_chacha20.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_ietf_noncebytes";

   function crypto_stream_chacha20_ietf_messagebytes_max return stddef_h.size_t  -- ./sodium/crypto_stream_chacha20.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_ietf_messagebytes_max";

   function crypto_stream_chacha20_ietf
     (c : access unsigned_char;
      clen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_chacha20.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_ietf";

   function crypto_stream_chacha20_ietf_xor
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_chacha20.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_ietf_xor";

   function crypto_stream_chacha20_ietf_xor_ic
     (c : access unsigned_char;
      m : access unsigned_char;
      mlen : Extensions.unsigned_long_long;
      n : access unsigned_char;
      ic : x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t;
      k : access unsigned_char) return int  -- ./sodium/crypto_stream_chacha20.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_ietf_xor_ic";

   procedure crypto_stream_chacha20_ietf_keygen (k : access unsigned_char)  -- ./sodium/crypto_stream_chacha20.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_stream_chacha20_ietf_keygen";

end crypto_stream_chacha20_h;
