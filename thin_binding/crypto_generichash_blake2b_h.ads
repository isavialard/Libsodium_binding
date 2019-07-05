pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_generichash_blake2b_h is

   crypto_generichash_blake2b_BYTES_MIN : constant := 16;  --  ./sodium/crypto_generichash_blake2b.h:33

   crypto_generichash_blake2b_BYTES_MAX : constant := 64;  --  ./sodium/crypto_generichash_blake2b.h:37

   crypto_generichash_blake2b_BYTES : constant := 32;  --  ./sodium/crypto_generichash_blake2b.h:41

   crypto_generichash_blake2b_KEYBYTES_MIN : constant := 16;  --  ./sodium/crypto_generichash_blake2b.h:45

   crypto_generichash_blake2b_KEYBYTES_MAX : constant := 64;  --  ./sodium/crypto_generichash_blake2b.h:49

   crypto_generichash_blake2b_KEYBYTES : constant := 32;  --  ./sodium/crypto_generichash_blake2b.h:53

   crypto_generichash_blake2b_SALTBYTES : constant := 16;  --  ./sodium/crypto_generichash_blake2b.h:57

   crypto_generichash_blake2b_PERSONALBYTES : constant := 16;  --  ./sodium/crypto_generichash_blake2b.h:61

   type anon1299_opaque_array is array (0 .. 383) of aliased unsigned_char;
   type crypto_generichash_blake2b_state is record
      opaque : aliased anon1299_opaque_array;  -- ./sodium/crypto_generichash_blake2b.h:24
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_generichash_blake2b.h:23

   function crypto_generichash_blake2b_bytes_min return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_bytes_min";

   function crypto_generichash_blake2b_bytes_max return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_bytes_max";

   function crypto_generichash_blake2b_bytes return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_bytes";

   function crypto_generichash_blake2b_keybytes_min return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_keybytes_min";

   function crypto_generichash_blake2b_keybytes_max return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_keybytes_max";

   function crypto_generichash_blake2b_keybytes return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_keybytes";

   function crypto_generichash_blake2b_saltbytes return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_saltbytes";

   function crypto_generichash_blake2b_personalbytes return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_personalbytes";

   function crypto_generichash_blake2b_statebytes return stddef_h.size_t  -- ./sodium/crypto_generichash_blake2b.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_statebytes";

   function crypto_generichash_blake2b
     (c_out : access unsigned_char;
      outlen : stddef_h.size_t;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      key : access unsigned_char;
      keylen : stddef_h.size_t) return int  -- ./sodium/crypto_generichash_blake2b.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b";

   function crypto_generichash_blake2b_salt_personal
     (c_out : access unsigned_char;
      outlen : stddef_h.size_t;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      key : access unsigned_char;
      keylen : stddef_h.size_t;
      salt : access unsigned_char;
      personal : access unsigned_char) return int  -- ./sodium/crypto_generichash_blake2b.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_salt_personal";

   function crypto_generichash_blake2b_init
     (state : access crypto_generichash_blake2b_state;
      key : access unsigned_char;
      keylen : stddef_h.size_t;
      outlen : stddef_h.size_t) return int  -- ./sodium/crypto_generichash_blake2b.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_init";

   function crypto_generichash_blake2b_init_salt_personal
     (state : access crypto_generichash_blake2b_state;
      key : access unsigned_char;
      keylen : stddef_h.size_t;
      outlen : stddef_h.size_t;
      salt : access unsigned_char;
      personal : access unsigned_char) return int  -- ./sodium/crypto_generichash_blake2b.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_init_salt_personal";

   function crypto_generichash_blake2b_update
     (state : access crypto_generichash_blake2b_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_generichash_blake2b.h:100
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_update";

   function crypto_generichash_blake2b_final
     (state : access crypto_generichash_blake2b_state;
      c_out : access unsigned_char;
      outlen : stddef_h.size_t) return int  -- ./sodium/crypto_generichash_blake2b.h:106
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_final";

   procedure crypto_generichash_blake2b_keygen (k : access unsigned_char)  -- ./sodium/crypto_generichash_blake2b.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_generichash_blake2b_keygen";

end crypto_generichash_blake2b_h;
