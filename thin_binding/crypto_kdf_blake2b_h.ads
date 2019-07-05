pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with Interfaces.C.Strings;

package crypto_kdf_blake2b_h is

   crypto_kdf_blake2b_BYTES_MIN : constant := 16;  --  ./sodium/crypto_kdf_blake2b.h:17

   crypto_kdf_blake2b_BYTES_MAX : constant := 64;  --  ./sodium/crypto_kdf_blake2b.h:21

   crypto_kdf_blake2b_CONTEXTBYTES : constant := 8;  --  ./sodium/crypto_kdf_blake2b.h:25

   crypto_kdf_blake2b_KEYBYTES : constant := 32;  --  ./sodium/crypto_kdf_blake2b.h:29

   function crypto_kdf_blake2b_bytes_min return stddef_h.size_t  -- ./sodium/crypto_kdf_blake2b.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_blake2b_bytes_min";

   function crypto_kdf_blake2b_bytes_max return stddef_h.size_t  -- ./sodium/crypto_kdf_blake2b.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_blake2b_bytes_max";

   function crypto_kdf_blake2b_contextbytes return stddef_h.size_t  -- ./sodium/crypto_kdf_blake2b.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_blake2b_contextbytes";

   function crypto_kdf_blake2b_keybytes return stddef_h.size_t  -- ./sodium/crypto_kdf_blake2b.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_blake2b_keybytes";

   function crypto_kdf_blake2b_derive_from_key
     (subkey : access unsigned_char;
      subkey_len : stddef_h.size_t;
      subkey_id : x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;
      ctx : Interfaces.C.Strings.chars_ptr;
      key : access unsigned_char) return int  -- ./sodium/crypto_kdf_blake2b.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kdf_blake2b_derive_from_key";

end crypto_kdf_blake2b_h;
