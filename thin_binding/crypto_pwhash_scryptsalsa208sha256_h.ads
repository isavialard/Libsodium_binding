pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package crypto_pwhash_scryptsalsa208sha256_h is

   crypto_pwhash_scryptsalsa208sha256_BYTES_MIN : constant := 16;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:17
   --  unsupported macro: crypto_pwhash_scryptsalsa208sha256_BYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX, 0x1fffffffe0ULL)

   crypto_pwhash_scryptsalsa208sha256_PASSWD_MIN : constant := 0;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:26
   --  unsupported macro: crypto_pwhash_scryptsalsa208sha256_PASSWD_MAX SODIUM_SIZE_MAX

   crypto_pwhash_scryptsalsa208sha256_SALTBYTES : constant := 32;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:34

   crypto_pwhash_scryptsalsa208sha256_STRBYTES : constant := 102;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:38

   crypto_pwhash_scryptsalsa208sha256_STRPREFIX : aliased constant String := "$7$" & ASCII.NUL;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:42

   crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_MIN : constant := 32768;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:46

   crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_MAX : constant := 4294967295;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:50

   crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_MIN : constant := 16777216;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:54
   --  unsupported macro: crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_MAX SODIUM_MIN(SIZE_MAX, 68719476736ULL)

   crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_INTERACTIVE : constant := 524288;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:63

   crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_INTERACTIVE : constant := 16777216;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:67

   crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_SENSITIVE : constant := 33554432;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:71

   crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_SENSITIVE : constant := 1073741824;  --  ./sodium/crypto_pwhash_scryptsalsa208sha256.h:75

   function crypto_pwhash_scryptsalsa208sha256_bytes_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_bytes_min";

   function crypto_pwhash_scryptsalsa208sha256_bytes_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_bytes_max";

   function crypto_pwhash_scryptsalsa208sha256_passwd_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_passwd_min";

   function crypto_pwhash_scryptsalsa208sha256_passwd_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_passwd_max";

   function crypto_pwhash_scryptsalsa208sha256_saltbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_saltbytes";

   function crypto_pwhash_scryptsalsa208sha256_strbytes return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_strbytes";

   function crypto_pwhash_scryptsalsa208sha256_strprefix return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_strprefix";

   function crypto_pwhash_scryptsalsa208sha256_opslimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_opslimit_min";

   function crypto_pwhash_scryptsalsa208sha256_opslimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:52
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_opslimit_max";

   function crypto_pwhash_scryptsalsa208sha256_memlimit_min return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_memlimit_min";

   function crypto_pwhash_scryptsalsa208sha256_memlimit_max return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_memlimit_max";

   function crypto_pwhash_scryptsalsa208sha256_opslimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_opslimit_interactive";

   function crypto_pwhash_scryptsalsa208sha256_memlimit_interactive return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_memlimit_interactive";

   function crypto_pwhash_scryptsalsa208sha256_opslimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:73
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_opslimit_sensitive";

   function crypto_pwhash_scryptsalsa208sha256_memlimit_sensitive return stddef_h.size_t  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:77
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_memlimit_sensitive";

   function crypto_pwhash_scryptsalsa208sha256
     (c_out : access unsigned_char;
      outlen : Extensions.unsigned_long_long;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      salt : access unsigned_char;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256";

   function crypto_pwhash_scryptsalsa208sha256_str
     (c_out : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:90
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_str";

   function crypto_pwhash_scryptsalsa208sha256_str_verify
     (str : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Extensions.unsigned_long_long) return int  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_str_verify";

   function crypto_pwhash_scryptsalsa208sha256_ll
     (passwd : access x86_64_linux_gnu_bits_stdint_uintn_h.uint8_t;
      passwdlen : stddef_h.size_t;
      salt : access x86_64_linux_gnu_bits_stdint_uintn_h.uint8_t;
      saltlen : stddef_h.size_t;
      N : x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t;
      r : x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t;
      p : x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t;
      buf : access x86_64_linux_gnu_bits_stdint_uintn_h.uint8_t;
      buflen : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_ll";

   function crypto_pwhash_scryptsalsa208sha256_str_needs_rehash
     (str : Interfaces.C.Strings.chars_ptr;
      opslimit : Extensions.unsigned_long_long;
      memlimit : stddef_h.size_t) return int  -- ./sodium/crypto_pwhash_scryptsalsa208sha256.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_pwhash_scryptsalsa208sha256_str_needs_rehash";

end crypto_pwhash_scryptsalsa208sha256_h;
