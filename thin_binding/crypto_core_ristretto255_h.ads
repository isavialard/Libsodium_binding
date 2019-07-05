pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;

package crypto_core_ristretto255_h is

   crypto_core_ristretto255_BYTES : constant := 32;  --  ./sodium/crypto_core_ristretto255.h:11

   crypto_core_ristretto255_HASHBYTES : constant := 64;  --  ./sodium/crypto_core_ristretto255.h:15

   crypto_core_ristretto255_SCALARBYTES : constant := 32;  --  ./sodium/crypto_core_ristretto255.h:19

   crypto_core_ristretto255_NONREDUCEDSCALARBYTES : constant := 64;  --  ./sodium/crypto_core_ristretto255.h:23

   function crypto_core_ristretto255_bytes return stddef_h.size_t  -- ./sodium/crypto_core_ristretto255.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_bytes";

   function crypto_core_ristretto255_hashbytes return stddef_h.size_t  -- ./sodium/crypto_core_ristretto255.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_hashbytes";

   function crypto_core_ristretto255_scalarbytes return stddef_h.size_t  -- ./sodium/crypto_core_ristretto255.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalarbytes";

   function crypto_core_ristretto255_nonreducedscalarbytes return stddef_h.size_t  -- ./sodium/crypto_core_ristretto255.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_nonreducedscalarbytes";

   function crypto_core_ristretto255_is_valid_point (p : access unsigned_char) return int  -- ./sodium/crypto_core_ristretto255.h:28
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_is_valid_point";

   function crypto_core_ristretto255_add
     (r : access unsigned_char;
      p : access unsigned_char;
      q : access unsigned_char) return int  -- ./sodium/crypto_core_ristretto255.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_add";

   function crypto_core_ristretto255_sub
     (r : access unsigned_char;
      p : access unsigned_char;
      q : access unsigned_char) return int  -- ./sodium/crypto_core_ristretto255.h:37
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_sub";

   function crypto_core_ristretto255_from_hash (p : access unsigned_char; r : access unsigned_char) return int  -- ./sodium/crypto_core_ristretto255.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_from_hash";

   procedure crypto_core_ristretto255_random (p : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_random";

   procedure crypto_core_ristretto255_scalar_random (r : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_random";

   function crypto_core_ristretto255_scalar_invert (recip : access unsigned_char; s : access unsigned_char) return int  -- ./sodium/crypto_core_ristretto255.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_invert";

   procedure crypto_core_ristretto255_scalar_negate (neg : access unsigned_char; s : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_negate";

   procedure crypto_core_ristretto255_scalar_complement (comp : access unsigned_char; s : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_complement";

   procedure crypto_core_ristretto255_scalar_add
     (z : access unsigned_char;
      x : access unsigned_char;
      y : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_add";

   procedure crypto_core_ristretto255_scalar_sub
     (z : access unsigned_char;
      x : access unsigned_char;
      y : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_sub";

   procedure crypto_core_ristretto255_scalar_mul
     (z : access unsigned_char;
      x : access unsigned_char;
      y : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:82
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_mul";

  -- * The interval `s` is sampled from should be at least 317 bits to ensure almost
  -- * uniformity of `r` over `L`.
  --  

   procedure crypto_core_ristretto255_scalar_reduce (r : access unsigned_char; s : access unsigned_char)  -- ./sodium/crypto_core_ristretto255.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_core_ristretto255_scalar_reduce";

end crypto_core_ristretto255_h;
