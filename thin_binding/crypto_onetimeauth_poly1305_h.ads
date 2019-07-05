pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Extensions;

package crypto_onetimeauth_poly1305_h is

   crypto_onetimeauth_poly1305_BYTES : constant := 16;  --  ./sodium/crypto_onetimeauth_poly1305.h:26

   crypto_onetimeauth_poly1305_KEYBYTES : constant := 32;  --  ./sodium/crypto_onetimeauth_poly1305.h:30

   type anon1512_opaque_array is array (0 .. 255) of aliased unsigned_char;
   type crypto_onetimeauth_poly1305_state is record
      opaque : aliased anon1512_opaque_array;  -- ./sodium/crypto_onetimeauth_poly1305.h:20
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_onetimeauth_poly1305.h:19

   function crypto_onetimeauth_poly1305_statebytes return stddef_h.size_t  -- ./sodium/crypto_onetimeauth_poly1305.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_statebytes";

   function crypto_onetimeauth_poly1305_bytes return stddef_h.size_t  -- ./sodium/crypto_onetimeauth_poly1305.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_bytes";

   function crypto_onetimeauth_poly1305_keybytes return stddef_h.size_t  -- ./sodium/crypto_onetimeauth_poly1305.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_keybytes";

   function crypto_onetimeauth_poly1305
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth_poly1305.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305";

   function crypto_onetimeauth_poly1305_verify
     (h : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth_poly1305.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_verify";

   function crypto_onetimeauth_poly1305_init (state : access crypto_onetimeauth_poly1305_state; key : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth_poly1305.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_init";

   function crypto_onetimeauth_poly1305_update
     (state : access crypto_onetimeauth_poly1305_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_onetimeauth_poly1305.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_update";

   function crypto_onetimeauth_poly1305_final (state : access crypto_onetimeauth_poly1305_state; c_out : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth_poly1305.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_final";

   procedure crypto_onetimeauth_poly1305_keygen (k : access unsigned_char)  -- ./sodium/crypto_onetimeauth_poly1305.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_poly1305_keygen";

end crypto_onetimeauth_poly1305_h;
