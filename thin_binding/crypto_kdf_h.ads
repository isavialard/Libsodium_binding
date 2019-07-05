pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package crypto_kdf_h is

   --  unsupported macro: crypto_kdf_BYTES_MIN crypto_kdf_blake2b_BYTES_MIN
   --  unsupported macro: crypto_kdf_BYTES_MAX crypto_kdf_blake2b_BYTES_MAX
   --  unsupported macro: crypto_kdf_CONTEXTBYTES crypto_kdf_blake2b_CONTEXTBYTES
   --  unsupported macro: crypto_kdf_KEYBYTES crypto_kdf_blake2b_KEYBYTES
   crypto_kdf_PRIMITIVE : aliased constant String := "blake2b" & ASCII.NUL;  --  ./sodium/crypto_kdf.h:33

   function crypto_kdf_bytes_min return stddef_h.size_t  -- ./sodium/crypto_kdf.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_bytes_min";

   function crypto_kdf_bytes_max return stddef_h.size_t  -- ./sodium/crypto_kdf.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_bytes_max";

   function crypto_kdf_contextbytes return stddef_h.size_t  -- ./sodium/crypto_kdf.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_contextbytes";

   function crypto_kdf_keybytes return stddef_h.size_t  -- ./sodium/crypto_kdf.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_keybytes";

   function crypto_kdf_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_kdf.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_primitive";

   function crypto_kdf_derive_from_key
     (subkey : access unsigned_char;
      subkey_len : stddef_h.size_t;
      subkey_id : x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;
      ctx : Interfaces.C.Strings.chars_ptr;
      key : access unsigned_char) return int  -- ./sodium/crypto_kdf.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_derive_from_key";

   procedure crypto_kdf_keygen (k : access unsigned_char)  -- ./sodium/crypto_kdf.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_keygen";

end crypto_kdf_h;
