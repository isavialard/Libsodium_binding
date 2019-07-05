pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_pwhash_argon2i_h is

   crypto_pwhash_argon2i_ALG_ARGON2I13 : constant := 1;  --  ./sodium/crypto_pwhash_argon2i.h:17

   crypto_pwhash_argon2i_BYTES_MIN : constant := 16;  --  ./sodium/crypto_pwhash_argon2i.h:21
   --  unsupported macro: crypto_pwhash_argon2i_BYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX, 4294967295U)

   crypto_pwhash_argon2i_PASSWD_MIN : constant := 0;  --  ./sodium/crypto_pwhash_argon2i.h:29

   crypto_pwhash_argon2i_PASSWD_MAX : constant := 4294967295;  --  ./sodium/crypto_pwhash_argon2i.h:33

   crypto_pwhash_argon2i_SALTBYTES : constant := 16;  --  ./sodium/crypto_pwhash_argon2i.h:37

   crypto_pwhash_argon2i_STRBYTES : constant := 128;  --  ./sodium/crypto_pwhash_argon2i.h:41

   crypto_pwhash_argon2i_STRPREFIX : aliased constant String := "$argon2i$" & ASCII.NUL;  --  ./sodium/crypto_pwhash_argon2i.h:45

   crypto_pwhash_argon2i_OPSLIMIT_MIN : constant := 3;  --  ./sodium/crypto_pwhash_argon2i.h:49

   crypto_pwhash_argon2i_OPSLIMIT_MAX : constant := 4294967295;  --  ./sodium/crypto_pwhash_argon2i.h:53

   crypto_pwhash_argon2i_MEMLIMIT_MIN : constant := 8192;  --  ./sodium/crypto_pwhash_argon2i.h:57
   --  unsupported macro: crypto_pwhash_argon2i_MEMLIMIT_MAX ((SIZE_MAX >= 4398046510080U) ? 4398046510080U : (SIZE_MAX >= 2147483648U) ? 2147483648U : 32768U)

   crypto_pwhash_argon2i_OPSLIMIT_INTERACTIVE : constant := 4;  --  ./sodium/crypto_pwhash_argon2i.h:66

   crypto_pwhash_argon2i_MEMLIMIT_INTERACTIVE : constant := 33554432;  --  ./sodium/crypto_pwhash_argon2i.h:70

   crypto_pwhash_argon2i_OPSLIMIT_MODERATE : constant := 6;  --  ./sodium/crypto_pwhash_argon2i.h:74

   crypto_pwhash_argon2i_MEMLIMIT_MODERATE : constant := 134217728;  --  ./sodium/crypto_pwhash_argon2i.h:78

   crypto_pwhash_argon2i_OPSLIMIT_SENSITIVE : constant := 8;  --  ./sodium/crypto_pwhash_argon2i.h:82

   crypto_pwhash_argon2i_MEMLIMIT_SENSITIVE : constant := 536870912;  --  ./sodium/crypto_pwhash_argon2i.h:86

   function crypto_pwhash_argon2i_alg_argon2i13 return int  -- ./sodium/crypto_pwhash_argon2i.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_alg_argon2i13";

   function crypto_pwhash_argon2i_bytes_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_bytes_min";

   function crypto_pwhash_argon2i_bytes_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_bytes_max";

   function crypto_pwhash_argon2i_passwd_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_passwd_min";

   function crypto_pwhash_argon2i_passwd_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_passwd_max";

   function crypto_pwhash_argon2i_saltbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_saltbytes";

   function crypto_pwhash_argon2i_strbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_strbytes";

   function crypto_pwhash_argon2i_strprefix return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_pwhash_argon2i.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_strprefix";

   function crypto_pwhash_argon2i_opslimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_opslimit_min";

   function crypto_pwhash_argon2i_opslimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_opslimit_max";

   function crypto_pwhash_argon2i_memlimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_memlimit_min";

   function crypto_pwhash_argon2i_memlimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_memlimit_max";

   function crypto_pwhash_argon2i_opslimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_opslimit_interactive";

   function crypto_pwhash_argon2i_memlimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_memlimit_interactive";

   function crypto_pwhash_argon2i_opslimit_moderate return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_opslimit_moderate";

   function crypto_pwhash_argon2i_memlimit_moderate return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_memlimit_moderate";

   function crypto_pwhash_argon2i_opslimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_opslimit_sensitive";

   function crypto_pwhash_argon2i_memlimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2i.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_memlimit_sensitive";

   function crypto_pwhash_argon2i
     (c_out : access unsigned_char;
      outlen : Extensions.unsigned_long_long;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      salt : access unsigned_char;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t;
      alg : int) return int  -- ./sodium/crypto_pwhash_argon2i.h:91
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i";

   function crypto_pwhash_argon2i_str
     (c_out : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_argon2i.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_str";

   function crypto_pwhash_argon2i_str_verify
     (str : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_pwhash_argon2i.h:108
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_str_verify";

   function crypto_pwhash_argon2i_str_needs_rehash
     (str : Interfaces.C.Strings.chars_ptr;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_argon2i.h:114
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2i_str_needs_rehash";

end crypto_pwhash_argon2i_h;
