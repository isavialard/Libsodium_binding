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
   Padding_MAXBYTES : constant := 1000;
   Randombytes_SEEDBYTES : constant := 32;
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
   Crypto_Pwhash_ALG                  : constant := 1;
   Crypto_Pwhash_SALTBYTES            : constant := 16;
   Crypto_Pwhash_STRBYTES             : constant := 128;
   Crypto_Pwhash_STRPREFIX            : constant String := "$argon2i$";
   Crypto_Pwhash_BYTES_MAX            : constant := 4294967295;
   Crypto_Pwhash_BYTES_MIN            : constant := 16;
   Crypto_Pwhash_PASSWD_MAX           : constant := 4294967295;
   Crypto_Pwhash_PASSWD_MIN           : constant := 0;
   Crypto_Pwhash_OPSLIMIT_INTERACTIVE : constant := 4;
   Crypto_Pwhash_MEMLIMIT_INTERACTIVE : constant := 33554432;
   Crypto_Pwhash_OPSLIMIT_MODERATE    : constant := 6;
   Crypto_Pwhash_MEMLIMIT_MODERATE    : constant := 134217728;
   Crypto_Pwhash_OPSLIMIT_SENSITIVE   : constant := 8;
   Crypto_Pwhash_MEMLIMIT_SENSITIVE   : constant := 536870912;
   Crypto_Kx_PUBLICKEYBYTES  : constant := 32;
   Crypto_Kx_SECRETKEYBYTES  : constant := 32;
   Crypto_Kx_SEEDBYTES       : constant := 32;
   Crypto_Kx_SESSIONKEYBYTES : constant := 32;
   Crypto_Kx_PRIMITIVE       : constant String := "x25519blake2b" & ASCII.NUL;

   subtype Random_Seed is Block8 (1 .. Randombytes_SEEDBYTES);

   subtype Generichash_Fingerprint is Block8 (1 .. Crypto_Generichash_BYTES);
   subtype Generichash_Key is Block8 (1 .. Crypto_Generichash_KEYBYTES);

   subtype Shorthash_Fingerprint is Block8 (1 .. Crypto_Shorthash_BYTES);
   subtype Shorthash_Key is Block8 (1 .. Crypto_Shorthash_KEYBYTES);

   type Data_Sensitivity is (interactive, moderate, sensitive);
   subtype Pwhash_Salt is Block8 (1 .. Crypto_Pwhash_SALTBYTES);
   subtype Pwhash_Key is Block8;
   subtype Password is Libsodium_Binding.String;
   subtype Pwhash is Libsodium_Binding.String;

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
   subtype Box_Nonce is Block8 (1 .. Crypto_Box_NONCEBYTES);

   subtype Sign_Secret_Key is Block8 (1 .. Crypto_Sign_SECRETKEYBYTES);
   subtype Sign_Public_Key is Block8 (1 .. Crypto_Sign_PUBLICKEYBYTES);
   subtype Sign_Key_Seed is Block8 (1 .. Crypto_Sign_SEEDBYTES);
   subtype Signature is Block8 (1 .. Crypto_Sign_BYTES);

   subtype Kx_Secret_Key is Block8 (1 .. Crypto_Kx_SECRETKEYBYTES);
   subtype Kx_Public_Key is Block8 (1 .. Crypto_Kx_PUBLICKEYBYTES);
   subtype Kx_Key_Seed is Block8 (1 .. Crypto_Kx_SEEDBYTES);
   subtype Kx_Session_Key is Block8 (1 .. Crypto_Kx_SESSIONKEYBYTES);

   subtype Plain_Text is Block8;
   subtype Cipher_Text is Block8;

   ----------
   -- Init --
   ----------

   procedure Sodium_Init;

   -------------
   -- Padding --
   -------------
   function Sodium_Pad_Length
     (Buflen    : in uint64;
      Blocksize : in uint64) return Integer
     with Pre => Buflen + Blocksize < Padding_MAXBYTES,
     Post => uint64 (Sodium_Pad_Length'Result) + Blocksize
     < Padding_MAXBYTES;

   function Sodium_Pad
     (Buf       : in Plain_Text;
      Blocksize : in uint64) return Plain_Text
     with Pre => Buf'Length + Blocksize < Padding_MAXBYTES;

   function Sodium_Unpad
     (Buf       : Plain_Text;
      Blocksize : uint64) return Plain_Text;

   ------------
   -- Random --
   ------------

   procedure Randombytes (Buf : out Block8);

   procedure Randombytes_Seed
     (Buf  :    out Block8;
      Seed : in     Random_Seed);

   ------------------------------
   -- Constant time comparison --
   ------------------------------

   function Constant_Time_Cmp
     (b1 : in Block8;
      b2 : in Block8) return int
     with
       Pre => b1'Length = b2'Length;

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
     (State : in out crypto_generichash_state;
      M     : in     Block8);

   procedure Crypto_Generichash_Final
     (State : in out crypto_generichash_state;
      FP    :    out Generichash_Fingerprint);

   procedure Crypto_Generichash_Key (K : out Generichash_Key);

   -------------------------
   -- Short Hash --
   -------------------------

   procedure Crypto_Shorthash
     (FP :    out Shorthash_Fingerprint;
      M  : in     Block8;
      K  : in     Shorthash_Key);

   procedure Crypto_Shorthash_Key (K : out Shorthash_Key);

   -------------------
   -- Password hash --
   -------------------

   procedure Crypto_Pwhash
     (K           :    out Pwhash_Key;
      Passwd      : in     Password;
      Salt        : in     Pwhash_Salt;
      Sensitivity : in     Data_Sensitivity := interactive)
     with
       Pre => Passwd'Length <= Crypto_Pwhash_PASSWD_MAX
       and then Passwd'Length >= Crypto_Pwhash_PASSWD_MIN
       and then K'Length <= Crypto_Pwhash_BYTES_MAX
       and then K'Length >= Crypto_Pwhash_BYTES_MIN;

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
      Passwd      : in Password) return int
     with
       Pre => Passwd'Length < Crypto_Pwhash_PASSWD_MAX
       and then Passwd'Length > Crypto_Pwhash_PASSWD_MIN
       and then H'Length > Crypto_Pwhash_STRBYTES;

   ----------------
   -- Secret box --
   ----------------

   procedure Crypto_Secretbox_Easy
     (C :    out Cipher_Text;
      M : in     Plain_Text;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length + Crypto_Secretbox_MACBYTES
       and then Is_Signed (M);

   procedure Crypto_Secretbox_Open_Easy
     (M :    out Plain_Text;
      C : in     Cipher_Text;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length + Crypto_Secretbox_MACBYTES,
       Post => Is_Signed (M);

   procedure Crypto_Secretbox_Detached
     (C   :    out Cipher_Text;
      Mac :    out Secretbox_Mac;
      M   : in     Plain_Text;
      N   : in     Secretbox_Nonce;
      K   : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length
       and then Is_Signed (M);

   procedure Crypto_Secretbox_Open_Detached
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Secretbox_Mac;
      N   : in     Secretbox_Nonce;
      K   : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length,
       Post => Is_Signed (M);

   procedure Crypto_Secretbox_Key (K : out Secretbox_Key);

   -------------------
   -- Secret stream --
   ------------------- No idea if I should put Is_Signed on this one. Is each part signed, or is it the message as a whole. MB put only condition in Post

   procedure Crypto_Secretstream_Key (K : out Secretstream_Key);

   procedure Crypto_Secretstream_Init_Push
     (State  :     out crypto_secretstream_state;
      H      :     out Header;
      K      : in      Secretstream_Key);

   procedure Crypto_Secretstream_Push
     (State : in out crypto_secretstream_state;
      C     :    out Cipher_Text;
      M     : in     Plain_Text;
      AD    : in     Additionnal_Info;
      Tag   : in     uint8)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Adless_Push
     (State : in out crypto_secretstream_state;
      C     :    out Cipher_Text;
      M     : in     Plain_Text;
      Tag   : in     uint8)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Init_Pull
     (State  :    out crypto_secretstream_state;
      H      : in     Header;
      K      : in     Secretstream_Key);

   procedure Crypto_Secretstream_Pull
     (State : in out crypto_secretstream_state;
      M     :    out Plain_Text;
      Tag   : in     uint8;
      C     : in     Cipher_Text;
      AD    : in     Additionnal_Info)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Adless_Pull
     (State : in out crypto_secretstream_state;
      M     :    out Plain_Text;
      Tag   : in     uint8;
      C     : in     Cipher_Text)
     with
       Pre => C'Length = M'Length + Crypto_Secretstream_ABYTES;

   procedure Crypto_Secretstream_Rekey
     (State : in out crypto_secretstream_state);

   ---------------------------
   -- Crypto Authentication --
   ---------------------------

   procedure Crypto_Auth
     (Mac :    out Auth_Mac;
      M   : in     Plain_Text;
      K   : in     Auth_Key);

   function Crypto_Auth_Verify
     (H : in Auth_Mac;
      M : in Plain_Text;
      K : in Auth_Key) return int;

   procedure Crypto_Auth_Key (K : out Auth_Key);

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
     (C  :    out Cipher_Text;
      M  : in     Plain_Text;
      N  : in     Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES
       and then Is_Signed (M);

   procedure Crypto_Box_Open_Easy
     (M  :    out Plain_Text;
      C  : in     Cipher_Text;
      N  : in     Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
      with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES,
       Post => Is_Signed (M);

   procedure Crypto_Box_Detached
     (C   :    out Cipher_Text;
      Mac :    out Box_Mac;
      M   : in     Plain_Text;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Secret_Key)
     with
       Pre => C'Length = M'Length
       and then Is_Signed (M);

   procedure Crypto_Box_Open_Detached
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Public_Key)
     with
       Pre => C'Length = M'Length,
       Post => Is_Signed (M);

   procedure Crypto_Box_Beforenm
     (K  :    out Box_Shared_Key;
      PK : in     Box_Secret_Key;
      SK : in     Box_Secret_Key);

   procedure Crypto_Box_Easy_Afternm
     (C :    out Cipher_Text;
      M : in     Plain_Text;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES
       and then Is_Signed (M);

   procedure Crypto_Box_Open_Easy_Afternm
     (M :    out Plain_Text;
      C : in     Cipher_Text;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES,
       Post => Is_Signed (M);

   procedure Crypto_Box_Detached_Afternm
     (C   :    out Cipher_Text;
      Mac :    out Box_Mac;
      M   : in     Plain_Text;
      N   : in     Box_Nonce;
      K   : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length
       and then Is_Signed (M);

   procedure Crypto_Box_Open_Detached_Afternm
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      K   : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length,
       Post => Is_Signed (M);

   ----------------
   -- Sealed Box --
   ----------------

   procedure Crypto_Box_Seal
     (C  :    out Cipher_Text;
      M  : in     Plain_Text;
      PK : in     Box_Public_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_SEALBYTES;

   procedure Crypto_Box_Seal_Open
     (M  :    out Plain_Text;
      C  : in     Cipher_Text;
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
     (SM :    out Plain_Text;
      M  : in     Plain_Text;
      SK : in     Sign_Secret_Key)
     with
       Pre => SM'Length = M'Length + Crypto_Sign_BYTES,
       Post => Is_Signed (SM);

   procedure Crypto_Sign_Open
     (M  :    out Plain_Text;
      SM : in     Plain_Text;
      PK : in     Sign_Public_Key)
     with
       Pre => SM'Length = M'Length + Crypto_Sign_BYTES
          and then Is_Signed (SM);

   procedure Crypto_Sign_Detached
     (Sig :    out Signature;
      M   : in     Plain_Text;
      SK  : in     Sign_Secret_Key);

   function Crypto_Sign_Verify_Detached
     (Sig : in Signature;
      M   : in Plain_Text;
      PK  : in Sign_Public_Key) return int;

   procedure Crypto_Sign_Init (state : out crypto_sign_state);

   procedure Crypto_Sign_Update
     (State : in out crypto_sign_state;
      M     : in     Plain_Text);

   procedure Crypto_Sign_Final_Create
     (State : in out     crypto_sign_state;
      Sig   :    out Signature;
      SK    : in     Sign_Secret_Key);

   procedure Crypto_Sign_Final_Verify
     (State : in out crypto_sign_state;
      Sig   : in Signature;
      PK    : in Sign_Public_Key);

   procedure Crypto_Sign_SK_to_Seed (Seed : out Sign_Key_Seed;
                                     SK : in Sign_Secret_Key);

   procedure Crypto_Sign_SK_to_PK (PK : out Sign_Public_Key;
                                   SK : in Sign_Secret_Key);

   ------------------
   -- Key exchange --
   ------------------

   procedure Crypto_Kx_Seed_Keypair
     (PK   :    out Kx_Public_Key;
      SK   :    out Kx_Secret_Key;
      Seed : in     Kx_Key_Seed);

   procedure Crypto_Kx_Keypair (PK : out Kx_Public_Key;
                                SK : out Kx_Secret_Key);

   procedure Crypto_Kx_Client_Session_Keys
     (RX        :    out Kx_Session_Key;
      TX        :    out Kx_Session_Key;
      Client_PK : in     Kx_Public_Key;
      Client_SK : in     Kx_Secret_Key;
      Server_PK : in     Kx_Public_Key);

   procedure Crypto_Kx_Server_Session_Keys
     (RX        :    out Kx_Session_Key;
      TX        :    out Kx_Session_Key;
      Server_PK : in     Kx_Public_Key;
      Server_SK : in     Kx_Secret_Key;
      Client_PK : in     Kx_Public_Key);

   ---------------------
   -- Ghost functions --
   ---------------------

   function Is_Signed          (M : Plain_Text) return Boolean with Ghost;
   function Never_Used_Yet     (N : Block8)      return Boolean with Ghost;

private
   pragma SPARK_Mode (Off);

   --  Properties are intentionally hidden from SPARK analysis under SPARK_Mode
   --  Off. This ensures that proof considers them as black boxes.

   function Is_Signed          (M : Plain_Text) return Boolean is (True);
   function Never_Used_Yet     (N : Block8)      return Boolean is (True);


end Libsodium_Interface;
