pragma Ada_2012;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with Libsodium_Binding; use Libsodium_Binding;

package Libsodium_Interface
with SPARK_Mode
is
Crypto_Error : exception;


  ------------------
  -- Generic Hash -
  ------------------
  Crypto_Generichash_BYTES_MIN     : constant uint8 := 16;
  Crypto_Generichash_BYTES         : constant uint8 := 32;
  Crypto_Generichash_BYTES_MAX     : constant uint8 := 64;
  Crypto_Generichash_KEYBYTES_MIN  : constant uint8 := 16;
  Crypto_Generichash_KEYBYTES      : constant uint8 := 32;
  Crypto_Generichash_KEYBYTES_MAX  : constant uint8 := 64;
  Crypto_Generichash_SALTBYTES     : constant uint8 := 16;
  Crypto_Generichash_PERSONALBYTES : constant uint8 := 16;

   procedure Crypto_Generichash
     (FP :    out Key;
      M  : in     MyArray;
      K  : in     Key) with
     Pre => FP'Length = Crypto_Generichash_BYTES
     and then K'Length = Crypto_Generichash_KEYBYTES;

   procedure Crypto_Generichash_Keyless
     (FP :    out Key;
      M  : in     MyArray) with
     Pre => FP'Length = Crypto_Generichash_BYTES;

   procedure Crypto_Generichash_Init
     (State :    out Crypto_Generichash_State;
      K     : in     Key) with
     Pre => K'Length = Crypto_Generichash_KEYBYTES;

   procedure Crypto_Generichash_Init_Keyless
     (State : out Crypto_Generichash_State);


   procedure Crypto_Generichash_Update
     (State :    out Crypto_Generichash_State;
      M     : in     MyArray);

   procedure Crypto_Generichash_Final
     (State :    out Crypto_Generichash_State;
      FP    : in     Key) with
     Pre => FP'Length = Crypto_Generichash_BYTES;

   procedure Crypto_Generichash_Keygen (K : out Key) with
     Post => K'Length=Crypto_Generichash_KEYBYTES;


end Libsodium_Interface;
