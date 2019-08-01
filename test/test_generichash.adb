pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Generichash is
   M : constant Block8 := (1, 2, 3, 4, 5, 6, 7, 8);
   FP : Generichash_Fingerprint;
   FP_Keyless : Generichash_Fingerprint;
   K : Generichash_Key;
begin
   Crypto_Generichash_Keyless (FP, M);
   for I in FP'First .. FP'Last loop
      Put (uint8'Image (FP (I)));
   end loop;
   Put_Line ("");
   Crypto_Generichash_Key (K);
   Crypto_Generichash (FP_Keyless, M, K);
   for I in FP'First .. FP'Last loop
      Put (uint8'Image (FP_Keyless (I)));
   end loop;

end Test_Generichash;
