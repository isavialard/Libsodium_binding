pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with stddef_h;
with Interfaces.C.Strings;

package crypto_kx_h is

   crypto_kx_PUBLICKEYBYTES : constant := 32;  --  ./sodium/crypto_kx.h:15

   crypto_kx_SECRETKEYBYTES : constant := 32;  --  ./sodium/crypto_kx.h:19

   crypto_kx_SEEDBYTES : constant := 32;  --  ./sodium/crypto_kx.h:23

   crypto_kx_SESSIONKEYBYTES : constant := 32;  --  ./sodium/crypto_kx.h:27

   crypto_kx_PRIMITIVE : aliased constant String := "x25519blake2b" & ASCII.NUL;  --  ./sodium/crypto_kx.h:31

   function crypto_kx_publickeybytes return stddef_h.size_t  -- ./sodium/crypto_kx.h:17
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_publickeybytes";

   function crypto_kx_secretkeybytes return stddef_h.size_t  -- ./sodium/crypto_kx.h:21
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_secretkeybytes";

   function crypto_kx_seedbytes return stddef_h.size_t  -- ./sodium/crypto_kx.h:25
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_seedbytes";

   function crypto_kx_sessionkeybytes return stddef_h.size_t  -- ./sodium/crypto_kx.h:29
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_sessionkeybytes";

   function crypto_kx_primitive return Interfaces.C.Strings.chars_ptr  -- ./sodium/crypto_kx.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_primitive";

   function crypto_kx_seed_keypair
     (pk : access unsigned_char;
      sk : access unsigned_char;
      seed : access unsigned_char) return int  -- ./sodium/crypto_kx.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_seed_keypair";

   function crypto_kx_keypair (pk : access unsigned_char; sk : access unsigned_char) return int  -- ./sodium/crypto_kx.h:42
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_keypair";

   function crypto_kx_client_session_keys
     (rx : access unsigned_char;
      tx : access unsigned_char;
      client_pk : access unsigned_char;
      client_sk : access unsigned_char;
      server_pk : access unsigned_char) return int  -- ./sodium/crypto_kx.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_client_session_keys";

   function crypto_kx_server_session_keys
     (rx : access unsigned_char;
      tx : access unsigned_char;
      server_pk : access unsigned_char;
      server_sk : access unsigned_char;
      client_pk : access unsigned_char) return int  -- ./sodium/crypto_kx.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "crypto_kx_server_session_keys";

end crypto_kx_h;
