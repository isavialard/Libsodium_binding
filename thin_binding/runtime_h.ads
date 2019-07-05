pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package runtime_h is

   function sodium_runtime_has_neon return int  -- ./sodium/runtime.h:12
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_neon";

   function sodium_runtime_has_sse2 return int  -- ./sodium/runtime.h:15
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_sse2";

   function sodium_runtime_has_sse3 return int  -- ./sodium/runtime.h:18
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_sse3";

   function sodium_runtime_has_ssse3 return int  -- ./sodium/runtime.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_ssse3";

   function sodium_runtime_has_sse41 return int  -- ./sodium/runtime.h:24
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_sse41";

   function sodium_runtime_has_avx return int  -- ./sodium/runtime.h:27
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_avx";

   function sodium_runtime_has_avx2 return int  -- ./sodium/runtime.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_avx2";

   function sodium_runtime_has_avx512f return int  -- ./sodium/runtime.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_avx512f";

   function sodium_runtime_has_pclmul return int  -- ./sodium/runtime.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_pclmul";

   function sodium_runtime_has_aesni return int  -- ./sodium/runtime.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_aesni";

   function sodium_runtime_has_rdrand return int  -- ./sodium/runtime.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_runtime_has_rdrand";

  -- -------------------------------------------------------------------------  
   --  skipped func _sodium_runtime_get_cpu_features

end runtime_h;
