pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package crypto_pwhash_h is

   --  unsupported macro: crypto_pwhash_ALG_ARGON2I13 crypto_pwhash_argon2i_ALG_ARGON2I13
   --  unsupported macro: crypto_pwhash_ALG_ARGON2ID13 crypto_pwhash_argon2id_ALG_ARGON2ID13
   --  unsupported macro: crypto_pwhash_ALG_DEFAULT crypto_pwhash_ALG_ARGON2ID13
   --  unsupported macro: crypto_pwhash_BYTES_MIN crypto_pwhash_argon2id_BYTES_MIN
   --  unsupported macro: crypto_pwhash_BYTES_MAX crypto_pwhash_argon2id_BYTES_MAX
   --  unsupported macro: crypto_pwhash_PASSWD_MIN crypto_pwhash_argon2id_PASSWD_MIN
   --  unsupported macro: crypto_pwhash_PASSWD_MAX crypto_pwhash_argon2id_PASSWD_MAX
   --  unsupported macro: crypto_pwhash_SALTBYTES crypto_pwhash_argon2id_SALTBYTES
   --  unsupported macro: crypto_pwhash_STRBYTES crypto_pwhash_argon2id_STRBYTES
   --  unsupported macro: crypto_pwhash_STRPREFIX crypto_pwhash_argon2id_STRPREFIX
   --  unsupported macro: crypto_pwhash_OPSLIMIT_MIN crypto_pwhash_argon2id_OPSLIMIT_MIN
   --  unsupported macro: crypto_pwhash_OPSLIMIT_MAX crypto_pwhash_argon2id_OPSLIMIT_MAX
   --  unsupported macro: crypto_pwhash_MEMLIMIT_MIN crypto_pwhash_argon2id_MEMLIMIT_MIN
   --  unsupported macro: crypto_pwhash_MEMLIMIT_MAX crypto_pwhash_argon2id_MEMLIMIT_MAX
   --  unsupported macro: crypto_pwhash_OPSLIMIT_INTERACTIVE crypto_pwhash_argon2id_OPSLIMIT_INTERACTIVE
   --  unsupported macro: crypto_pwhash_MEMLIMIT_INTERACTIVE crypto_pwhash_argon2id_MEMLIMIT_INTERACTIVE
   --  unsupported macro: crypto_pwhash_OPSLIMIT_MODERATE crypto_pwhash_argon2id_OPSLIMIT_MODERATE
   --  unsupported macro: crypto_pwhash_MEMLIMIT_MODERATE crypto_pwhash_argon2id_MEMLIMIT_MODERATE
   --  unsupported macro: crypto_pwhash_OPSLIMIT_SENSITIVE crypto_pwhash_argon2id_OPSLIMIT_SENSITIVE
   --  unsupported macro: crypto_pwhash_MEMLIMIT_SENSITIVE crypto_pwhash_argon2id_MEMLIMIT_SENSITIVE
   crypto_pwhash_PRIMITIVE : aliased constant String := "argon2i" & ASCII.NUL;  --  ./sodium/crypto_pwhash.h:138

   function crypto_pwhash_alg_argon2i13 return int  -- ./sodium/crypto_pwhash.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_alg_argon2i13";

   function crypto_pwhash_alg_argon2id13 return int  -- ./sodium/crypto_pwhash.h:23
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_alg_argon2id13";

   function crypto_pwhash_alg_default return int  -- ./sodium/crypto_pwhash.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_alg_default";

   function crypto_pwhash_bytes_min return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_bytes_min";

   function crypto_pwhash_bytes_max return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_bytes_max";

   function crypto_pwhash_passwd_min return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_passwd_min";

   function crypto_pwhash_passwd_max return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:43
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_passwd_max";

   function crypto_pwhash_saltbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_saltbytes";

   function crypto_pwhash_strbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_strbytes";

   function crypto_pwhash_strprefix return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_pwhash.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_strprefix";

   function crypto_pwhash_opslimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_opslimit_min";

   function crypto_pwhash_opslimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_opslimit_max";

   function crypto_pwhash_memlimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_memlimit_min";

   function crypto_pwhash_memlimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_memlimit_max";

   function crypto_pwhash_opslimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_opslimit_interactive";

   function crypto_pwhash_memlimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_memlimit_interactive";

   function crypto_pwhash_opslimit_moderate return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_opslimit_moderate";

   function crypto_pwhash_memlimit_moderate return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:87
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_memlimit_moderate";

   function crypto_pwhash_opslimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:91
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_opslimit_sensitive";

   function crypto_pwhash_memlimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_memlimit_sensitive";

  -- * With this function, do not forget to store all parameters, including the
  -- * algorithm identifier in order to produce deterministic output.
  -- * The crypto_pwhash_* definitions, including crypto_pwhash_ALG_DEFAULT,
  -- * may change.
  --  

   function crypto_pwhash
     (c_out : access unsigned_char;
      outlen : Extensions.unsigned_long_long;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      salt : access unsigned_char;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t;
      alg : int) return int  -- ./sodium/crypto_pwhash.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash";

  -- * The output string already includes all the required parameters, including
  -- * the algorithm identifier. The string is all that has to be stored in
  -- * order to verify a password.
  --  

   function crypto_pwhash_str
     (c_out : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash.h:116
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_str";

   function crypto_pwhash_str_alg
     (c_out : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t;
      alg : int) return int  -- ./sodium/crypto_pwhash.h:122
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_str_alg";

   function crypto_pwhash_str_verify
     (str : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_pwhash.h:128
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_str_verify";

   function crypto_pwhash_str_needs_rehash
     (str : Interfaces.C.Strings.chars_ptr;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash.h:134
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_str_needs_rehash";

   function crypto_pwhash_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_pwhash.h:140
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_primitive";

end crypto_pwhash_h;
