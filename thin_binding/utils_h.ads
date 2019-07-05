pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with stddef_h;
with Interfaces.C.Strings;

package utils_h is

   --  arg-macro: procedure SODIUM_C99 (X)
   --    X
   sodium_base64_VARIANT_ORIGINAL : constant := 1;  --  ./sodium/utils.h:71
   sodium_base64_VARIANT_ORIGINAL_NO_PADDING : constant := 3;  --  ./sodium/utils.h:72
   sodium_base64_VARIANT_URLSAFE : constant := 5;  --  ./sodium/utils.h:73
   sodium_base64_VARIANT_URLSAFE_NO_PADDING : constant := 7;  --  ./sodium/utils.h:74
   --  arg-macro: function sodium_base64_ENCODED_LEN (BIN_LEN, VARIANT)
   --    return ((BIN_LEN) / 3) * 4 + ((((BIN_LEN) - ((BIN_LEN) / 3) * 3) or (((BIN_LEN) - ((BIN_LEN) / 3) * 3) >> 1)) and 1) * (4 - (~((((VARIANT) and 2) >> 1) - 1) and (3 - ((BIN_LEN) - ((BIN_LEN) / 3) * 3)))) + 1;

   procedure sodium_memzero (pnt : System.Address; len : stddef_h.size_t)  -- ./sodium/utils.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_memzero";

   procedure sodium_stackzero (len : stddef_h.size_t)  -- ./sodium/utils.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_stackzero";

  -- * WARNING: sodium_memcmp() must be used to verify if two secret keys
  -- * are equal, in constant time.
  -- * It returns 0 if the keys are equal, and -1 if they differ.
  -- * This function is not designed for lexicographical comparisons.
  --  

   function sodium_memcmp
     (b1_u : System.Address;
      b2_u : System.Address;
      len : stddef_h.size_t) return int  -- ./sodium/utils.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_memcmp";

  -- * sodium_compare() returns -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
  -- * It is suitable for lexicographical comparisons, or to compare nonces
  -- * and counters stored in little-endian format.
  -- * However, it is slower than sodium_memcmp().
  --  

   function sodium_compare
     (b1_u : access unsigned_char;
      b2_u : access unsigned_char;
      len : stddef_h.size_t) return int  -- ./sodium/utils.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_compare";

   function sodium_is_zero (n : access unsigned_char; nlen : stddef_h.size_t) return int  -- ./sodium/utils.h:48
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_is_zero";

   procedure sodium_increment (n : access unsigned_char; nlen : stddef_h.size_t)  -- ./sodium/utils.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_increment";

   procedure sodium_add
     (a : access unsigned_char;
      b : access unsigned_char;
      len : stddef_h.size_t)  -- ./sodium/utils.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_add";

   procedure sodium_sub
     (a : access unsigned_char;
      b : access unsigned_char;
      len : stddef_h.size_t)  -- ./sodium/utils.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_sub";

   function sodium_bin2hex
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : stddef_h.size_t;
      arg3 : access unsigned_char;
      arg4 : stddef_h.size_t) return Interfaces.C.Strings.chars_ptr  -- ./sodium/utils.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_bin2hex";

   function sodium_hex2bin
     (bin : access unsigned_char;
      bin_maxlen : stddef_h.size_t;
      hex : Interfaces.C.Strings.chars_ptr;
      hex_len : stddef_h.size_t;
      ignore : Interfaces.C.Strings.chars_ptr;
      bin_len : access stddef_h.size_t;
      hex_end : System.Address) return int  -- ./sodium/utils.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_hex2bin";

  -- * Computes the required length to encode BIN_LEN bytes as a base64 string
  -- * using the given variant. The computed length includes a trailing \0.
  --  

   function sodium_base64_encoded_len (bin_len : stddef_h.size_t; variant : int) return stddef_h.size_t  -- ./sodium/utils.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_base64_encoded_len";

   function sodium_bin2base64
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : stddef_h.size_t;
      arg3 : access unsigned_char;
      arg4 : stddef_h.size_t;
      arg5 : int) return Interfaces.C.Strings.chars_ptr  -- ./sodium/utils.h:89
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_bin2base64";

   function sodium_base642bin
     (bin : access unsigned_char;
      bin_maxlen : stddef_h.size_t;
      b64 : Interfaces.C.Strings.chars_ptr;
      b64_len : stddef_h.size_t;
      ignore : Interfaces.C.Strings.chars_ptr;
      bin_len : access stddef_h.size_t;
      b64_end : System.Address;
      variant : int) return int  -- ./sodium/utils.h:94
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_base642bin";

   function sodium_mlock (addr : System.Address; len : stddef_h.size_t) return int  -- ./sodium/utils.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_mlock";

   function sodium_munlock (addr : System.Address; len : stddef_h.size_t) return int  -- ./sodium/utils.h:105
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_munlock";

  -- WARNING: sodium_malloc() and sodium_allocarray() are not general-purpose
  -- * allocation functions.
  -- *
  -- * They return a pointer to a region filled with 0xd0 bytes, immediately
  -- * followed by a guard page.
  -- * As a result, accessing a single byte after the requested allocation size
  -- * will intentionally trigger a segmentation fault.
  -- *
  -- * A canary and an additional guard page placed before the beginning of the
  -- * region may also kill the process if a buffer underflow is detected.
  -- *
  -- * The memory layout is:
  -- * [unprotected region size (read only)][guard page (no access)][unprotected pages (read/write)][guard page (no access)]
  -- * With the layout of the unprotected pages being:
  -- * [optional padding][16-bytes canary][user region]
  -- *
  -- * However:
  -- * - These functions are significantly slower than standard functions
  -- * - Each allocation requires 3 or 4 additional pages
  -- * - The returned address will not be aligned if the allocation size is not
  -- *   a multiple of the required alignment. For this reason, these functions
  -- *   are designed to store data, such as secret keys and messages.
  -- *
  -- * sodium_malloc() can be used to allocate any libsodium data structure.
  -- *
  -- * The crypto_generichash_state structure is packed and its length is
  -- * either 357 or 361 bytes. For this reason, when using sodium_malloc() to
  -- * allocate a crypto_generichash_state structure, padding must be added in
  -- * order to ensure proper alignment. crypto_generichash_statebytes()
  -- * returns the rounded up structure size, and should be prefered to sizeof():
  -- * state = sodium_malloc(crypto_generichash_statebytes());
  --  

   function sodium_malloc (arg1 : stddef_h.size_t) return System.Address  -- ./sodium/utils.h:142
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_malloc";

   function sodium_allocarray (arg1 : stddef_h.size_t; arg2 : stddef_h.size_t) return System.Address  -- ./sodium/utils.h:146
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_allocarray";

   procedure sodium_free (ptr : System.Address)  -- ./sodium/utils.h:150
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_free";

   function sodium_mprotect_noaccess (ptr : System.Address) return int  -- ./sodium/utils.h:153
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_mprotect_noaccess";

   function sodium_mprotect_readonly (ptr : System.Address) return int  -- ./sodium/utils.h:156
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_mprotect_readonly";

   function sodium_mprotect_readwrite (ptr : System.Address) return int  -- ./sodium/utils.h:159
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_mprotect_readwrite";

   function sodium_pad
     (padded_buflen_p : access stddef_h.size_t;
      buf : access unsigned_char;
      unpadded_buflen : stddef_h.size_t;
      blocksize : stddef_h.size_t;
      max_buflen : stddef_h.size_t) return int  -- ./sodium/utils.h:162
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_pad";

   function sodium_unpad
     (unpadded_buflen_p : access stddef_h.size_t;
      buf : access unsigned_char;
      padded_buflen : stddef_h.size_t;
      blocksize : stddef_h.size_t) return int  -- ./sodium/utils.h:167
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_unpad";

  -- --------  
   --  skipped func _sodium_alloc_init

end utils_h;
