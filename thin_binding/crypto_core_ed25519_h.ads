pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;

package crypto_core_ed25519_h is

   crypto_core_ed25519_BYTES : constant := 32;  --  ./sodium/crypto_core_ed25519.h:11

   crypto_core_ed25519_UNIFORMBYTES : constant := 32;  --  ./sodium/crypto_core_ed25519.h:15

   crypto_core_ed25519_HASHBYTES : constant := 64;  --  ./sodium/crypto_core_ed25519.h:19

   crypto_core_ed25519_SCALARBYTES : constant := 32;  --  ./sodium/crypto_core_ed25519.h:23

   crypto_core_ed25519_NONREDUCEDSCALARBYTES : constant := 64;  --  ./sodium/crypto_core_ed25519.h:27

   function crypto_core_ed25519_bytes return stddef_h.size_t  -- ./sodium/crypto_core_ed25519.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_bytes";

   function crypto_core_ed25519_uniformbytes return stddef_h.size_t  -- ./sodium/crypto_core_ed25519.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_uniformbytes";

   function crypto_core_ed25519_hashbytes return stddef_h.size_t  -- ./sodium/crypto_core_ed25519.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_hashbytes";

   function crypto_core_ed25519_scalarbytes return stddef_h.size_t  -- ./sodium/crypto_core_ed25519.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalarbytes";

   function crypto_core_ed25519_nonreducedscalarbytes return stddef_h.size_t  -- ./sodium/crypto_core_ed25519.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_nonreducedscalarbytes";

   function crypto_core_ed25519_is_valid_point (p : access unsigned_char) return int  -- ./sodium/crypto_core_ed25519.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_is_valid_point";

   function crypto_core_ed25519_add
     (r : access unsigned_char;
      p : access unsigned_char;
      q : access unsigned_char) return int  -- ./sodium/crypto_core_ed25519.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_add";

   function crypto_core_ed25519_sub
     (r : access unsigned_char;
      p : access unsigned_char;
      q : access unsigned_char) return int  -- ./sodium/crypto_core_ed25519.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_sub";

   function crypto_core_ed25519_from_uniform (p : access unsigned_char; r : access unsigned_char) return int  -- ./sodium/crypto_core_ed25519.h:46
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_from_uniform";

   function crypto_core_ed25519_from_hash (p : access unsigned_char; h : access unsigned_char) return int  -- ./sodium/crypto_core_ed25519.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_from_hash";

   procedure crypto_core_ed25519_random (p : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:54
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_random";

   procedure crypto_core_ed25519_scalar_random (r : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_random";

   function crypto_core_ed25519_scalar_invert (recip : access unsigned_char; s : access unsigned_char) return int  -- ./sodium/crypto_core_ed25519.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_invert";

   procedure crypto_core_ed25519_scalar_negate (neg : access unsigned_char; s : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_negate";

   procedure crypto_core_ed25519_scalar_complement (comp : access unsigned_char; s : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_complement";

   procedure crypto_core_ed25519_scalar_add
     (z : access unsigned_char;
      x : access unsigned_char;
      y : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:74
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_add";

   procedure crypto_core_ed25519_scalar_sub
     (z : access unsigned_char;
      x : access unsigned_char;
      y : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_sub";

   procedure crypto_core_ed25519_scalar_mul
     (z : access unsigned_char;
      x : access unsigned_char;
      y : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:84
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_mul";

  -- * The interval `s` is sampled from should be at least 317 bits to ensure almost
  -- * uniformity of `r` over `L`.
  --  

   procedure crypto_core_ed25519_scalar_reduce (r : access unsigned_char; s : access unsigned_char)  -- ./sodium/crypto_core_ed25519.h:93
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ed25519_scalar_reduce";

end crypto_core_ed25519_h;
