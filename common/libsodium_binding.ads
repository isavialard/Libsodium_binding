pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with System;


package Libsodium_Binding is

   --Types
   type uint64 is mod 2 ** 64;
   type uint32 is mod 2 ** 32;
   type uint8 is mod 2 ** 8;
   type MyArray is array(uint64 range<>) of uint8;
   type Key is array(uint8 range<>) of uint8;
   type anon1563_k_array is array (0 .. 31) of aliased unsigned_char;
   type anon1563_nonce_array is array (0 .. 11) of aliased unsigned_char;
   type anon1563_u_pad_array is array (0 .. 7) of aliased unsigned_char;
   type crypto_secretstream_xchacha20poly1305_state is record
      k : aliased anon1563_k_array;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:57
      nonce : aliased anon1563_nonce_array;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:58
      u_pad : aliased anon1563_u_pad_array;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:59
   end record
     with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:56
   type anon1186_state_array is array (0 .. 7) of aliased uint64;
   type anon1186_count_array is array (0 .. 1) of aliased uint64;
   type anon1186_buf_array is array (0 .. 127) of aliased uint8;
   type crypto_hash_sha512_state is record
      state : aliased anon1186_state_array;  -- ./sodium/crypto_hash_sha512.h:25
      count : aliased anon1186_count_array;  -- ./sodium/crypto_hash_sha512.h:26
      buf : aliased anon1186_buf_array;  -- ./sodium/crypto_hash_sha512.h:27
   end record
   with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_hash_sha512.h:24

   type crypto_sign_state is record
      hs : aliased crypto_hash_sha512_state;  -- ./sodium/crypto_sign_ed25519.h:16
   end record
     with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_sign_ed25519.h:15
   type anon1299_opaque_array is array (0 .. 383) of aliased unsigned_char;
   type crypto_generichash_state is record
      opaque : aliased anon1299_opaque_array;  -- ./sodium/crypto_generichash_blake2b.h:24
   end record
     with Convention => C_Pass_By_Copy;  -- ./sodium/crypto_generichash_blake2b.h:23




   --Init
   function sodium_init return int  -- ./sodium/core.h:12
      with Import => True,
           Convention => C,
     External_Name => "sodium_init";

   --Padding
   function sodium_pad
     (padded_buflen_p : out uint64;
      buf : out MyArray;
      unpadded_buflen : uint64;
      blocksize : uint64;
      max_buflen : uint64) return int  -- ./sodium/utils.h:162
   with Import => True,
        Convention => C,
        External_Name => "sodium_pad";

   function sodium_unpad
     (unpadded_buflen_p : out uint64;
      buf : MyArray;
      padded_buflen : uint64;
      blocksize : uint64) return int  -- ./sodium/utils.h:167
   with Import => True,
        Convention => C,
        External_Name => "sodium_unpad";

   --Randombytes
   procedure randombytes_buf (buf : System.Address; size : uint64)  -- ./sodium/randombytes.h:35
   with Import => True,
        Convention => C,
        External_Name => "randombytes_buf";
   procedure randombytes_buf_deterministic
     (buf : System.Address;
      size : uint64;
      seed : MyArray)  -- ./sodium/randombytes.h:39
   with Import => True,
        Convention => C,
     External_Name => "randombytes_buf_deterministic";
    function randombytes_random return uint32 -- ./sodium/randombytes.h:44
   with Import => True,
        Convention => C,
        External_Name => "randombytes_random";

   function randombytes_uniform (upper_bound :uint32) return uint32  -- ./sodium/randombytes.h:47
   with Import => True,
        Convention => C,
        External_Name => "randombytes_uniform";

   procedure randombytes_stir  -- ./sodium/randombytes.h:50
   with Import => True,
        Convention => C,
        External_Name => "randombytes_stir";

   function randombytes_close return int  -- ./sodium/randombytes.h:53
   with Import => True,
        Convention => C,
     External_Name => "randombytes_close";

   --Secret key
   --Authenticated Encryption
   function crypto_secretbox_easy
     (c : MyArray;
      m : MyArray;
      mlen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_secretbox.h:37
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_easy";

   function crypto_secretbox_open_easy
     (m : MyArray;
      c : MyArray;
      clen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_secretbox.h:42
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_open_easy";

   function crypto_secretbox_detached
     (c : MyArray;
      mac : MyArray;
      m : MyArray;
      mlen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_secretbox.h:48
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_detached";

   function crypto_secretbox_open_detached
     (m : MyArray;
      c : MyArray;
      mac : MyArray;
      clen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_secretbox.h:56
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretbox_open_detached";

   procedure crypto_secretbox_keygen (k : MyArray)  -- ./sodium/crypto_secretbox.h:65
   with Import => True,
        Convention => C,
     External_Name => "crypto_secretbox_keygen";

   --Encrypted streams and file encryption
   procedure crypto_secretstream_xchacha20poly1305_keygen (k : MyArray)  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:66
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_keygen";

   function crypto_secretstream_xchacha20poly1305_init_push
     (state : out crypto_secretstream_xchacha20poly1305_state;
      header : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:71
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_init_push";

   function crypto_secretstream_xchacha20poly1305_push
     (state : out crypto_secretstream_xchacha20poly1305_state;
      c : MyArray;
      clen_p : out Uint64;
      m : MyArray;
      mlen : Uint64;
      ad : MyArray;
      adlen : Uint64;
      tag : unsigned_char) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:78
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_push";

   function crypto_secretstream_xchacha20poly1305_init_pull
     (state : out crypto_secretstream_xchacha20poly1305_state;
      header : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:86
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_init_pull";

   function crypto_secretstream_xchacha20poly1305_pull
     (state : out crypto_secretstream_xchacha20poly1305_state;
      m : MyArray;
      mlen_p : out Uint64;
      tag_p : MyArray;
      c : MyArray;
      clen : Uint64;
      ad : MyArray;
      adlen : Uint64) return int  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:93
   with Import => True,
        Convention => C,
        External_Name => "crypto_secretstream_xchacha20poly1305_pull";

   procedure crypto_secretstream_xchacha20poly1305_rekey (state : out crypto_secretstream_xchacha20poly1305_state)  -- ./sodium/crypto_secretstream_xchacha20poly1305.h:101
   with Import => True,
        Convention => C,
     External_Name => "crypto_secretstream_xchacha20poly1305_rekey";

   --Authentication
   function crypto_auth
     (c_out : MyArray;
      c_in : MyArray;
      inlen : Uint64;
      k : MyArray) return int  -- ./sodium/crypto_auth.h:29
   with Import => True,
        Convention => C,
        External_Name => "crypto_auth";

   function crypto_auth_verify
     (h : MyArray;
      c_in : MyArray;
      inlen : Uint64;
      k : MyArray) return int  -- ./sodium/crypto_auth.h:34
   with Import => True,
        Convention => C,
        External_Name => "crypto_auth_verify";

   procedure crypto_auth_keygen (k : MyArray)  -- ./sodium/crypto_auth.h:39
   with Import => True,
        Convention => C,
     External_Name => "crypto_auth_keygen";

   --Public Key
   -- Authenticated encryption
   function crypto_box_seed_keypair
     (pk : MyArray;
      sk : MyArray;
      seed : MyArray) return int  -- ./sodium/crypto_box.h:52
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_seed_keypair";

   function crypto_box_keypair (pk : MyArray; sk : MyArray) return int  -- ./sodium/crypto_box.h:57
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_keypair";

   function crypto_box_easy
     (c : MyArray;
      m : MyArray;
      mlen : Uint64;
      n : MyArray;
      pk : MyArray;
      sk : MyArray) return int  -- ./sodium/crypto_box.h:61
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_easy";

   function crypto_box_open_easy
     (m : MyArray;
      c : MyArray;
      clen : Uint64;
      n : MyArray;
      pk : MyArray;
      sk : MyArray) return int  -- ./sodium/crypto_box.h:67
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_open_easy";

   function crypto_box_detached
     (c : MyArray;
      mac : MyArray;
      m : MyArray;
      mlen : Uint64;
      n : MyArray;
      pk : MyArray;
      sk : MyArray) return int  -- ./sodium/crypto_box.h:73
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_detached";

   function crypto_box_open_detached
     (m : MyArray;
      c : MyArray;
      mac : MyArray;
      clen : Uint64;
      n : MyArray;
      pk : MyArray;
      sk : MyArray) return int  -- ./sodium/crypto_box.h:80
   with Import => True,
        Convention => C,
     External_Name => "crypto_box_open_detached";

   function crypto_box_beforenm
     (k : MyArray;
      pk : MyArray;
      sk : MyArray) return int  -- ./sodium/crypto_box.h:95
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_beforenm";

   function crypto_box_easy_afternm
     (c : MyArray;
      m : MyArray;
      mlen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_box.h:100
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_easy_afternm";

   function crypto_box_open_easy_afternm
     (m : MyArray;
      c : MyArray;
      clen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_box.h:105
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_open_easy_afternm";

   function crypto_box_detached_afternm
     (c : MyArray;
      mac : MyArray;
      m : MyArray;
      mlen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_box.h:111
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_detached_afternm";

   function crypto_box_open_detached_afternm
     (m : MyArray;
      c : MyArray;
      mac : MyArray;
      clen : Uint64;
      n : MyArray;
      k : MyArray) return int  -- ./sodium/crypto_box.h:117
   with Import => True,
        Convention => C,
     External_Name => "crypto_box_open_detached_afternm";

   --Public Key Signatures
    function crypto_sign_seed_keypair
     (pk : MyArray;
      sk : MyArray;
      seed : MyArray) return int  -- ./sodium/crypto_sign.h:53
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_seed_keypair";

   function crypto_sign_keypair (pk : MyArray; sk : MyArray) return int  -- ./sodium/crypto_sign.h:58
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_keypair";

   function crypto_sign
     (sm : MyArray;
      smlen_p : out Uint64;
      m : MyArray;
      mlen : Uint64;
      sk : MyArray) return int  -- ./sodium/crypto_sign.h:62
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign";

   function crypto_sign_open
     (m : MyArray;
      mlen_p : out Uint64;
      sm : MyArray;
      smlen : Uint64;
      pk : MyArray) return int  -- ./sodium/crypto_sign.h:67
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_open";

   function crypto_sign_detached
     (sig : MyArray;
      siglen_p : out Uint64;
      m : MyArray;
      mlen : Uint64;
      sk : MyArray) return int  -- ./sodium/crypto_sign.h:73
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_detached";

   function crypto_sign_verify_detached
     (sig : MyArray;
      m : MyArray;
      mlen : Uint64;
      pk : MyArray) return int  -- ./sodium/crypto_sign.h:78
   with Import => True,
        Convention => C,
     External_Name => "crypto_sign_verify_detached";

   function crypto_sign_init (state : out crypto_sign_state) return int  -- ./sodium/crypto_sign.h:85
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_init";

   function crypto_sign_update
     (state : out crypto_sign_state;
      m : MyArray;
      mlen : Uint64) return int  -- ./sodium/crypto_sign.h:88
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_update";

   function crypto_sign_final_create
     (state : out crypto_sign_state;
      sig : MyArray;
      siglen_p : out Uint64;
      sk : MyArray) return int  -- ./sodium/crypto_sign.h:93
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_final_create";

   function crypto_sign_final_verify
     (state : out crypto_sign_state;
      sig : MyArray;
      pk : MyArray) return int  -- ./sodium/crypto_sign.h:99
   with Import => True,
        Convention => C,
     External_Name => "crypto_sign_final_verify";

   function crypto_sign_ed25519_sk_to_seed (seed : MyArray; sk : MyArray) return int  -- ./sodium/crypto_sign_ed25519.h:89
   with Import => True,
        Convention => C,
        External_Name => "crypto_sign_ed25519_sk_to_seed";

   function crypto_sign_ed25519_sk_to_pk (pk : MyArray; sk : MyArray) return int  -- ./sodium/crypto_sign_ed25519.h:94
   with Import => True,
        Convention => C,
     External_Name => "crypto_sign_ed25519_sk_to_pk";

   --Sealed Box
   function crypto_box_sealbytes return uint64  -- ./sodium/crypto_box.h:127
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_sealbytes";

   function crypto_box_seal
     (c : MyArray;
      m : MyArray;
      mlen : Uint64;
      pk : MyArray) return int  -- ./sodium/crypto_box.h:130
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_seal";

   function crypto_box_seal_open
     (m : MyArray;
      c : MyArray;
      clen : Uint64;
      pk : MyArray;
      sk : MyArray) return int  -- ./sodium/crypto_box.h:135
   with Import => True,
        Convention => C,
        External_Name => "crypto_box_seal_open";






   -- Generic Hash
   function crypto_generichash
     (c_out : out Key;
      outlen : in uint8;
      c_in : in MyArray;
      inlen : in uint64;
      K : in Key;
      keylen : in uint8) return int  -- ./sodium/crypto_generichash.h:54
   with Import => True,
        Convention => C,
   External_Name => "crypto_generichash";


   function crypto_generichash_init
     (state : out crypto_generichash_state;
      K : Key;
      keylen : uint8;
      outlen : uint8) return int  -- ./sodium/crypto_generichash.h:60
   with Import => True,
        Convention => C,
        External_Name => "crypto_generichash_init";

   function crypto_generichash_update
     (state : out crypto_generichash_state;
      c_in : MyArray;
      inlen : Uint64) return int  -- ./sodium/crypto_generichash.h:66
   with Import => True,
        Convention => C,
        External_Name => "crypto_generichash_update";

   function crypto_generichash_final
     (state : out crypto_generichash_state;
      c_out : Key;
      outlen : uint8) return int  -- ./sodium/crypto_generichash.h:72
   with Import => True,
        Convention => C,
        External_Name => "crypto_generichash_final";

   procedure crypto_generichash_keygen (k : out Key)  -- ./sodium/crypto_generichash.h:77
   with Import => True,
        Convention => C,
     External_Name => "crypto_generichash_keygen";

   --Short Hash
   function crypto_shorthash
     (c_out : Key;
      c_in : MyArray;
      inlen : Uint64;
      k : Key) return int  -- ./sodium/crypto_shorthash.h:29
   with Import => True,
        Convention => C,
        External_Name => "crypto_shorthash";

   procedure crypto_shorthash_keygen (k : Key)  -- ./sodium/crypto_shorthash.h:34
   with Import => True,
        Convention => C,
        External_Name => "crypto_shorthash_keygen";

   --Hash
   function crypto_hash
     (c_out : Key;
      c_in : MyArray;
      inlen : Uint64) return int  -- ./sodium/crypto_hash.h:28
   with Import => True,
        Convention => C,
        External_Name => "crypto_hash";

   --Password hash
    function crypto_pwhash
     (c_out : MyArray;
      outlen : Uint64;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Uint64;
      salt : MyArray;
      opslimit : Uint64;
      memlimit : uint64;
      alg : int) return int  -- ./sodium/crypto_pwhash.h:104
   with Import => True,
        Convention => C,
        External_Name => "crypto_pwhash";


   function crypto_pwhash_str
     (c_out : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Uint64;
      opslimit : Uint64;
      memlimit : uint64) return int  -- ./sodium/crypto_pwhash.h:116
   with Import => True,
        Convention => C,
     External_Name => "crypto_pwhash_str";

   function crypto_pwhash_str_verify
     (str : Interfaces.C.Strings.chars_ptr;
      passwd : Interfaces.C.Strings.chars_ptr;
      passwdlen : Uint64) return int  -- ./sodium/crypto_pwhash.h:128
   with Import => True,
        Convention => C,
        External_Name => "crypto_pwhash_str_verify";

   function crypto_pwhash_str_needs_rehash
     (str : Interfaces.C.Strings.chars_ptr;
      opslimit : Uint64;
      memlimit : uint64) return int  -- ./sodium/crypto_pwhash.h:134
   with Import => True,
        Convention => C,
        External_Name => "crypto_pwhash_str_needs_rehash";

   --Key exchange
    function crypto_kx_seed_keypair
     (pk : MyArray;
      sk : MyArray;
      seed : MyArray) return int  -- ./sodium/crypto_kx.h:36
   with Import => True,
        Convention => C,
        External_Name => "crypto_kx_seed_keypair";

   function crypto_kx_keypair (pk : MyArray; sk : MyArray) return int  -- ./sodium/crypto_kx.h:42
   with Import => True,
        Convention => C,
        External_Name => "crypto_kx_keypair";

   function crypto_kx_client_session_keys
     (rx : MyArray;
      tx : MyArray;
      client_pk : MyArray;
      client_sk : MyArray;
      server_pk : MyArray) return int  -- ./sodium/crypto_kx.h:47
   with Import => True,
        Convention => C,
        External_Name => "crypto_kx_client_session_keys";

   function crypto_kx_server_session_keys
     (rx : MyArray;
      tx : MyArray;
      server_pk : MyArray;
      server_sk : MyArray;
      client_pk : MyArray) return int  -- ./sodium/crypto_kx.h:55
   with Import => True,
        Convention => C,
        External_Name => "crypto_kx_server_session_keys";









end Libsodium_Binding;
