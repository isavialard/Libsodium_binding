
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
      Blocksize : in uint64) return uint64
   is
   begin
      return (Buflen / Blocksize + 1) * Blocksize;
   end Sodium_Pad_Length;

   function Sodium_Unpad_Length
     (Buf    : in Plain_Text) return uint64
   is
      I : uint64 := Buf'Last;
   begin
      while Buf (I) = 0 loop
         I := I - 1;
      end loop;
      if Buf (I) /= 128 then
         raise Crypto_Error;
      else
         return I - Buf'First;
      end if;
   end Sodium_Unpad_Length;

   procedure Sodium_Pad
     (Padded_Buf :    out Plain_Text;
      Buf        : in     Plain_Text;
      Blocksize  : in     uint64)
   is
      Huge_Buf : Block8 (Buf'First .. Buf'Last + Blocksize);
      Padded_Length : uint64;
   begin
      for I in Buf'First .. Buf'Last loop
         Huge_Buf (I) := Buf (I);
      end loop;
      if sodium_pad (uint64 (Padded_Length), Block8 (Huge_Buf), Block8 (Buf)'Length, Blocksize,
                     Padding_MAXBYTES) /= 0
      then
         raise Crypto_Error;
      end if;
      Padded_Buf := Plain_Text (Huge_Buf) (Buf'First .. Buf'First + Padded_Length - 1);
   end Sodium_Pad;
   procedure Sodium_Unpad
     (Buf        :    out Plain_Text;
      Padded_Buf : in     Plain_Text;
      Blocksize  : in     uint64)
   is
      Unpadded_Length : uint64;
   begin
      if sodium_unpad (Unpadded_Length, Block8 (Padded_Buf), Block8 (Padded_Buf)'Length,
                       Blocksize) /= 0
      then
         raise Crypto_Error;
      end if;
      Buf := Padded_Buf (Padded_Buf'First .. Padded_Buf'First
                         + Unpadded_Length - 1);
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

   procedure Randombytes (Buf : out Plain_Text)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf (Block8 (Buf), Buflen);
   end Randombytes;

   procedure Randombytes (Buf : out Box_Nonce)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf (Block8 (Buf), Buflen);
   end Randombytes;

   procedure Randombytes (Buf : out Secretbox_Nonce)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf (Block8 (Buf), Buflen);
   end Randombytes;

   procedure Randombytes (Buf : out Random_Seed)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf (Block8 (Buf), Buflen);
   end Randombytes;

   procedure Randombytes (Buf : out Pwhash_Salt)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf (Block8 (Buf), Buflen);
   end Randombytes;

   procedure Randombytes_Seed
     (Buf  :    out Block8;
      Seed : in     Random_Seed)
   is
      Buflen : constant uint64 := Buf'Length;
   begin
      randombytes_buf_deterministic (Buf, Buflen, Block8 (Seed));
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
      if crypto_generichash (Block8 (FP),
                                               FPlen,
                                               M,
                                               M'Length,
                                               Block8 (K),
                                               Block8 (K)'Length) /= 0
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
      if crypto_generichash (Block8 (FP), FPlen, M, M'Length, K, 0) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Keyless;

   procedure Crypto_Generichash_Init
     (State :    out crypto_generichash_state;
      K     : in     Generichash_Key)
   is
   begin
      if crypto_generichash_init (State,
                                                    Block8 (K),
                                                    Block8 (K)'Length,
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
                                                     Block8 (FP),
                                                     FPlen) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Final;

   procedure Crypto_Generichash_Key (K : out Generichash_Key)
   is
   begin
      crypto_generichash_keygen (Block8 (K));
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
      if crypto_shorthash (Block8 (FP), M, M'Length, Block8 (K)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Shorthash;

   procedure Crypto_Shorthash_Key (K : out Shorthash_Key)
   is
   begin
      crypto_shorthash_keygen (Block8 (K));
   end Crypto_Shorthash_Key;

   -------------------
   -- Password hash --
   -------------------

   procedure Crypto_Pwhash
     (K           :    out Pwhash_Key;
      Passwd      : in     Password;
      Salt        : in     Pwhash_Salt;
      Sensitivity : in     Data_Sensitivity := interactive)
     is
      opslimit : uint64;
      memlimit : uint64;
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
      if crypto_pwhash (Block8 (K), Klen, Passwd, Passwd'Length, Block8 (Salt),
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
      if Libsodium_Binding.crypto_pwhash_str (Libsodium_Binding.String (H), Libsodium_Binding.String (Passwd), Passwd'Length,
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
      return crypto_pwhash_str_verify (Libsodium_Binding.String (H), Libsodium_Binding.String (Passwd),
                                                         Passwd'Length);
   end Crypto_Pwhash_Str_Verify;

   ----------------
   -- Secret box --
   ----------------

   procedure Crypto_Secretbox_Easy
     (C :    out Cipher_Text;
      M : in     Plain_Text;
      N : in out Secretbox_Nonce;
      K : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_easy (Block8 (C), Block8 (M), M'Length, Block8 (N), Block8 (K)) /= 0 then
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
      if crypto_secretbox_open_easy (Block8 (M), Block8 (C), C'Length, Block8 (N), Block8 (K)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Open_Easy;

   procedure Crypto_Secretbox_Detached
     (C   :    out Cipher_Text;
      Mac :    out Secretbox_Mac;
      M   : in     Plain_Text;
      N   : in out Secretbox_Nonce;
      K   : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_detached (Block8 (C), Block8 (Mac), Block8 (M), M'Length, Block8 (N), Block8 (K)) /= 0 then
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
      if crypto_secretbox_open_detached (Block8 (M),
                                         Block8 (C),
                                         Block8 (Mac),
                                         C'Length,
                                         Block8 (N),
                                         Block8 (K)) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Open_Detached;

   procedure Crypto_Secretbox_Key (K : out Secretbox_Key) is
   begin
      crypto_secretbox_keygen (Block8 (K));
   end Crypto_Secretbox_Key;

   -------------------
   -- Secret stream --
   -------------------

   procedure Crypto_Secretstream_Key (K : out Secretstream_Key)
   is
   begin
      crypto_secretstream_xchacha20poly1305_keygen (Block8 (K));
   end Crypto_Secretstream_Key;

   procedure Crypto_Secretstream_Init_Push
     (State  :     out crypto_secretstream_state;
      H      :     out Header;
      K      : in      Secretstream_Key)
   is
   begin
      if crypto_secretstream_xchacha20poly1305_init_push (State,
                                                          Block8 (H),
                                                          Block8 (K)) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Init_Push;

   procedure Crypto_Secretstream_Push
     (State : in out crypto_secretstream_state;
      C     :    out Cipher_Text;
      M     : in     Plain_Text;
      Tag   : in     uint8;
      AD    : in     Additionnal_Info := Null_AD)
   is
      Clen : uint64 := C'Length;
   begin
      if crypto_secretstream_xchacha20poly1305_push (State,
                                                     Block8 (C),
                                                     Clen,
                                                     Block8 (M),
                                                     M'Length,
                                                     Block8 (AD),
                                                     AD'Length,
                                                     Tag) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Push;



   procedure Crypto_Secretstream_Init_Pull
     (State  :    out crypto_secretstream_state;
      H      : in     Header;
      K      : in     Secretstream_Key)
   is
   begin
      if crypto_secretstream_xchacha20poly1305_init_pull (State,
                                                          Block8 (H),
                                                          Block8 (K)) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Init_Pull;

   procedure Crypto_Secretstream_Pull
     (State : in out crypto_secretstream_state;
      M     :    out Plain_Text;
      Tag   : in     uint8;
      C     : in     Cipher_Text;
      AD    : in     Additionnal_Info := Null_AD)
   is
      Mlen : uint64 := M'Length;
   begin
      if crypto_secretstream_xchacha20poly1305_pull (State,
                                                     Block8 (M),
                                                     Mlen,
                                                     Tag,
                                                     Block8 (C),
                                                     C'Length,
                                                     Block8 (AD),
                                                     AD'Length) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Secretstream_Pull;



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
      if crypto_auth (Block8 (Mac), Block8 (M), M'Length, Block8 (K)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Auth;

   function Crypto_Auth_Verify
     (H : in Auth_Mac;
      M : in Plain_Text;
      K : in Auth_Key) return int
   is
   begin
      return  crypto_auth_verify (Block8 (H), Block8 (M), M'Length, Block8 (K));
   end Crypto_Auth_Verify;

   procedure Crypto_Auth_Key (K : out Auth_Key)
   is
   begin
      crypto_auth_keygen (Block8 (K));
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
      if crypto_box_seed_keypair (Block8 (PK), Block8 (SK), Block8 (Seed)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Seed_Keypair;

   procedure Crypto_Box_Keypair (pk : out Box_Public_Key;
                                 sk : out Box_Secret_Key)
   is
   begin
      if crypto_box_keypair (Block8 (pk), Block8 (sk)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Keypair;

   procedure Crypto_Box_Easy
     (C  :    out Cipher_Text;
      M  : in     Plain_Text;
      N  : in out Box_Nonce;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
   is
   begin
      if crypto_box_easy (Block8 (C), Block8 (M), M'Length, Block8 (N), Block8 (PK), Block8 (SK)) /= 0 then
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
      if crypto_box_open_easy (Block8 (M), Block8 (C), C'Length, Block8 (N), Block8 (PK), Block8 (SK)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Easy;

   procedure Crypto_Box_Detached
     (C   :    out Cipher_Text;
      Mac :    out Box_Mac;
      M   : in     Plain_Text;
      N   : in out Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Secret_Key)
   is
   begin
      if crypto_box_detached (Block8 (C), Block8 (Mac), Block8 (M), M'Length, Block8 (N), Block8 (PK), Block8 (SK)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Detached;

   procedure Crypto_Box_Open_Detached
     (M   :    out Plain_Text;
      C   : in     Cipher_Text;
      Mac : in     Box_Mac;
      N   : in     Box_Nonce;
      PK  : in     Box_Public_Key;
      SK  : in     Box_Secret_Key)
   is
   begin
      if crypto_box_open_detached (Block8 (M), Block8 (C), Block8 (Mac), C'Length, Block8 (N), Block8 (PK), Block8 (SK)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Detached;

   procedure Crypto_Box_Beforenm
     (K  :    out Box_Shared_Key;
      PK : in     Box_Public_Key;
      SK : in     Box_Secret_Key)
   is
   begin
      if crypto_box_beforenm (Block8 (K), Block8 (PK), Block8 (SK)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Beforenm;

   procedure Crypto_Box_Easy_Afternm
     (C :    out Cipher_Text;
      M : in     Plain_Text;
      N : in out Box_Nonce;
      K : in     Box_Shared_Key)
   is
   begin
      if crypto_box_easy_afternm (Block8 (C), Block8 (M), M'Length, Block8 (N), Block8 (K)) /= 0 then
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
      if crypto_box_open_easy_afternm (Block8 (M), Block8 (C), C'Length, Block8 (N), Block8 (K)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Easy_Afternm;

   procedure Crypto_Box_Detached_Afternm
     (C   :    out Cipher_Text;
      Mac :    out Box_Mac;
      M   : in     Plain_Text;
      N   : in out Box_Nonce;
      K   : in     Box_Shared_Key)
   is
   begin
      if crypto_box_detached_afternm (Block8 (C), Block8 (Mac), Block8 (M), M'Length, Block8 (N), Block8 (K)) /= 0 then
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
      if crypto_box_open_detached_afternm (Block8 (M), Block8 (C), Block8 (Mac), C'Length, Block8 (N), Block8 (K)) /= 0 then
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
      if crypto_box_seal (Block8 (C), Block8 (M), M'Length, Block8 (PK)) /= 0 then
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
      if crypto_box_seal_open (Block8 (M), Block8 (C), C'Length, Block8 (PK), Block8 (SK)) /= 0 then
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
      if crypto_sign_seed_keypair (Block8 (PK), Block8 (SK), Block8 (Seed)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Seed_Keypair;

   procedure Crypto_Sign_Keypair (PK : out Sign_Public_Key;
                                  SK : out Sign_Secret_Key)
   is
   begin
      if crypto_sign_keypair (Block8 (PK), Block8 (SK)) /= 0 then
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
      if crypto_sign (Block8 (SM), SMlen, Block8 (M), M'Length, Block8 (SK)) /= 0 then
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
      if crypto_sign_open (Block8 (M), Mlen, Block8 (SM), SM'Length, Block8 (PK)) /= 0 then
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
      if crypto_sign_detached (Block8 (Sig), Siglen, Block8 (M), M'Length, Block8 (SK)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Detached;

   function Crypto_Sign_Verify_Detached
     (Sig : in Signature;
      M   : in Plain_Text;
      PK  : in Sign_Public_Key) return int
   is
   begin
      return crypto_sign_verify_detached (Block8 (Sig), Block8 (M), M'Length, Block8 (PK));
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
      if crypto_sign_final_create (State, Block8 (Sig), Siglen, Block8 (SK)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Final_Create;

   procedure Crypto_Sign_Final_Verify
     (State : in out crypto_sign_state;
      Sig   : in     Signature;
      PK    : in     Sign_Public_Key)
   is
   begin
      if crypto_sign_final_verify (State, Block8 (Sig), Block8 (PK))  /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Final_Verify;

   procedure Crypto_Sign_SK_to_Seed (Seed : out Sign_Key_Seed;
                                     SK : in Sign_Secret_Key)
   is
   begin
      if crypto_sign_ed25519_sk_to_seed (Block8 (Seed), Block8 (SK)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_SK_to_Seed;

   procedure Crypto_Sign_SK_to_PK (PK : out Sign_Public_Key;
                                   SK : in Sign_Secret_Key)
     is
   begin
      if crypto_sign_ed25519_sk_to_pk (Block8 (PK), Block8 (SK)) /= 0 then
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
      if crypto_kx_seed_keypair (Block8 (PK), Block8 (SK), Block8 (Seed)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Kx_Seed_Keypair;

   procedure Crypto_Kx_Keypair (PK : out Kx_Public_Key; SK : out Kx_Secret_Key)
   is
   begin
      if crypto_kx_keypair (Block8 (PK), Block8 (SK)) /= 0 then
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
      if crypto_kx_client_session_keys (Block8 (RX), Block8 (TX), Block8 (Client_PK),
                                        Block8 (Client_SK), Block8 (Server_PK)) /= 0
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
      if crypto_kx_server_session_keys (Block8 (RX), Block8 (TX), Block8 (Server_PK),
                                        Block8 (Server_SK), Block8 (Client_PK)) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Kx_Server_Session_Keys;

   --------------------
   -- Key Derivation --
   --------------------

   procedure Crypto_Kdf_Derive_From_Key
     (Subkey  :    out Block8;
      ID      : in     uint64;
      Context : in     Kdf_Context := "Context ";
      Key     : in     Kdf_Key)
   is
      sublen : uint64 := Subkey'Length;
   begin
      if Libsodium_Binding.crypto_kdf_derive_from_key (Subkey, Sublen, ID, Libsodium_Binding.String (Context), Block8 (Key)) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Kdf_Derive_From_Key;

   procedure Crypto_Kdf_Key (K : out Kdf_Key)
   is
   begin
      crypto_kdf_keygen (Block8(K));
   end Crypto_Kdf_Key;

end Libsodium_Interface;
