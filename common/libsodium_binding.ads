pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;


package Libsodium_Binding is

   --Types

   MAX_BYTES : constant := 2147483647;
   -- Unable to find the range limit defined in libsodium
   -- MAX_BYTES arbitrarily fixed to max integer
   type uint64 is range -2 ** 63 .. 2 ** 63 - 1;
   type uint32 is mod 2 ** 32;
   type uint8 is mod 2 ** 8;
   subtype Index is uint64 range 0 .. MAX_BYTES;
   type block64 is array (Index range <>) of uint64;
   type Block8 is array (Index range <>) of uint8;
   type String is array (Index range <>) of Character;

   type crypto_secretstream_state is record
      k     :  aliased block8(1 .. 32);  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:57
      nonce :  aliased block8(1 .. 12);  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:58
      u_pad :  aliased block8(1 .. 8);  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:59
   end record
     with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:56

   type crypto_hash_state is record
      state :  block64(1 .. 8);  -- ./sodium/crypto_hash_sha512.h:25
      count :  block64(1 .. 2);  -- ./sodium/crypto_hash_sha512.h:26
      buf :  block8(1 .. 128);  -- ./sodium/crypto_hash_sha512.h:27
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_hash_sha512.h:24

   type crypto_sign_state is record
      hs :  crypto_hash_state;  -- ./sodium/crypto_sign_ed25519.h:16
   end record
     with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_sign_ed25519.h:15

   type crypto_generichash_state is record
      opaque :  block8(1 .. 384);  -- ./sodium/crypto_generichash_blake2b.h:24
   end record
     with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_generichash_blake2b.h:23

   function crypto_box_messagebytes_max return uint64  -- ./sodium/crypto_box.h:45
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_messagebytes_max";




   --Init
   function sodium_init return int  -- ./sodium/core.h:12
      with Import => True,
           Convention => C,
     External_Name => "sodium_init";

   --Padding
   function sodium_pad
     (padded_buflen_p : out uint64;
      buf : out Block8;
      unpadded_buflen : uint64;
      blocksize : uint64;
      max_buflen : uint64) return int  -- ./sodium/utils.h:162
   with Import => True,
        Convention => C,
        External_Name => "sodium_pad";

   function sodium_unpad
     (unpadded_buflen_p : out uint64;
      buf : Block8;
      padded_buflen : uint64;
      blocksize : uint64) return int  -- ./sodium/utils.h:167
   with Import => True,
        Convention => C,
        External_Name => "sodium_unpad";

   --Randombytes
   procedure randombytes_buf (buf : out Block8; size : uint64)  -- ./sodium/randombytes.h:35
   with Import => True,
        Convention => C,
     External_Name => "randombytes_buf";

   procedure randombytes_buf_deterministic
     (buf  : out Block8;
      size : uint64;
      seed : Block8)  -- ./sodium/randombytes.h:39
   with Import => True,
        Convention => C,
     External_Name => "randombytes_buf_deterministic";

   -- Constant time comparison

   function sodium_memcmp
     (b1_u : Block8;
      b2_u : Block8;
      len : uint64) return int  -- ./sodium/utils.h:34
   with Import => True,
        Convention => C,
     External_Name => "sodium_memcmp";


   --Secret key
   --Authenticated Encryption
   function crypto_secretbox_easy
     (c : out Block8;
      m : Block8;
      mlen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_secretbox.h:37
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_easy";

   function crypto_secretbox_open_easy
     (m : out Block8;
      c : Block8;
      clen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_secretbox.h:42
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_open_easy";

   function crypto_secretbox_detached
     (c : out Block8;
      mac : out Block8;
      m : Block8;
      mlen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_secretbox.h:48
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_detached";

   function crypto_secretbox_open_detached
     (m : out Block8;
      c : Block8;
      mac : Block8;
      clen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_secretbox.h:56
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_open_detached";

   procedure crypto_secretbox_keygen (k : out Block8)  -- ./sodium/crypto_secretbox.h:65
   with Import => True,
        Convention => C,
     External_Name => "crypto_secretbox_keygen";

   --Encrypted streams and file encryption
   procedure crypto_secretstream_xchacha20poly1305_keygen (k : out Block8)  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:66
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_keygen";

   function crypto_secretstream_xchacha20poly1305_init_push
     (state : out crypto_secretstream_state;
      h : out Block8;
      k : Block8) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:71
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_init_push";

   function crypto_secretstream_xchacha20poly1305_push
     (state : in out crypto_secretstream_state;
      c : out Block8;
      clen_p : out Uint64;
      m : Block8;
      mlen : Uint64;
      ad : Block8;
      adlen : Uint64;
      tag : uint8) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:78
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_push";

   function crypto_secretstream_xchacha20poly1305_init_pull
     (state : out crypto_secretstream_state;
      h : Block8;
      k : Block8) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:86
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_init_pull";

   function crypto_secretstream_xchacha20poly1305_pull
     (state : in out crypto_secretstream_state;
      m : out Block8;
      mlen_p : out Uint64;
      tag_p : uint8;
      c : Block8;
      clen : Uint64;
      ad : Block8;
      adlen : Uint64) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:93
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_pull";

   procedure crypto_secretstream_xchacha20poly1305_rekey (state : in out crypto_secretstream_state)  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:101
   with Import => True,
        Convention => C,
     External_Name => "crypto_secretstream_xchacha20poly1305_rekey";

   --Authentication
   function crypto_auth
     (c_out : out Block8;
      c_in :  in Block8;
      inlen : in Uint64;
      k : in Block8) return int  -- ./sodium/crypto_auth.h:29
   with Import => True,
        Convention => C,
        External_Name => "crypto_auth";

   function crypto_auth_verify
     (h : in Block8;
      c_in : in Block8;
      inlen : in Uint64;
      k : in Block8) return int  -- ./sodium/crypto_auth.h:34
   with Import => True,
        Convention => C,
        External_Name => "crypto_auth_verify";

   procedure crypto_auth_keygen (k : out Block8)  -- ./sodium/crypto_auth.h:39
   with Import => True,
        Convention => C,
     External_Name => "crypto_auth_keygen";

   --Public Key
   -- Authenticated encryption
   function crypto_box_seed_keypair
     (pk : out Block8;
      sk : out Block8;
      seed : in Block8) return int  -- ./sodium/crypto_box.h:52
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_seed_keypair";

   function crypto_box_keypair (pk : out Block8; sk : out Block8) return int  -- ./sodium/crypto_box.h:57
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_keypair";

   function crypto_box_easy
     (c : out Block8;
      m : Block8;
      mlen : Uint64;
      n : Block8;
      pk : Block8;
      sk : Block8) return int  -- ./sodium/crypto_box.h:61
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_easy";

   function crypto_box_open_easy
     (m : out Block8;
      c : Block8;
      clen : Uint64;
      n : Block8;
      pk : Block8;
      sk : Block8) return int  -- ./sodium/crypto_box.h:67
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_open_easy";

   function crypto_box_detached
     (c : out Block8;
      mac : out Block8;
      m : Block8;
      mlen : Uint64;
      n : Block8;
      pk : Block8;
      sk : Block8) return int  -- ./sodium/crypto_box.h:73
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_detached";

   function crypto_box_open_detached
     (m : out Block8;
      c : Block8;
      mac : Block8;
      clen : Uint64;
      n : Block8;
      pk : Block8;
      sk : Block8) return int  -- ./sodium/crypto_box.h:80
   with Import => True,
        Convention => C,
     External_Name => "crypto_box_open_detached";

   function crypto_box_beforenm
     (k : out Block8;
      pk : Block8;
      sk : Block8) return int  -- ./sodium/crypto_box.h:95
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_beforenm";

   function crypto_box_easy_afternm
     (c : out Block8;
      m : Block8;
      mlen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_box.h:100
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_easy_afternm";

   function crypto_box_open_easy_afternm
     (m : out Block8;
      c : Block8;
      clen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_box.h:105
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_open_easy_afternm";

   function crypto_box_detached_afternm
     (c : out Block8;
      mac : out Block8;
      m : Block8;
      mlen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_box.h:111
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_detached_afternm";

   function crypto_box_open_detached_afternm
     (m : out Block8;
      c : Block8;
      mac : Block8;
      clen : Uint64;
      n : Block8;
      k : Block8) return int  -- ./sodium/crypto_box.h:117
   with Import => True,
        Convention => C,
     External_Name => "crypto_box_open_detached_afternm";

   --Public Key Signatures
    function crypto_sign_seed_keypair
     (pk : out Block8;
      sk : out Block8;
      seed : Block8) return int  -- ./sodium/crypto_sign.h:53
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_seed_keypair";

   function crypto_sign_keypair (pk : out Block8; sk : out Block8) return int  -- ./sodium/crypto_sign.h:58
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_keypair";

   function crypto_sign
     (sm : out Block8;
      smlen_p : out Uint64;
      m : Block8;
      mlen : Uint64;
      sk : Block8) return int  -- ./sodium/crypto_sign.h:62
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign";

   function crypto_sign_open
     (m : out Block8;
      mlen_p : out Uint64;
      sm : Block8;
      smlen : Uint64;
      pk : Block8) return int  -- ./sodium/crypto_sign.h:67
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_open";

   function crypto_sign_detached
     (sig : out Block8;
      siglen_p : out Uint64;
      m : Block8;
      mlen : Uint64;
      sk : Block8) return int  -- ./sodium/crypto_sign.h:73
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_detached";

   function crypto_sign_verify_detached
     (sig : Block8;
      m : Block8;
      mlen : Uint64;
      pk : Block8) return int  -- ./sodium/crypto_sign.h:78
   with Import => True,
        Convention => C,
     External_Name => "crypto_sign_verify_detached";

   function crypto_sign_init (state : out crypto_sign_state) return int  -- ./sodium/crypto_sign.h:85
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_init";

   function crypto_sign_update
     (state : out crypto_sign_state;
      m : Block8;
      mlen : Uint64) return int  -- ./sodium/crypto_sign.h:88
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_update";

   function crypto_sign_final_create
     (state : in out crypto_sign_state;
      sig : out Block8;
      siglen_p : out Uint64;
      sk : Block8) return int  -- ./sodium/crypto_sign.h:93
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_final_create";

   function crypto_sign_final_verify
     (state : in out crypto_sign_state;
      sig : Block8;
      pk : Block8) return int  -- ./sodium/crypto_sign.h:99
   with Import => True,
        Convention => C,
     External_Name => "crypto_sign_final_verify";

   function crypto_sign_ed25519_sk_to_seed (seed : out Block8; sk : Block8) return int  -- ./sodium/crypto_sign_ed25519.h:89
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_ed25519_sk_to_seed";

   function crypto_sign_ed25519_sk_to_pk (pk : out Block8; sk : Block8) return int  -- ./sodium/crypto_sign_ed25519.h:94
   with Import => True,
        Convention => C,
     External_Name => "crypto_sign_ed25519_sk_to_pk";

   --Sealed Box

   function crypto_box_seal
     (c : out Block8;
      m : Block8;
      mlen : Uint64;
      pk : Block8) return int  -- ./sodium/crypto_box.h:130
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_seal";

   function crypto_box_seal_open
     (m : out Block8;
      c : Block8;
      clen : Uint64;
      pk : Block8;
      sk : Block8) return int  -- ./sodium/crypto_box.h:135
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_seal_open";

   -- Generic Hash
   function crypto_generichash
     (c_out : out Block8;
      outlen : in uint8;
      c_in : in Block8;
      inlen : in uint64;
      K : in Block8;
      keylen : in uint8) return int  -- ./sodium/crypto_generichash.h:54
   with Import => True,
        Convention => C,
   External_Name => "crypto_generichash";


   function crypto_generichash_init
     (state : out crypto_generichash_state;
      K : Block8;
      Block8len : uint8;
      outlen : uint8) return int  -- ./sodium/crypto_generichash.h:60
   with Import => True,
        Convention => C,
        External_Name => "crypto_generichash_init";

   function crypto_generichash_update
     (state : in out crypto_generichash_state;
      c_in : Block8;
      inlen : Uint64) return int  -- ./sodium/crypto_generichash.h:66
   with Import => True,
        Convention => C,
        External_Name => "crypto_generichash_update";

   function crypto_generichash_final
     (state : in out crypto_generichash_state;
      c_out : out Block8;
      outlen : uint8) return int  -- ./sodium/crypto_generichash.h:72
   with Import => True,
        Convention => C,
        External_Name => "crypto_generichash_final";

   procedure crypto_generichash_keygen (k : out Block8)  -- ./sodium/crypto_generichash.h:77
   with Import => True,
        Convention => C,
     External_Name => "crypto_generichash_keygen";

   --Short Hash
   function crypto_shorthash
     (c_out : out Block8;
      c_in : Block8;
      inlen : Uint64;
      k : Block8) return int  -- ./sodium/crypto_shorthash.h:29
   with Import => True,
        Convention => C,
        External_Name => "crypto_shorthash";

   procedure crypto_shorthash_keygen (k : out Block8)  -- ./sodium/crypto_shorthash.h:34
   with Import => True,
        Convention => C,
        External_Name => "crypto_shorthash_keygen";

   --Hash
   function crypto_hash
     (c_out : out Block8;
      c_in : Block8;
      inlen : Uint64) return int  -- ./sodium/crypto_hash.h:28
   with Import => True,
        Convention => C,
        External_Name => "crypto_hash";

   --Password hash
    function crypto_pwhash
     (c_out : out Block8;
      outlen : Uint64;
      passwd : String;
      passwdlen : Uint64;
      salt : Block8;
      opslimit : Uint64;
      memlimit : uint64;
      alg : int) return int  -- ./sodium/crypto_pwhash.h:104
   with Import => True,
        Convention => C,
        External_Name => "crypto_pwhash";


   function crypto_pwhash_str
     (c_out : out String;
      passwd : String;
      passwdlen : Uint64;
      opslimit : Uint64;
      memlimit : uint64) return int  -- ./sodium/crypto_pwhash.h:116
   with Import => True,
        Convention => C,
     External_Name => "crypto_pwhash_str";

   function crypto_pwhash_str_verify
     (str : String;
      passwd : String;
      passwdlen : Uint64) return int  -- ./sodium/crypto_pwhash.h:128
   with Import => True,
        Convention => C,
        External_Name => "crypto_pwhash_str_verify";

   function crypto_pwhash_str_needs_rehash
     (str : in out String;
      opslimit : Uint64;
      memlimit : uint64) return int  -- ./sodium/crypto_pwhash.h:134
   with Import => True,
        Convention => C,
        External_Name => "crypto_pwhash_str_needs_rehash";

   --Key exchange
    function crypto_kx_seed_keypair
     (pk : out Block8;
      sk : out Block8;
      seed : Block8) return int  -- ./sodium/crypto_kx.h:36
   with Import => True,
        Convention => C,
        External_Name => "crypto_kx_seed_keypair";

   function crypto_kx_keypair (pk :out Block8; sk : out Block8) return int  -- ./sodium/crypto_kx.h:42
   with Import => True,
        Convention => C,
        External_Name => "crypto_kx_keypair";

   function crypto_kx_client_session_keys
     (rx : out Block8;
      tx :out  Block8;
      client_pk : Block8;
      client_sk : Block8;
      server_pk : Block8) return int  -- ./sodium/crypto_kx.h:47
   with Import => True,
        Convention => C,
        External_Name => "crypto_kx_client_session_keys";

   function crypto_kx_server_session_keys
     (rx : out Block8;
      tx : out Block8;
      server_pk : Block8;
      server_sk : Block8;
      client_pk : Block8) return int  -- ./sodium/crypto_kx.h:55
   with Import => True,
        Convention => C,
     External_Name => "crypto_kx_server_session_keys";

   --------------------
   -- Key Derivation --
   --------------------

   function crypto_kdf_derive_from_key
     (subkey : out Block8;
      subkey_len : uint64;
      subkey_id : uint64;
      ctx : String;
      key : Block8) return int  -- ./sodium/crypto_kdf.h:39
   with Import => True,
        Convention => C,
        External_Name => "crypto_kdf_derive_from_key";

   procedure crypto_kdf_keygen (k : out Block8)  -- ./sodium/crypto_kdf.h:46
   with Import => True,
        Convention => C,
        External_Name => "crypto_kdf_keygen";

end Libsodium_Binding;
