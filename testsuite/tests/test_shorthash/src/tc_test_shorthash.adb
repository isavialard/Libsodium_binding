pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Shorthash is
   FP : Shorthash_Fingerprint;
   M : Block8 (1 .. 100);
   K : Shorthash_Key;
begin
   Randombytes (M);
   Crypto_Shorthash_Key (K);
   Crypto_Shorthash (FP, M, K);

   Put_Line ("Success !");

end Test_Shorthash;
