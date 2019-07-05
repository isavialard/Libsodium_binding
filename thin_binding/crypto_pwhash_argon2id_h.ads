pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_pwhash_argon2id_h is

   crypto_pwhash_argon2id_ALG_ARGON2ID13 : constant := 2;  --  ./sodium/crypto_pwhash_argon2id.h:17

   crypto_pwhash_argon2id_BYTES_MIN : constant := 16;  --  ./sodium/crypto_pwhash_argon2id.h:21
   --  unsupported macro: crypto_pwhash_argon2id_BYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX, 4294967295U)

   crypto_pwhash_argon2id_PASSWD_MIN : constant := 0;  --  ./sodium/crypto_pwhash_argon2id.h:29

   crypto_pwhash_argon2id_PASSWD_MAX : constant := 4294967295;  --  ./sodium/crypto_pwhash_argon2id.h:33

   crypto_pwhash_argon2id_SALTBYTES : constant := 16;  --  ./sodium/crypto_pwhash_argon2id.h:37

   crypto_pwhash_argon2id_STRBYTES : constant := 128;  --  ./sodium/crypto_pwhash_argon2id.h:41

   crypto_pwhash_argon2id_STRPREFIX : aliased constant String := "$argon2id$" & ASCII.NUL;  --  ./sodium/crypto_pwhash_argon2id.h:45

   crypto_pwhash_argon2id_OPSLIMIT_MIN : constant := 1;  --  ./sodium/crypto_pwhash_argon2id.h:49

   crypto_pwhash_argon2id_OPSLIMIT_MAX : constant := 4294967295;  --  ./sodium/crypto_pwhash_argon2id.h:53

   crypto_pwhash_argon2id_MEMLIMIT_MIN : constant := 8192;  --  ./sodium/crypto_pwhash_argon2id.h:57
   --  unsupported macro: crypto_pwhash_argon2id_MEMLIMIT_MAX ((SIZE_MAX >= 4398046510080U) ? 4398046510080U : (SIZE_MAX >= 2147483648U) ? 2147483648U : 32768U)

   crypto_pwhash_argon2id_OPSLIMIT_INTERACTIVE : constant := 2;  --  ./sodium/crypto_pwhash_argon2id.h:66

   crypto_pwhash_argon2id_MEMLIMIT_INTERACTIVE : constant := 67108864;  --  ./sodium/crypto_pwhash_argon2id.h:70

   crypto_pwhash_argon2id_OPSLIMIT_MODERATE : constant := 3;  --  ./sodium/crypto_pwhash_argon2id.h:74

   crypto_pwhash_argon2id_MEMLIMIT_MODERATE : constant := 268435456;  --  ./sodium/crypto_pwhash_argon2id.h:78

   crypto_pwhash_argon2id_OPSLIMIT_SENSITIVE : constant := 4;  --  ./sodium/crypto_pwhash_argon2id.h:82

   crypto_pwhash_argon2id_MEMLIMIT_SENSITIVE : constant := 1073741824;  --  ./sodium/crypto_pwhash_argon2id.h:86

   function crypto_pwhash_argon2id_alg_argon2id13 return int  -- ./sodium/crypto_pwhash_argon2id.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_alg_argon2id13";

   function crypto_pwhash_argon2id_bytes_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_bytes_min";

   function crypto_pwhash_argon2id_bytes_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_bytes_max";

   function crypto_pwhash_argon2id_passwd_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_passwd_min";

   function crypto_pwhash_argon2id_passwd_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_passwd_max";

   function crypto_pwhash_argon2id_saltbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_saltbytes";

   function crypto_pwhash_argon2id_strbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_strbytes";

   function crypto_pwhash_argon2id_strprefix return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_pwhash_argon2id.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_strprefix";

   function crypto_pwhash_argon2id_opslimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_opslimit_min";

   function crypto_pwhash_argon2id_opslimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_opslimit_max";

   function crypto_pwhash_argon2id_memlimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_memlimit_min";

   function crypto_pwhash_argon2id_memlimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_memlimit_max";

   function crypto_pwhash_argon2id_opslimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_opslimit_interactive";

   function crypto_pwhash_argon2id_memlimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_memlimit_interactive";

   function crypto_pwhash_argon2id_opslimit_moderate return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_opslimit_moderate";

   function crypto_pwhash_argon2id_memlimit_moderate return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_memlimit_moderate";

   function crypto_pwhash_argon2id_opslimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_opslimit_sensitive";

   function crypto_pwhash_argon2id_memlimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash_argon2id.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_memlimit_sensitive";

   function crypto_pwhash_argon2id
     (c_out : access unsigned_char;
      outlen : Extensions.unsigned_long_long;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      salt : access unsigned_char;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t;
      alg : int) return int  -- ./sodium/crypto_pwhash_argon2id.h:91
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id";

   function crypto_pwhash_argon2id_str
     (c_out : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_argon2id.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_str";

   function crypto_pwhash_argon2id_str_verify
     (str : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_pwhash_argon2id.h:108
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_str_verify";

   function crypto_pwhash_argon2id_str_needs_rehash
     (str : Interfaces.C.Strings.chars_ptr;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_argon2id.h:114
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_argon2id_str_needs_rehash";

end crypto_pwhash_argon2id_h;
