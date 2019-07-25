
package body Libsodium_Interface is

   ----------
   -- Init --
   ----------

   procedure Sodium_Init
   is
   begin
      if sodium_init = -1 then
         raise Crypto_Error;
      end if;
   end Sodium_Init;

   -------------
   -- Padding --
   -------------

   function Sodium_Pad_Length
     (Buflen    : in uint64;
      Blocksize : in uint64) return Integer
   is
      Q : uint64;
   begin
      Q := Buflen / Blocksize;
      return Integer ((Q + 1) * Blocksize);
   end Sodium_Pad_Length;

   function Sodium_Pad
     (Buf       : in Plain_Text;
      Blocksize : in uint64) return Plain_Text
   is
      Huge_Buf : Block8 (Buf'First .. Buf'First + Padding_MAXBYTES - 1);
      Padded_Length : Integer;
   begin
      for I in Buf'First .. Buf'Last loop
         Huge_Buf (I) := Buf (I);
      end loop;
      if sodium_pad (uint64 (Padded_Length), Huge_Buf, Buf'Length, Blocksize,
                     Padding_MAXBYTES) /= 0
      then
         raise Crypto_Error;
      end if;
      return Huge_Buf (Buf'First .. Buf'First + Padded_Length - 1);
   end Sodium_Pad;

   function Sodium_Unpad
     (Buf       : Plain_Text;
      Blocksize : uint64) return Plain_Text
   is
      Unpadded_Length : Integer;
   begin
      if sodium_unpad (uint64 (Unpadded_Length), Buf, Buf'Length,
                       Blocksize) /= 0
      then
         raise Crypto_Error;
      end if;
      return Buf (Buf'First .. Buf'First + Unpadded_Length - 1);
   end Sodium_Unpad;

   ------------
   -- Random --
   ------------

   procedure Randombytes (Buf : out Block8)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf (Buf, Buflen);
   end Randombytes;

   procedure Randombytes_Seed
     (Buf  :    out Block8;
      Seed : in     Random_Seed)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf_deterministic (Buf, Buflen, Seed);
   end Randombytes_Seed;

   ------------------------------
   -- Constant time comparison --
   ------------------------------

   function Constant_Time_Cmp
     (b1 : in Block8;
      b2 : in Block8) return int
   is
   begin
      return sodium_memcmp (b1, b2, b1'Length);
   end Constant_Time_Cmp;

  ------------------
  -- Generic Hash -
  ------------------
   procedure Crypto_Generichash
     (FP :    out Generichash_Fingerprint;
      M  : in     Block8;
      K  : in     Generichash_Key)
   is
      FPlen : constant uint8 := FP'Length;
   begin
      if crypto_generichash (FP,
                                               FPlen,
                                               M,
                                               M'Length,
                                               K,
                                               K'Length) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash;

   procedure Crypto_Generichash_Keyless
     (FP :    out Generichash_Fingerprint;
      M  : in     Block8)
   is
      FPlen : constant uint8 := FP'Length;
      K :  constant Block8 (1 .. 0) := (others => 0);
   begin
      if crypto_generichash (FP, FPlen, M, M'Length, K, 0) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Keyless;

   procedure Crypto_Generichash_Init
     (State :    out crypto_generichash_state;
      K     : in     Generichash_Key)
   is
   begin
      if crypto_generichash_init (State,
                                                    K,
                                                    K'Length,
                                                    Crypto_Generichash_BYTES)
        /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Init;

   procedure Crypto_Generichash_Init_Keyless
     (State : out crypto_generichash_state)
   is
      K :  constant Block8 (1 .. 0) := (others => 0);
   begin
      if crypto_generichash_init (State,
                                                    K,
                                                    0,
                                                    Crypto_Generichash_BYTES)
        /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Init_Keyless;

   procedure Crypto_Generichash_Update
     (State : in out crypto_generichash_state;
      M     : in     Block8)
   is
   begin
      if crypto_generichash_update (State,
                                                      M,
                                                      M'Length) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Update;

   procedure Crypto_Generichash_Final
     (State : in out crypto_generichash_state;
      FP    :    out Generichash_Fingerprint)
   is
      FPlen : constant uint8 := FP'Length;
   begin
      if crypto_generichash_final (State,
                                                     FP,
                                                     FPlen) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Final;

   procedure Crypto_Generichash_Key (K : out Generichash_Key)
   is
   begin
      crypto_generichash_keygen (K);
   end Crypto_Generichash_Key;

   -------------------------
   -- Short Hash --
   -------------------------

   procedure Crypto_Shorthash
     (FP :    out Shorthash_Fingerprint;
      M  : in     Block8;
      K  : in     Shorthash_Key)
   is
   begin
      if crypto_shorthash (FP, M, M'Length, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Shorthash;

   procedure Crypto_Shorthash_Key (K : out Shorthash_Key)
   is
   begin
      crypto_shorthash_keygen (K);
   end Crypto_Shorthash_Key;

   -------------------
   -- Password hash --
   -------------------

   procedure Crypto_Pwhash
     (K           :    out Pwhash_Key;
      Passwd      : in     Password;
      Salt : in     Pwhash_Salt;
      Sensitivity : in     Data_Sensitivity := interactive)
     is
      opslimit         : uint64;
      memlimit         : uint64;
      Klen : constant uint64 := K'Length;

   begin
      case Sensitivity is
         when interactive =>
            opslimit := Crypto_Pwhash_OPSLIMIT_INTERACTIVE;
            memlimit := Crypto_Pwhash_MEMLIMIT_INTERACTIVE;
         when moderate =>
            opslimit := Crypto_Pwhash_OPSLIMIT_MODERATE;
            memlimit := Crypto_Pwhash_MEMLIMIT_MODERATE;
         when sensitive =>
            opslimit := Crypto_Pwhash_OPSLIMIT_SENSITIVE;
            memlimit := Crypto_Pwhash_MEMLIMIT_SENSITIVE;
      end case;
      if crypto_pwhash (K, Klen, Passwd, Passwd'Length, Salt,
                                          opslimit, memlimit,
                                          Crypto_Pwhash_ALG) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Pwhash;

   procedure Crypto_Pwhash_Str
     (H           :    out Pwhash;
      Passwd      : in     Password;
      Sensitivity : in     Data_Sensitivity := interactive)
   is
      opslimit  : uint64;
      memlimit  : uint64;
   begin
      case Sensitivity is
         when interactive =>
            opslimit := Crypto_Pwhash_OPSLIMIT_INTERACTIVE;
            memlimit := Crypto_Pwhash_MEMLIMIT_INTERACTIVE;
         when moderate =>
            opslimit := Crypto_Pwhash_OPSLIMIT_MODERATE;
            memlimit := Crypto_Pwhash_MEMLIMIT_MODERATE;
         when sensitive =>
            opslimit := Crypto_Pwhash_OPSLIMIT_SENSITIVE;
            memlimit := Crypto_Pwhash_MEMLIMIT_SENSITIVE;
      end case;
      if crypto_pwhash_str (H, Passwd, Passwd'Length,
                                              opslimit, memlimit) /= 0
      then
            raise Crypto_Error;
      end if;
   end Crypto_Pwhash_Str;

   function Crypto_Pwhash_Str_Verify
     (H           : in Pwhash;
      Passwd      : in Password) return int
   is
   begin
      return crypto_pwhash_str_verify (H, Passwd,
                                                         Passwd'Length);
   end Crypto_Pwhash_Str_Verify;

   ----------------
   -- Secret box --
   ----------------

   procedure Crypto_Secretbox_Easy
     (C :    out Cipher_Text;
      M : in     Plain_Text;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_easy (C, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Easy;

   procedure Crypto_Secretbox_Open_Easy
     (M :    out Plain_Text;
      C : in     Cipher_Text;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_open_easy (M, C, C'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Open_Easy;

   procedure Crypto_Secretbox_Detached
     (C   :    out Cipher_Text;
      Mac :    out Secretbox_Mac;
      M   : in     Plain_Text;
      N   : in     Secretbox_Nonce;
      K   : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_detached (C, Mac, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Detached;

   procedure Crypto_Secretbox_Open_Detached
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Secretbox_Mac;
      N   : in     Secretbox_Nonce;
      K   : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_open_detached (M,
                                         C,
                                         Mac,
                                         C'Length,
                                         N,
                                         K) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Open_Detached;

   procedure Crypto_Secretbox_Key (K : out Secretbox_Key) is
   begin
      crypto_secretbox_keygen (K);
   end Crypto_Secretbox_Key;

   -------------------
   -- Secret stream --
   -------------------

   procedure Crypto_Secretstream_Key (K : out Secretstream_Key)
   is
   begin
      crypto_secretstream_xchacha20poly1305_keygen (K);
   end Crypto_Secretstream_Key;

   procedure Crypto_Secretstream_Init_Push
     (State  :     out crypto_secretstream_state;
      H      :     out Header;
      K      : in      Secretstream_Key)
   is
   begin
      if crypto_secretstream_xchacha20poly1305_init_push (State,
                                                          H,
                                                          K) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Init_Push;

   procedure Crypto_Secretstream_Push
     (State : in out crypto_secretstream_state;
      C     :    out Cipher_Text;
      M     : in     Plain_Text;
      AD    : in     Additionnal_Info;
      Tag   : in     uint8)
   is
      Clen : uint64 := C'Length;
   begin
      if crypto_secretstream_xchacha20poly1305_push (State,
                                                     C,
                                                     Clen,
                                                     M,
                                                     M'Length,
                                                     AD,
                                                     AD'Length,
                                                     Tag) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Push;

   procedure Crypto_Secretstream_Adless_Push
     (State : in out crypto_secretstream_state;
      C     :    out Cipher_Text;
      M     : in     Plain_Text;
      Tag   : in     uint8)
   is
      AD :  constant Additionnal_Info (1 .. 0) := (others => 0);
      Clen : uint64 := C'Length;
   begin
      if crypto_secretstream_xchacha20poly1305_push (State,
                                                     C,
                                                     Clen,
                                                     M,
                                                     M'Length,
                                                     AD,
                                                     0,
                                                     Tag) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Adless_Push;

   procedure Crypto_Secretstream_Init_Pull
     (State  :    out crypto_secretstream_state;
      H      : in     Header;
      K      : in     Secretstream_Key)
   is
   begin
      if crypto_secretstream_xchacha20poly1305_init_pull (State,
                                                          H,
                                                          K) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Init_Pull;

   procedure Crypto_Secretstream_Pull
     (State : in out crypto_secretstream_state;
      M     :    out Plain_Text;
      Tag   : in     uint8;
      C     : in     Cipher_Text;
      AD    : in     Additionnal_Info)
   is
      Mlen : uint64 := M'Length;
   begin
      if crypto_secretstream_xchacha20poly1305_pull (State,
                                                     M,
                                                     Mlen,
                                                     Tag,
                                                     C,
                                                     C'Length,
                                                     AD,
                                                     AD'Length) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Pull;

   procedure Crypto_Secretstream_Adless_Pull
     (State : in out crypto_secretstream_state;
      M     :    out Plain_Text;
      Tag   : in     uint8;
      C     : in     Cipher_Text)
   is
      AD :  constant Additionnal_Info (1 .. 0) := (others => 0);
      Mlen : uint64 := M'Length;
   begin
      if crypto_secretstream_xchacha20poly1305_pull (State,
                                                     M,
                                                     Mlen,
                                                     Tag,
                                                     C,
                                                     C'Length,
                                                     AD,
                                                     AD'Length) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Adless_Pull;

   procedure Crypto_Secretstream_Rekey
     (State : in out crypto_secretstream_state)
   is
   begin
      crypto_secretstream_xchacha20poly1305_rekey (State);
   end Crypto_Secretstream_Rekey;

   ---------------------------
   -- Crypto Authentication --
   ---------------------------

   procedure Crypto_Auth
     (Mac :    out Auth_Mac;
      M   : in     Plain_Text;
      K   : in     Auth_Key)
   is
   begin
      if crypto_auth (Mac, M, M'Length, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Auth;

   function Crypto_Auth_Verify
     (H : in Auth_Mac;
      M : in Plain_Text;
      K : in Auth_Key) return int
   is
   begin
      return  crypto_auth_verify (H, M, M'Length, K);
   end Crypto_Auth_Verify;

   procedure Crypto_Auth_Key (K : out Auth_Key)
   is
   begin
      crypto_auth_keygen (K);
   end Crypto_Auth_Key;

   ----------------
   -- Crypto Box --
   ----------------

   procedure Crypto_Box_Seed_Keypair
     (PK   :    out Box_Public_Key;
      SK   :    out Box_Secret_Key;
      Seed : in     Box_Key_Seed)
   is
   begin
      if crypto_box_seed_keypair (PK, SK, Seed) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Seed_Keypair;

   procedure Crypto_Box_Keypair (pk : out Box_Public_Key;
                                 sk : out Box_Secret_Key)
   is
   begin
      if crypto_box_keypair (pk, sk) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Keypair;

   procedure Crypto_Box_Easy
     (C  :    out Cipher_Text;
      M  : in     Plain_Text;
      N  : in     Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
   is
   begin
      if crypto_box_easy (C, M, M'Length, N, PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Easy;

   procedure Crypto_Box_Open_Easy
     (M  :    out Plain_Text;
      C  : in     Cipher_Text;
      N  : in     Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
   is
   begin
      if crypto_box_open_easy (M, C, C'Length, N, PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Easy;

   procedure Crypto_Box_Detached
     (C   :    out Cipher_Text;
      Mac :    out Box_Mac;
      M   : in     Plain_Text;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Secret_Key)
   is
   begin
      if crypto_box_detached (C, Mac, M, M'Length, N, PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Detached;

   procedure Crypto_Box_Open_Detached
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Public_Key)
   is
   begin
      if crypto_box_open_detached (M, C, Mac, C'Length, N, PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Detached;

   procedure Crypto_Box_Beforenm
     (K  :    out Box_Shared_Key;
      PK : in     Box_Secret_Key;
      SK : in     Box_Secret_Key)
   is
   begin
      if crypto_box_beforenm (K, PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Beforenm;

   procedure Crypto_Box_Easy_Afternm
     (C :    out Cipher_Text;
      M : in     Plain_Text;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
   is
   begin
      if crypto_box_easy_afternm (C, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Easy_Afternm;

   procedure Crypto_Box_Open_Easy_Afternm
     (M :    out Plain_Text;
      C : in     Cipher_Text;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
   is
   begin
      if crypto_box_open_easy_afternm (M, C, C'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Easy_Afternm;

   procedure Crypto_Box_Detached_Afternm
     (C   :    out Cipher_Text;
      Mac :    out Box_Mac;
      M   : in     Plain_Text;
      N   : in     Box_Nonce;
      K   : in     Box_Shared_Key)
   is
   begin
      if crypto_box_detached_afternm (C, Mac, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Detached_Afternm;

   procedure Crypto_Box_Open_Detached_Afternm
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      K   : in     Box_Shared_Key)
   is
   begin
      if crypto_box_open_detached_afternm (M, C, Mac, C'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Detached_Afternm;

   ----------------
   -- Sealed Box --
   ----------------

   procedure Crypto_Box_Seal
     (C  :    out Cipher_Text;
      M  : in     Plain_Text;
      PK : in     Box_Public_Key)
   is
   begin
      if crypto_box_seal (C, M, M'Length, PK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Seal;

   procedure Crypto_Box_Seal_Open
     (M  :    out Plain_Text;
      C  : in     Cipher_Text;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
   is
   begin
      if crypto_box_seal_open (M, C, C'Length, PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Seal_Open;

   -----------------
   -- Crypto Sign --
   -----------------

   procedure Crypto_Sign_Seed_Keypair
     (PK   :    out Sign_Public_Key;
      SK   :    out Sign_Secret_Key;
      Seed : in     Sign_Key_Seed)
   is
   begin
      if crypto_sign_seed_keypair (PK, SK, Seed) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Seed_Keypair;

   procedure Crypto_Sign_Keypair (PK : out Sign_Public_Key;
                                  SK : out Sign_Secret_Key)
   is
   begin
      if crypto_sign_keypair (PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Keypair;

   procedure Crypto_Sign
     (SM :    out Plain_Text;
      M  : in     Plain_Text;
      SK : in     Sign_Secret_Key)
   is
      SMlen : uint64;
   begin
      if crypto_sign (SM, SMlen, M, M'Length, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign;

   procedure Crypto_Sign_Open
     (M  :    out Plain_Text;
      SM : in     Plain_Text;
      PK : in     Sign_Public_Key)
   is
      Mlen : uint64;
   begin
      if crypto_sign_open (M, Mlen, SM, SM'Length, PK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Open;

   procedure Crypto_Sign_Detached
     (Sig :    out Signature;
      M   : in     Plain_Text;
      SK  : in     Sign_Secret_Key)
   is
      Siglen : uint64;
   begin
      if crypto_sign_detached (Sig, Siglen, M, M'Length, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Detached;

   function Crypto_Sign_Verify_Detached
     (Sig : in Signature;
      M   : in Plain_Text;
      PK  : in Sign_Public_Key) return int
   is
   begin
      return crypto_sign_verify_detached (Sig, M, M'Length, PK);
   end Crypto_Sign_Verify_Detached;

   procedure Crypto_Sign_Init (state : out crypto_sign_state)
   is
   begin
      if crypto_sign_init (state) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Init;

   procedure Crypto_Sign_Update
     (State : in out crypto_sign_state;
      M     : in     Plain_Text)
   is
   begin
      if crypto_sign_update (State, M, M'Length) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Update;

   procedure Crypto_Sign_Final_Create
     (State : in  out   crypto_sign_state;
      Sig   :    out Signature;
      SK    : in     Sign_Secret_Key)
   is
      Siglen : uint64;
   begin
      if crypto_sign_final_create (State, Sig, Siglen, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Final_Create;

   procedure Crypto_Sign_Final_Verify
     (State : in out crypto_sign_state;
      Sig   : in     Signature;
      PK    : in     Sign_Public_Key)
   is
   begin
      if crypto_sign_final_verify (State, Sig, PK)  /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Final_Verify;

   procedure Crypto_Sign_SK_to_Seed (Seed : out Sign_Key_Seed;
                                     SK : in Sign_Secret_Key)
   is
   begin
      if crypto_sign_ed25519_sk_to_seed (Seed, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_SK_to_Seed;

   procedure Crypto_Sign_SK_to_PK (PK : out Sign_Public_Key;
                                   SK : in Sign_Secret_Key)
     is
   begin
      if crypto_sign_ed25519_sk_to_pk (PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_SK_to_PK;

   ------------------
   -- Key exchange --
   ------------------

   procedure Crypto_Kx_Seed_Keypair
     (PK   :    out Kx_Public_Key;
      SK   :    out Kx_Secret_Key;
      Seed : in     Kx_Key_Seed)
   is
   begin
      if crypto_kx_seed_keypair (PK, SK, Seed) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Kx_Seed_Keypair;

   procedure Crypto_Kx_Keypair (PK : out Kx_Public_Key; SK : out Kx_Secret_Key)
   is
   begin
      if crypto_kx_keypair (PK, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Kx_Keypair;

   procedure Crypto_Kx_Client_Session_Keys
     (RX        :    out Kx_Session_Key;
      TX        :    out Kx_Session_Key;
      Client_PK : in     Kx_Public_Key;
      Client_SK : in     Kx_Secret_Key;
      Server_PK : in     Kx_Public_Key)
   is
   begin
      if crypto_kx_client_session_keys (RX, TX, Client_PK,
                                        Client_SK, Server_PK) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Kx_Client_Session_Keys;

   procedure Crypto_Kx_Server_Session_Keys
     (RX        :    out Kx_Session_Key;
      TX        :    out Kx_Session_Key;
      Server_PK : in     Kx_Public_Key;
      Server_SK : in     Kx_Secret_Key;
      Client_PK : in     Kx_Public_Key)
   is
   begin
      if crypto_kx_server_session_keys (RX, TX, Server_PK,
                                        Server_SK, Client_PK) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Kx_Server_Session_Keys;

end Libsodium_Interface;
