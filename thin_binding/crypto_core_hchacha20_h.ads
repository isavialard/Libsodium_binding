pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;

package crypto_core_hchacha20_h is

   crypto_core_hchacha20_OUTPUTBYTES : constant := 32;  --  ./sodium/crypto_core_hchacha20.h:11

   crypto_core_hchacha20_INPUTBYTES : constant := 16;  --  ./sodium/crypto_core_hchacha20.h:15

   crypto_core_hchacha20_KEYBYTES : constant := 32;  --  ./sodium/crypto_core_hchacha20.h:19

   crypto_core_hchacha20_CONSTBYTES : constant := 16;  --  ./sodium/crypto_core_hchacha20.h:23

   function crypto_core_hchacha20_outputbytes return stddef_h.size_t  -- ./sodium/crypto_core_hchacha20.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_hchacha20_outputbytes";

   function crypto_core_hchacha20_inputbytes return stddef_h.size_t  -- ./sodium/crypto_core_hchacha20.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_hchacha20_inputbytes";

   function crypto_core_hchacha20_keybytes return stddef_h.size_t  -- ./sodium/crypto_core_hchacha20.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_hchacha20_keybytes";

   function crypto_core_hchacha20_constbytes return stddef_h.size_t  -- ./sodium/crypto_core_hchacha20.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_hchacha20_constbytes";

   function crypto_core_hchacha20
     (c_out : access unsigned_char;
      c_in : access unsigned_char;
      k : access unsigned_char;
      c : access unsigned_char) return int  -- ./sodium/crypto_core_hchacha20.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_hchacha20";

end crypto_core_hchacha20_h;
