pragma Ada_2012;
with Interfaces.C; use Interfaces.C;
with Libsodium_Binding; use Libsodium_Binding;

package Libsodium_Interface
with SPARK_Mode
is
   Crypto_Error : exception;

   -----------------------
   -- Constants & Types --
   -----------------------
   Text_Max_Size : constant := 1000;
   Crypto_Generichash_BYTES         : constant := 32;
   Crypto_Generichash_KEYBYTES      : constant := 32;
   Crypto_Shorthash_BYTES    : constant := 8;
   Crypto_Shorthash_KEYBYTES : constant := 16;
   Crypto_Secretbox_KEYBYTES     : constant := 32;
   Crypto_Secretbox_NONCEBYTES   : constant := 24;
   Crypto_Secretbox_MACBYTES     : constant := 16;
   Crypto_Secretstream_ABYTES           : constant := 17;
   Crypto_Secretstream_HEADERBYTES      : constant := 24;
   Crypto_Secretstream_KEYBYTES         : constant := 32;
   Crypto_Auth_BYTES    : constant := 32;
   Crypto_Auth_KEYBYTES : constant := 32;
   Crypto_Box_SEEDBYTES      : constant := 32;
   Crypto_Box_PUBLICKEYBYTES : constant := 32;
   Crypto_Box_SECRETKEYBYTES : constant := 32;
   Crypto_Box_BEFORENMBYTES  : constant := 32;
   Crypto_Box_NONCEBYTES     : constant := 24;
   Crypto_Box_MACBYTES       : constant := 16;
   Crypto_Box_SEALBYTES : constant
     := Crypto_Box_PUBLICKEYBYTES + Crypto_Box_MACBYTES;
   Crypto_Sign_PUBLICKEYBYTES : constant := 32;
   Crypto_Sign_SECRETKEYBYTES : constant := 64;
   Crypto_Sign_BYTES          : constant := 64;
   Crypto_Sign_SEEDBYTES      : constant := 32;
   Crypto_Pwhash_SALTBYTES            : constant := 16;
   Crypto_Pwhash_STRBYTES             : constant := 128;
   Crypto_Pwhash_STRPREFIX            : constant String      := "$argon2i$";
   Crypto_Pwhash_OPSLIMIT_INTERACTIVE : constant := 4;
   Crypto_Pwhash_BYTES_MAX : constant := 4294967295;
   Crypto_Pwhash_BYTES_MIN : constant := 16;
   Crypto_Pwhash_PASSWD_MAX : constant := 4294967295;
   Crypto_Pwhash_PASSWD_MIN : constant := 0;
   Crypto_Pwhash_MEMLIMIT_INTERACTIVE : constant := 33554432;
   Crypto_Pwhash_OPSLIMIT_MODERATE    : constant := 6;
   Crypto_Pwhash_MEMLIMIT_MODERATE    : constant := 134217728;
   Crypto_Pwhash_OPSLIMIT_SENSITIVE   : constant := 8;
   Crypto_Pwhash_MEMLIMIT_SENSITIVE   : constant := 536870912;


   subtype Generichash_Fingerprint is Block8 (1 .. Crypto_Generichash_BYTES);
   subtype Generichash_Key is Block8 (1 .. Crypto_Generichash_KEYBYTES);

   subtype Shorthash_Fingerprint is Block8 (1 .. Crypto_Shorthash_BYTES);
   subtype Shorthash_Key is Block8 (1 .. Crypto_Shorthash_KEYBYTES);

   type Data_Sensitivity is ( interactive, moderate, sensitive);
   subtype Pwhash_Salt is Block8 (1 .. Crypto_Pwhash_SALTBYTES);
   subtype Pwhash_Key is Block8;
   subtype Password is Interfaces.C.Strings.chars_ptr;
   subtype Pwhash is Interfaces.C.Strings.chars_ptr;

   subtype Secretbox_Nonce is Block8 (1 .. Crypto_Secretbox_NONCEBYTES);
   subtype Secretbox_Mac is Block8 (1 .. Crypto_Secretbox_MACBYTES);
   subtype Secretbox_Key is Block8 (1 .. Crypto_Secretbox_KEYBYTES);

   subtype Header is Block8 (1 .. Crypto_Secretstream_HEADERBYTES);
   subtype Additionnal_Info is Block8;
   subtype Secretstream_Key is Block8 (1 .. Crypto_Secretstream_KEYBYTES);

   subtype Auth_Mac is Block8 (1 .. Crypto_Auth_BYTES);
   subtype Auth_Key is Block8 (1 .. Crypto_Auth_KEYBYTES);


   subtype Box_Mac is Block8 (1 .. Crypto_Box_MACBYTES);
   subtype Box_Secret_Key is Block8 (1 .. Crypto_Box_SECRETKEYBYTES);
   subtype Box_Public_Key is Block8 (1 .. Crypto_Box_PUBLICKEYBYTES);
   subtype Box_Key_Seed is Block8 (1 .. Crypto_Box_SEEDBYTES);
   subtype Box_Shared_Key is Block8 (1 .. Crypto_Box_BEFORENMBYTES);

   subtype Sign_Secret_Key is Block8 (1 .. Crypto_Sign_SECRETKEYBYTES);
   subtype Sign_Public_Key is Block8 (1 .. Crypto_Sign_PUBLICKEYBYTES);
   subtype Sign_Key_Seed is Block8 (1 .. Crypto_Sign_SEEDBYTES);
   subtype Signature is Block8 (1 .. Crypto_Sign_BYTES);

  ------------------
  -- Generic Hash -
  ------------------

   procedure Crypto_Generichash
     (FP :    out Generichash_Fingerprint;
      M  : in     Block8;
      K  : in     Generichash_Key);

   procedure Crypto_Generichash_Keyless
     (FP :    out Generichash_Fingerprint;
      M  : in     Block8);

   procedure Crypto_Generichash_Init
     (State :    out crypto_generichash_state;
      K     : in     Generichash_Key);

   procedure Crypto_Generichash_Init_Keyless
     (State : out crypto_generichash_state);

   procedure Crypto_Generichash_Update
     (State :    out crypto_generichash_state;
      M     : in     Block8);

   procedure Crypto_Generichash_Final
     (State :    out crypto_generichash_state;
      FP    : in     Generichash_Fingerprint);

   procedure Crypto_Generichash_Keygen (K : out Generichash_Key);

   -------------------------
   -- Short Hash --
   -------------------------

   procedure Crypto_Shorthash
     (FP : out Shorthash_Fingerprint;
      M : Block8;
      K : Shorthash_Key);

   procedure Crypto_Shorthash_Keygen (K : out Shorthash_Key);

   -------------------
   -- Password hash --
   -------------------

    procedure Crypto_Pwhash
     (K           :    out Pwhash_Key;
      Passwd      : in     Password;
      S       alt : in     Pwhash_Salt;
      Sensitivity : in     Data_Sensitivity := interactive)
     with
       Pre => Passwd'Length < Crypto_Pwhash_PASSWD_MAX
       and then Passwd'Length > Crypto_Pwhash_PASSWD_MIN
       and then K'Length < Crypto_Pwhash_BYTES_MAX
       and then K'Length > Crypto_Pwhash_BYTES_MIN;



   procedure Crypto_Pwhash_Str
     (H           :    out Pwhash;
      Passwd      : in     Password;
      Sensitivity : in     Data_Sensitivity := interactive)
     with
       Pre => Passwd'Length < Crypto_Pwhash_PASSWD_MAX
       and then Passwd'Length > Crypto_Pwhash_PASSWD_MIN
       and then H'Length > Crypto_Pwhash_STRBYTES;

   function Crypto_Pwhash_Str_Verify
     (H           : in Pwhash;
      Passwd      : in Password;
      Sensitivity : in Data_Sensitivity := interactive) return int
     with
       Pre => Passwd'Length < Crypto_Pwhash_PASSWD_MAX
       and then Passwd'Length > Crypto_Pwhash_PASSWD_MIN
       and then H'Length > Crypto_Pwhash_STRBYTES;

   ----------------
   -- Secret box --
   ----------------

   procedure Crypto_Secretbox_Easy
     (C :    out Block8;
      M : in     Block8;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length + Crypto_Secretbox_MACBYTES;

   procedure Crypto_Secretbox_Open_Easy
     (M :    out Block8;
      C : in     Block8;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length + Crypto_Secretbox_MACBYTES;

   procedure Crypto_Secretbox_Detached
     (C   :    out Block8;
      Mac :    out Secretbox_Mac;
      M   : in     Block8;
      N   : in     Secretbox_Nonce;
      K   : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length;

   procedure Crypto_Secretbox_Open_Detached
     (M   :    out Block8;
      C   : in     Block8;
      Mac : in     Secretbox_Mac;
      N   : in     Secretbox_Nonce;
      K   : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length;

   procedure Crypto_Secretbox_Keygen (K : out Secretbox_Key);

   -------------------
   -- Secret stream --
   -------------------

   procedure Crypto_Secretstream_Keygen (K : out Secretstream_Key);

   procedure Crypto_Secretstream_Init_Push
     (State  :     out crypto_secretstream_state;
      H      :     out Header;
      K      : in      Secretstream_Key);

   procedure Crypto_Secretstream_Push
     (State : in out crypto_secretstream_state;
      C     :    out Block8;
      M     : in     Block8;
      AD    : in     Additionnal_Info;
      Tag   : in     uint8)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Adless_Push
     (State : in out crypto_secretstream_state;
      C     :    out Block8;
      M     : in     Block8;
      Tag   : in     uint8)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Init_Pull
     (State  :    out crypto_secretstream_state;
      H      : in     Header;
      K      : in     Secretstream_Key);

   procedure Crypto_Secretstream_Pull
     (State : in out crypto_secretstream_state;
      M     :    out Block8;
      Tag   : in     uint8;
      C     : in     Block8;
      AD    : in     Additionnal_Info)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Adless_Pull
     (State : in out crypto_secretstream_state;
      M     :    out Block8;
      Tag   : in     uint8;
      C     : in     Block8)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Rekey
     (State : in out crypto_secretstream_state);

   ---------------------------
   -- Crypto Authentication --
   ---------------------------

   procedure Crypto_Auth
     (Mac :    out Auth_Mac;
      M   : in     Block8;
      K   : in     Auth_Key);

   function Crypto_Auth_Verify
     (H : in Auth_Mac;
      M : in Block8;
      K : in Auth_Key) return int;

   procedure Crypto_Auth_Keygen (K : out Auth_Key);

   ----------------
   -- Crypto Box --
   ----------------

   procedure Crypto_Box_Seed_Keypair
     (PK   :    out Box_Public_Key;
      SK   :    out Box_Secret_Key;
      Seed : in     Box_Key_Seed);

   procedure Crypto_Box_Keypair (pk : out Box_Public_Key;
                                 sk : out Box_Secret_Key);

   procedure Crypto_Box_Easy
     (C  :    out Block8;
      M  : in     Block8;
      N  : in     Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES;

   procedure Crypto_Box_Open_Easy
     (M  :    out Block8;
      C  : in     Block8;
      N  : in     Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
      with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES;

   procedure Crypto_Box_Detached
     (C   :    out Block8;
      Mac :    out Box_Mac;
      M   : in     Block8;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Secret_Key)
     with
       Pre => C'Length = M'Length;

   procedure Crypto_Box_Open_Detached
     (M   :    out Block8;
      C   : in     Block8;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Public_Key)
     with
       Pre => C'Length = M'Length;

   procedure Crypto_Box_Beforenm
     (K  :    out Box_Shared_Key;
      PK : in     Box_Secret_Key;
      SK : in     Box_Secret_Key);

   procedure Crypto_Box_Easy_Afternm
     (C :    out Block8;
      M : in     Block8;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES;

   procedure Crypto_Box_Open_Easy_Afternm
     (M :    out Block8;
      C : in     Block8;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES;

   procedure Crypto_Box_Detached_Afternm
     (C   :    out Block8;
      Mac :    out Box_Mac;
      M   : in     Block8;
      N   : in     Box_Nonce;
      K   : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length;

   procedure Crypto_Box_Open_Detached_Afternm
     (M   :    out Block8;
      C   : in     Block8;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      K   : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length;

   ----------------
   -- Sealed Box --
   ----------------
   -- PK et SK appartiennent au récepteur. Sender génère pk' et sk' et met pk'
   -- dans son message
   procedure Crypto_Box_Seal
     (C  :    out Block8;
      M  : in     Block8;
      PK : in     Box_Public_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_SEALBYTES;

   procedure Crypto_Box_Seal_Open
     (M  :    out Block8;
      C  : in     Block8;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
   with
       Pre => C'Length = M'Length + Crypto_Box_SEALBYTES;

   -----------------
   -- Crypto Sign --
   -----------------

   procedure Crypto_Sign_Seed_Keypair
     (PK   :    out Sign_Public_Key;
      SK   :    out Sign_Secret_Key;
      Seed : in     Sign_Key_Seed);

   procedure Crypto_Sign_Keypair (PK : out Sign_Public_Key;
                                  SK : out Sign_Secret_Key);

   procedure Crypto_Sign
     (SM :    out Block8;
      M  : in     Block8;
      SK : in     Sign_Secret_Key)
     with
       Pre => SM'Length = M'Length + Crypto_Sign_BYTES;

   procedure Crypto_Sign_Open
     (M  :    out Block8;
      SM : in     Block8;
      PK : in     Sign_Public_Key)
     with
       Pre => SM'Length = M'Length + Crypto_Sign_BYTES;

   procedure Crypto_Sign_Detached
     (Sig :    out Signature;
      M   : in     Block8;
      SK  : in     Sign_Secret_Key);

   function Crypto_Sign_Verify_Detached
     (Sig : in Signature;
      M   : in Block8;
      PK  : in Sign_Public_Key) return int;

   procedure Crypto_Sign_Init (state : out crypto_sign_state);

   procedure Crypto_Sign_Update
     (State : in out crypto_sign_state;
      M     : in     Block8);

   procedure Crypto_Sign_Final_Create
     (State : in     crypto_sign_state;
      Sig   :    out Signature;
      SK    : in     Sign_Secret_Key);

   function Crypto_Sign_Final_Verify
     (State : in crypto_sign_state;
      Sig   : in Signature;
      PK    : in Sign_Public_Key) return int;

   procedure Crypto_Sign_SK_to_Seed (Seed : out Sign_Key_Seed;
                                     SK : in Sign_Secret_Key);

   procedure Crypto_Sign_SK_to_PK (PK : out Sign_Public_Key;
                                   SK : in Sign_Secret_Key);


end Libsodium_Interface;
