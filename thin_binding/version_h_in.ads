pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package version_h_in is

   SODIUM_VERSION_STRING : aliased constant String := "@VERSION@" & ASCII.NUL;  --  ./sodium/version.h.in:7
   --  unsupported macro: SODIUM_LIBRARY_VERSION_MAJOR @SODIUM_LIBRARY_VERSION_MAJOR@
   --  unsupported macro: SODIUM_LIBRARY_VERSION_MINOR @SODIUM_LIBRARY_VERSION_MINOR@

   SODIUM_LIBRARY_MINIMAL_DEF : aliased int  -- ./sodium/version.h.in:11
   with Import => True, 
        Convention => C, 
        External_Name => "SODIUM_LIBRARY_MINIMAL_DEF";

   function sodium_library_version_major return int  -- ./sodium/version.h.in:21
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_library_version_major";

   function sodium_library_version_minor return int  -- ./sodium/version.h.in:24
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_library_version_minor";

   function sodium_library_minimal return int  -- ./sodium/version.h.in:27
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_library_minimal";

end version_h_in;
