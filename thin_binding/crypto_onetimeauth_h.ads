pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with crypto_onetimeauth_poly1305_h;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_onetimeauth_h is

   --  unsupported macro: crypto_onetimeauth_BYTES crypto_onetimeauth_poly1305_BYTES
   --  unsupported macro: crypto_onetimeauth_KEYBYTES crypto_onetimeauth_poly1305_KEYBYTES
   crypto_onetimeauth_PRIMITIVE : aliased constant String := "poly1305" & ASCII.NUL;  --  ./sodium/crypto_onetimeauth.h:29

   subtype crypto_onetimeauth_state is crypto_onetimeauth_poly1305_h.crypto_onetimeauth_poly1305_state;  -- ./sodium/crypto_onetimeauth.h:16

   function crypto_onetimeauth_statebytes return stddef_h.size_t  -- ./sodium/crypto_onetimeauth.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_statebytes";

   function crypto_onetimeauth_bytes return stddef_h.size_t  -- ./sodium/crypto_onetimeauth.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_bytes";

   function crypto_onetimeauth_keybytes return stddef_h.size_t  -- ./sodium/crypto_onetimeauth.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_keybytes";

   function crypto_onetimeauth_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_onetimeauth.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_primitive";

   function crypto_onetimeauth
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth";

   function crypto_onetimeauth_verify
     (h : access unsigned_char;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long;
      k : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_verify";

   function crypto_onetimeauth_init (state : access crypto_onetimeauth_state; key : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_init";

   function crypto_onetimeauth_update
     (state : access crypto_onetimeauth_state;
      c_in : access unsigned_char;
      inlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_onetimeauth.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_update";

   function crypto_onetimeauth_final (state : access crypto_onetimeauth_state; c_out : access unsigned_char) return int  -- ./sodium/crypto_onetimeauth.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_final";

   procedure crypto_onetimeauth_keygen (k : access unsigned_char)  -- ./sodium/crypto_onetimeauth.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_onetimeauth_keygen";

end crypto_onetimeauth_h;
