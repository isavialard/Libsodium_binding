pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_hash_sha512_h is

   crypto_hash_sha512_BYTES : constant := 64;  --  ./sodium/crypto_hash_sha512.h:33

  -- * WARNING: Unless you absolutely need to use SHA512 for interoperatibility,
  -- * purposes, you might want to consider crypto_generichash() instead.
  -- * Unlike SHA512, crypto_generichash() is not vulnerable to length
  -- * extension attacks.
  --  

   type anon1186_state_array is array (0 .. 7) of aliased x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;
   type anon1186_count_array is array (0 .. 1) of aliased x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;
   type anon1186_buf_array is array (0 .. 127) of aliased x86_64_linux_gnu_bits_stdint_uintn_h.uint8_t;
   type crypto_hash_sha512_state is record
      state : aliased anon1186_state_array;  -- ./sodium/crypto_hash_sha512.h:25
      count : aliased anon1186_count_array;  -- ./sodium/crypto_hash_sha512.h:26
      buf : aliased anon1186_buf_array;  -- ./sodium/crypto_hash_sha512.h:27
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_hash_sha512.h:24

   function crypto_hash_sha512_statebytes return stddef_h.size_t  -- ./sodium/crypto_hash_sha512.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_sha512_statebytes";

   function crypto_hash_sha512_bytes return stddef_h.size_t  -- ./sodium/crypto_hash_sha512.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_sha512_bytes";

   function crypto_hash_sha512
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_hash_sha512.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_sha512";

   function crypto_hash_sha512_init (state : access crypto_hash_sha512_state) return int  -- ./sodium/crypto_hash_sha512.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_sha512_init";

   function crypto_hash_sha512_update
     (state : access crypto_hash_sha512_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_hash_sha512.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_sha512_update";

   function crypto_hash_sha512_final (state : access crypto_hash_sha512_state; c_out : access unsigned_char) return int  -- ./sodium/crypto_hash_sha512.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_sha512_final";

end crypto_hash_sha512_h;
