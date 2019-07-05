pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with randombytes_h;

package randombytes_sysrandom_h is

   randombytes_sysrandom_implementation : aliased randombytes_h.randombytes_implementation  -- ./sodium/randombytes_sysrandom.h:13
   with Import => True, 
        Convention => C, 
        External_Name => "randombytes_sysrandom_implementation";

end randombytes_sysrandom_h;
