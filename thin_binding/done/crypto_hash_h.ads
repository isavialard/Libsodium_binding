pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;
with Interfaces.C.Strings;

package crypto_hash_h is

   --  unsupported macro: crypto_hash_BYTES crypto_hash_sha512_BYTES
   crypto_hash_PRIMITIVE : aliased constant String := "sha512" & ASCII.NUL;  --  ./sodium/crypto_hash.h:31

  -- * WARNING: Unless you absolutely need to use SHA512 for interoperatibility,
  -- * purposes, you might want to consider crypto_generichash() instead.
  -- * Unlike SHA512, crypto_generichash() is not vulnerable to length
  -- * extension attacks.
  --  

   function crypto_hash_bytes return stddef_h.size_t  -- ./sodium/crypto_hash.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_bytes";

   function crypto_hash
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_hash.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash";

   function crypto_hash_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_hash.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_hash_primitive";

end crypto_hash_h;
