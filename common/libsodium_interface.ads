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
   Padding_MAXBYTES : constant := MAX_BYTES;

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
   Crypto_Kx_SESSIONKEYBYTES : constant uint64 := 32;
   Crypto_Kx_PRIMITIVE       : constant String := "x25519blake2b" & ASCII.NUL;

   Crypto_Kdf_BYTES_MIN    : constant := 16;
   Crypto_Kdf_BYTES_MAX    : constant := 64;
   Crypto_Kdf_CONTEXTBYTES : constant := 8;
   Crypto_Kdf_KEYBYTES     : constant := 32;

   type Random_Seed is new Block8 (1 .. Randombytes_SEEDBYTES);

   type Generichash_Fingerprint is new Block8 (1 .. Crypto_Generichash_BYTES);
   type Generichash_Key is new Block8 (1 .. Crypto_Generichash_KEYBYTES);

   type Shorthash_Fingerprint is new Block8 (1 .. Crypto_Shorthash_BYTES);
   type Shorthash_Key is new Block8 (1 .. Crypto_Shorthash_KEYBYTES);

   type Data_Sensitivity is (interactive, moderate, sensitive);
   type Pwhash_Salt is new Block8 (1 .. Crypto_Pwhash_SALTBYTES);
   type Pwhash_Key is new Block8;
   type Password is new Libsodium_Binding.String;
   type Pwhash is new Libsodium_Binding.String;

   type Secretbox_Nonce is limited private;
   type Secretbox_Mac is new Block8 (1 .. Crypto_Secretbox_MACBYTES);
   type Secretbox_Key is new Block8 (1 .. Crypto_Secretbox_KEYBYTES);

   type Header is new Block8 (1 .. Crypto_Secretstream_HEADERBYTES);
   type Additionnal_Info is new Block8;
   Null_AD :  constant Additionnal_Info (1 .. 0) := (others => 0);
   type Secretstream_Key is new Block8 (1 .. Crypto_Secretstream_KEYBYTES);

   type Auth_Mac is new Block8 (1 .. Crypto_Auth_BYTES);
   type Auth_Key is new Block8 (1 .. Crypto_Auth_KEYBYTES);

   type Box_Mac is new Block8 (1 .. Crypto_Box_MACBYTES);
   type Box_Secret_Key is new Block8 (1 .. Crypto_Box_SECRETKEYBYTES);
   type Box_Public_Key is new Block8 (1 .. Crypto_Box_PUBLICKEYBYTES);
   type Box_Key_Seed is new Block8 (1 .. Crypto_Box_SEEDBYTES);
   type Box_Shared_Key is new Block8 (1 .. Crypto_Box_BEFORENMBYTES);
   type Box_Nonce is limited private;

   type Sign_Secret_Key is new Block8 (1 .. Crypto_Sign_SECRETKEYBYTES);
   type Sign_Public_Key is new Block8 (1 .. Crypto_Sign_PUBLICKEYBYTES);
   type Sign_Key_Seed is new Block8 (1 .. Crypto_Sign_SEEDBYTES);
   type Signature is new Block8 (1 .. Crypto_Sign_BYTES);

   type Kx_Secret_Key is new Block8 (1 .. Crypto_Kx_SECRETKEYBYTES);
   type Kx_Public_Key is new Block8 (1 .. Crypto_Kx_PUBLICKEYBYTES);
   type Kx_Key_Seed is new Block8 (1 .. Crypto_Kx_SEEDBYTES);
   type Kx_Session_Key is new Block8 (1 .. Crypto_Kx_SESSIONKEYBYTES);

   type Plain_Text is new Block8;
   type Cipher_Text is new Block8;

   type Kdf_Key is new Block8 (1 .. Crypto_Kdf_KEYBYTES);
   type Kdf_Context is new Libsodium_Binding.String (1 .. Crypto_Kdf_CONTEXTBYTES);
   ----------
   -- Init --
   ----------

   procedure Sodium_Init;

   -------------
   -- Padding --
   -------------
   function Sodium_Pad_Length
     (Buflen    : in uint64;
      Blocksize : in uint64) return uint64
     with
       Pre => Buflen > 0
       and then Blocksize > 0
       and then Blocksize <= 512
       and then Buflen + Blocksize < Padding_MAXBYTES,
       Post => Sodium_Pad_Length'Result < Padding_MAXBYTES;

   function Sodium_Unpad_Length
     (Buf    : in Plain_Text) return uint64
     with
       Pre => Buf'Length < Padding_MAXBYTES,
       Post => Sodium_Unpad_Length'Result < MAX_BYTES;

   procedure Sodium_Pad
     (Padded_Buf :    out Plain_Text;
      Buf        : in     Plain_Text;
      Blocksize  : in     uint64)
     with
       Pre => Blocksize <= 512
       and then Blocksize > 0
       and then Buf'Length > 0
       and then Buf'Length + Blocksize < Padding_MAXBYTES
       and then Padded_Buf'Length = Sodium_Pad_Length (Buf'Length, Blocksize),
       Post => Buf'Length = Sodium_Unpad_Length (Padded_Buf);

   procedure Sodium_Unpad
     (Buf        :    out Plain_Text;
      Padded_Buf : in     Plain_Text;
      Blocksize  : in     uint64)
     with
       Pre => Blocksize <= 512
       and then Blocksize > 0
       and then Padded_Buf'Length < Padding_MAXBYTES
       and then Buf'Length = Sodium_Unpad_Length (Padded_Buf);

   ------------
   -- Random --
   ------------

   procedure Randombytes (Buf : out Block8);

   procedure Randombytes (Buf : out Plain_Text)
     with
       Post => Is_Signed (Buf);

   procedure Randombytes (Buf : out Box_Nonce)
     with
   Post => Never_Used_Yet(Buf);

   procedure Randombytes (Buf : out Secretbox_Nonce)
     with
   Post => Never_Used_Yet(Buf);

   procedure Randombytes (Buf : out Random_Seed);

   procedure Randombytes (Buf : out Pwhash_Salt);

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
      N : in out Secretbox_Nonce;
      K : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length + Crypto_Secretbox_MACBYTES
       and then Never_Used_Yet (N);

   procedure Crypto_Secretbox_Open_Easy
     (M :    out Plain_Text;
      C : in     Cipher_Text;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length + Crypto_Secretbox_MACBYTES;

   procedure Crypto_Secretbox_Detached
     (C   :    out Cipher_Text;
      Mac :    out Secretbox_Mac;
      M   : in     Plain_Text;
      N   : in out Secretbox_Nonce;
      K   : in     Secretbox_Key)
     with
       Pre => C'Length = M'Length
       and then Never_Used_Yet (N);

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
      Tag   : in     uint8;
      AD    : in     Additionnal_Info := Null_AD)
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
      AD    : in     Additionnal_Info := Null_AD)
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
      N  : in out Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES
       and then Is_Signed (M)
       and then Never_Used_Yet (N);

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
      N   : in out Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Secret_Key)
     with
       Pre => C'Length = M'Length
       and then Never_Used_Yet (N)
       and then Is_Signed (M);

   procedure Crypto_Box_Open_Detached
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Secret_Key)
     with
       Pre => C'Length = M'Length,
       Post => Is_Signed (M);

   procedure Crypto_Box_Beforenm
     (K  :    out Box_Shared_Key;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key);

   procedure Crypto_Box_Easy_Afternm
     (C :    out Cipher_Text;
      M : in     Plain_Text;
      N : in out Box_Nonce;
      K : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length + Crypto_Box_MACBYTES
       and then Never_Used_Yet (N)
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
      N   : in out Box_Nonce;
      K   : in     Box_Shared_Key)
     with
       Pre => C'Length = M'Length
       and then Never_Used_Yet (N)
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

   --------------------
   -- Key Derivation --
   --------------------

   procedure Crypto_Kdf_Derive_From_Key
     (Subkey  :    out Block8;
      ID      : in     uint64;
      Context : in     Kdf_Context := "Context ";
      Key     : in     Kdf_Key)
     with
       Pre => Subkey'Length >= Crypto_Kdf_BYTES_MIN
       and then Subkey'Length <= Crypto_Kdf_BYTES_MAX;

   procedure Crypto_Kdf_Key (K : out Kdf_Key);

   ---------------------
   -- Ghost functions --
   ---------------------

   function Is_Signed          (M : Plain_Text)      return Boolean with Ghost;
   function Never_Used_Yet     (N : Box_Nonce)       return Boolean with Ghost;
   function Never_Used_Yet     (N : Secretbox_Nonce) return Boolean with Ghost;

private
   pragma SPARK_Mode (Off);

   type Box_Nonce is new Block8 (1 .. Crypto_Box_NONCEBYTES);
   type Secretbox_Nonce is new Block8 (1 .. Crypto_Secretbox_NONCEBYTES);

   --  Properties are intentionally hidden from SPARK analysis under SPARK_Mode
   --  Off. This ensures that proof considers them as black boxes.

   function Is_Signed          (M : Plain_Text)      return Boolean is (True);
   function Never_Used_Yet     (N : Box_Nonce)       return Boolean is (True);
   function Never_Used_Yet     (N : Secretbox_Nonce) return Boolean is (True);



end Libsodium_Interface;
