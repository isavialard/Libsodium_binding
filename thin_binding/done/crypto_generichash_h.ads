pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with crypto_generichash_blake2b_h;
with Interfaces.C.Extensions;

package crypto_generichash_h is

   --  unsupported macro: crypto_generichash_BYTES_MIN crypto_generichash_blake2b_BYTES_MIN
   --  unsupported macro: crypto_generichash_BYTES_MAX crypto_generichash_blake2b_BYTES_MAX
   --  unsupported macro: crypto_generichash_BYTES crypto_generichash_blake2b_BYTES
   --  unsupported macro: crypto_generichash_KEYBYTES_MIN crypto_generichash_blake2b_KEYBYTES_MIN
   --  unsupported macro: crypto_generichash_KEYBYTES_MAX crypto_generichash_blake2b_KEYBYTES_MAX
   --  unsupported macro: crypto_generichash_KEYBYTES crypto_generichash_blake2b_KEYBYTES
   crypto_generichash_PRIMITIVE : aliased constant String := "blake2b" & ASCII.NUL;  --  ./sodium/crypto_generichash.h:40

   function crypto_generichash_bytes_min return stddef_h.size_t  -- ./sodium/crypto_generichash.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_bytes_min";

   function crypto_generichash_bytes_max return stddef_h.size_t  -- ./sodium/crypto_generichash.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_bytes_max";

   function crypto_generichash_bytes return stddef_h.size_t  -- ./sodium/crypto_generichash.h:26
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_bytes";

   function crypto_generichash_keybytes_min return stddef_h.size_t  -- ./sodium/crypto_generichash.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_keybytes_min";

   function crypto_generichash_keybytes_max return stddef_h.size_t  -- ./sodium/crypto_generichash.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_keybytes_max";

   function crypto_generichash_keybytes return stddef_h.size_t  -- ./sodium/crypto_generichash.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_keybytes";

   function crypto_generichash_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_generichash.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_primitive";

  -- * Important when writing bindings for other programming languages:
  -- * the state address should be 64-bytes aligned.
  --  

   subtype crypto_generichash_state is crypto_generichash_blake2b_h.crypto_generichash_blake2b_state;  -- ./sodium/crypto_generichash.h:48

   function crypto_generichash_statebytes return stddef_h.size_t  -- ./sodium/crypto_generichash.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_statebytes";

   function crypto_generichash
     (c_out : access unsigned_char;
      outlen : stddef_h.size_t;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      key : access unsigned_char;
      keylen : stddef_h.size_t) return int  -- ./sodium/crypto_generichash.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash";

   function crypto_generichash_init
     (state : access crypto_generichash_state;
      key : access unsigned_char;
      keylen : stddef_h.size_t;
      outlen : stddef_h.size_t) return int  -- ./sodium/crypto_generichash.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_init";

   function crypto_generichash_update
     (state : access crypto_generichash_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_generichash.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_update";

   function crypto_generichash_final
     (state : access crypto_generichash_state;
      c_out : access unsigned_char;
      outlen : stddef_h.size_t) return int  -- ./sodium/crypto_generichash.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_final";

   procedure crypto_generichash_keygen (k : access unsigned_char)  -- ./sodium/crypto_generichash.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_keygen";

end crypto_generichash_h;
