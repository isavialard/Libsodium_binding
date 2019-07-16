
package body Libsodium_Interface is

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
      if Libsodium_Binding.crypto_generichash (FP,
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
      if Libsodium_Binding.crypto_generichash_init (State,
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
      if Libsodium_Binding.crypto_generichash_init (State,
                                                    K,
                                                    0,
                                                    Crypto_Generichash_BYTES)
        /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Init_Keyless;

   procedure Crypto_Generichash_Update
     (State :    out crypto_generichash_state;
      M     : in     Block8)
   is
   begin
      if Libsodium_Binding.crypto_generichash_update (State,
                                                      M,
                                                      M'Length) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Update;

   procedure Crypto_Generichash_Final
     (State :    out crypto_generichash_state;
      FP    : in     Generichash_Fingerprint)
   is
      FPlen : constant uint8 := FP'Length;
   begin
      if Libsodium_Binding.crypto_generichash_final (State,
                                                     FP,
                                                     FPlen) /= 0
      then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Final;

   procedure Crypto_Generichash_Keygen (K : out Generichash_Key)
   is
   begin
      Libsodium_Binding.crypto_generichash_keygen (K);
   end Crypto_Generichash_Keygen;

   -------------------------
   -- Short Hash --
   -------------------------

   procedure Crypto_Shorthash
     (FP : out Shorthash_Fingerprint;
      M : Block8;
      K : Shorthash_Key)
   is
   begin
      if crypto_shorthash (FP, M, M'Length, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Shorthash;


   procedure Crypto_Shorthash_Keygen (K : out Shorthash_Key)
   is
   begin
      Libsodium_Binding.crypto_shorthash_keygen (K);
   end Crypto_Shorthash_Keygen;

   ----------------
   -- Secret box --
   ----------------

   procedure Crypto_Secretbox_Easy
     (C :    out Block8;
      M : in     Block8;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_easy (C, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Easy;

   procedure Crypto_Secretbox_Open_Easy
     (M :    out Block8;
      C : in     Block8;
      N : in     Secretbox_Nonce;
      K : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_open_easy (M, C, C'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Open_Easy;

   procedure Crypto_Secretbox_Detached
     (C   :    out Block8;
      Mac :    out Secretbox_Mac;
      M   : in     Block8;
      N   : in     Secretbox_Nonce;
      K   : in     Secretbox_Key)
   is
   begin
      if crypto_secretbox_detached (C, Mac, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Secretbox_Detached;

   procedure Crypto_Secretbox_Open_Detached
     (M   :    out Block8;
      C   : in     Block8;
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

   procedure Crypto_Secretbox_Keygen (K : out Secretbox_Key) is
   begin
      Libsodium_Binding.crypto_secretbox_keygen (K);
   end Crypto_Secretbox_Keygen;

   -------------------
   -- Secret stream --
   -------------------

   procedure Crypto_Secretstream_Keygen (K : out Secretstream_Key)
   is
   begin
      crypto_secretstream_xchacha20poly1305_keygen (K);
   end Crypto_Secretstream_Keygen;

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
      C     :    out Block8;
      M     : in     Block8;
      AD    : in     Additionnal_Info;
      Tag   : in     uint8)
   is
      Clen : constant uint64 := C'Length;
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
      C     :    out Block8;
      M     : in     Block8;
      Tag   : in     uint8)
   is
      AD :  constant Additionnal_Info (1 .. 0) := (others => 0);
      Clen : constant uint64 := C'Length;
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
      M     :    out Block8;
      Tag   : in     uint8;
      C     : in     Block8;
      AD    : in     Additionnal_Info)
   is
      Mlen : constant uint64 := M'Length;
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
      M     :    out Block8;
      Tag   : in     uint8;
      C     : in     Block8)
   is
      AD :  constant Additionnal_Info (1 .. 0) := (others => 0);
      Mlen : constant uint64 := M'Length;
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
      M   : in     Block8;
      K   : in     Auth_Key)
   is
   begin
      if crypto_auth (Mac, M, M'Length, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Auth;

   function Crypto_Auth_Verify
     (H : in Auth_Mac;
      M : in Block8;
      K : in Auth_Key) return int
   is
   begin
      return  crypto_auth_verify (H, M, M'Length, K);
   end Crypto_Auth_Verify;

   procedure Crypto_Auth_Keygen (K : out Auth_Key)
   is
   begin
      Libsodium_Binding.crypto_auth_keygen (K);
   end Crypto_Auth_Keygen;

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
     (C  :    out Block8;
      M  : in     Block8;
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
     (M  :    out Block8;
      C  : in     Block8;
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
     (C   :    out Block8;
      Mac :    out Box_Mac;
      M   : in     Block8;
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
     (M   :    out Block8;
      C   : in     Block8;
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
     (C :    out Block8;
      M : in     Block8;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
   is
   begin
      if crypto_box_easy_afternm (C, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Easy_Afternm;

   procedure Crypto_Box_Open_Easy_Afternm
     (M :    out Block8;
      C : in     Block8;
      N : in     Box_Nonce;
      K : in     Box_Shared_Key)
   is
   begin
      if crypto_box_open_easy_afternm (M, C, C'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Open_Easy_Afternm;

   procedure Crypto_Box_Detached_Afternm
     (C   :    out Block8;
      Mac :    out Box_Mac;
      M   : in     Block8;
      N   : in     Box_Nonce;
      K   : in     Box_Shared_Key)
   is
   begin
      if crypto_box_detached_afternm (C, Mac, M, M'Length, N, K) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Detached_Afternm;

   procedure Crypto_Box_Open_Detached_Afternm
     (M   :    out Block8;
      C   : in     Block8;
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
     (C  :    out Block8;
      M  : in     Block8;
      PK : in     Box_Public_Key)
   is
   begin
      if crypto_box_seal (C, M, M'Length, PK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Box_Seal;

   procedure Crypto_Box_Seal_Open
     (M  :    out Block8;
      C  : in     Block8;
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
     (SM :    out Block8;
      M  : in     Block8;
      SK : in     Sign_Secret_Key)
   is
      SMlen : uint64;
   begin
      if crypto_sign (SM, SMlen, M, M'Length, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign;

   procedure Crypto_Sign_Open
     (M  :    out Block8;
      SM : in     Block8;
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
      M   : in     Block8;
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
      M   : in Block8;
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
      M     : in     Block8)
   is
   begin
      if crypto_sign_update (State, M, M'Length) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Update;

   procedure Crypto_Sign_Final_Create
     (State : in     crypto_sign_state;
      Sig   :    out Signature;
      SK    : in     Sign_Secret_Key)
   is
      Siglen : uint64;
   begin
      if crypto_sign_final_create (State, Sig, Siglen, SK) /= 0 then
         raise Crypto_Error;
      end if;
   end Crypto_Sign_Final_Create;

   function Crypto_Sign_Final_Verify
     (State : in     crypto_sign_state;
      Sig   : in     Signature;
      PK    : in     Sign_Public_Key) return int
   is
   begin
      return Libsodium_Binding.crypto_sign_final_verify (State, Sig, PK);
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

end Libsodium_Interface;
