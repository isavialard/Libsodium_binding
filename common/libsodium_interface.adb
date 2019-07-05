
with Libsodium_Binding; use Libsodium_Binding;
package body Libsodium_Interface is

  ------------------
  -- Generic Hash -
  ------------------
   procedure Crypto_Generichash
     (FP :    out Key;
      M  : in     MyArray;
      K  : in     Key)
   is
      FPlen : uint8 := FP'Length;
   begin
      if Libsodium_Binding.crypto_generichash(FP, FPlen, M, M'Length, K, K'Length)/=0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash;

   procedure Crypto_Generichash_Keyless
     (FP :    out Key;
      M  : in     MyArray)
   is
      FPlen : uint8 := FP'Length;
      K :  constant Key (1 .. 0) := (others => 0);
   begin
      if crypto_generichash(FP, FPlen, M, M'Length, K, 0)/=0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Keyless;

   procedure Crypto_Generichash_Init
     (State :    out Crypto_Generichash_State;
      K     : in     Key)
   is
   begin
      if Libsodium_Binding.crypto_generichash_init(State, K, K'Length, Crypto_Generichash_BYTES)/=0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Init;

   procedure Crypto_Generichash_Init_Keyless
     (State : out Crypto_Generichash_State)
   is
      K :  constant Key (1 .. 0) := (others => 0);
   begin
      if Libsodium_Binding.crypto_generichash_init(State, K, 0, Crypto_Generichash_BYTES)/=0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Init_Keyless;


   procedure Crypto_Generichash_Update
     (State :    out Crypto_Generichash_State;
      M     : in     MyArray)
   is
   begin
      if Libsodium_Binding.crypto_generichash_update(State, m, m'Length)/=0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Update;

   procedure Crypto_Generichash_Final
     (State :    out Crypto_Generichash_State;
      FP    : in     Key)
   is
      FPlen : uint8 := FP'Length;
   begin
      if Libsodium_Binding.crypto_generichash_final(State, FP, FPlen)/=0 then
         raise Crypto_Error;
      end if;
   end Crypto_Generichash_Final;

   procedure Crypto_Generichash_Keygen (K : out Key)
   is
   begin
      Libsodium_Binding.crypto_generichash_keygen(K);
   end Crypto_Generichash_Keygen;



end Libsodium_Interface;
