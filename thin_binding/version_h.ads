pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package version_h is

   SODIUM_VERSION_STRING : aliased constant String := "1.0.18" & ASCII.NUL;  --  ./sodium/version.h:6

   SODIUM_LIBRARY_VERSION_MAJOR : constant := 10;  --  ./sodium/version.h:8
   SODIUM_LIBRARY_VERSION_MINOR : constant := 3;  --  ./sodium/version.h:9

   function sodium_version_string return Interfaces.C.Strings.chars_ptr  -- ./sodium/version.h:16
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_version_string";

   function sodium_library_version_major return int  -- ./sodium/version.h:19
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_library_version_major";

   function sodium_library_version_minor return int  -- ./sodium/version.h:22
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_library_version_minor";

   function sodium_library_minimal return int  -- ./sodium/version.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "sodium_library_minimal";

end version_h;
