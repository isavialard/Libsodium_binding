pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with x86_64_linux_gnu_bits_stdint_uintn_h;
with System;
with stddef_h;
with Interfaces.C.Extensions;

package randombytes_h is

   --  unsupported macro: randombytes_BYTES_MAX SODIUM_MIN(SODIUM_SIZE_MAX, 0xffffffffUL)
   randombytes_SEEDBYTES : constant := 32;  --  ./sodium/randombytes.h:30

  -- required  
   type randombytes_implementation is record
      implementation_name : access function return Interfaces.C.Strings.chars_ptr;  -- ./sodium/randombytes.h:20
      random : access function return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t;  -- ./sodium/randombytes.h:21
      stir : access procedure;  -- ./sodium/randombytes.h:22
      uniform : access function (arg1 : x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t) return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t;  -- ./sodium/randombytes.h:23
      buf : access procedure (arg1 : System.Address; arg2 : stddef_h.size_t);  -- ./sodium/randombytes.h:24
      close : access function return int;  -- ./sodium/randombytes.h:25
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/randombytes.h:19

  -- required  
  -- optional  
  -- optional, a default implementation will be used if NULL  
  -- required  
  -- optional  
  -- required  
   function randombytes_seedbytes return stddef_h.size_t  -- ./sodium/randombytes.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_seedbytes";

   procedure randombytes_buf (buf : System.Address; size : stddef_h.size_t)  -- ./sodium/randombytes.h:35
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_buf";

   procedure randombytes_buf_deterministic
     (buf : System.Address;
      size : stddef_h.size_t;
      seed : access unsigned_char)  -- ./sodium/randombytes.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_buf_deterministic";

   function randombytes_random return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- ./sodium/randombytes.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_random";

   function randombytes_uniform (upper_bound : x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t) return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- ./sodium/randombytes.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_uniform";

   procedure randombytes_stir  -- ./sodium/randombytes.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_stir";

   function randombytes_close return int  -- ./sodium/randombytes.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_close";

   function randombytes_set_implementation (impl : access randombytes_implementation) return int  -- ./sodium/randombytes.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_set_implementation";

   function randombytes_implementation_name return Interfaces.C.Strings.chars_ptr  -- ./sodium/randombytes.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_implementation_name";

   procedure randombytes (buf : access unsigned_char; buf_len : Extensions.unsigned_long_long)  -- ./sodium/randombytes.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes";

end randombytes_h;
