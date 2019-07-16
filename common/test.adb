pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test is

   procedure TestGenericHash is
      FP : Generichash_Fingerprint;
      M : constant Block8 := (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
          15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
                             27, 28, 29, 30, 31, 32);
   begin
      Libsodium_Interface.Crypto_Generichash_Keyless (FP, M);
      Put_Line (uint8'Image (FP(1)));
   end TestGenericHash;

begin
   TestGenericHash;
end Test;
