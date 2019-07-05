pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with randombytes_h;

package randombytes_internal_random_h is

   --  unsupported macro: randombytes_salsa20_implementation randombytes_internal_implementation
   randombytes_internal_implementation : aliased randombytes_h.randombytes_implementation  -- ./sodium/randombytes_internal_random.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_internal_implementation";

  -- Backwards compatibility with libsodium < 1.0.18  
end randombytes_internal_random_h;
