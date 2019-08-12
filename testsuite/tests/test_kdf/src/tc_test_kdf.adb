pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Kdf is

   Key : Kdf_Key;
   DK1 : Block8 (1 .. 32);
   DK2 : Block8 (1 .. 32);
   DK3 : Block8 (1 .. 64);
   DK4 : Block8 (1 .. 16);


begin
   Crypto_Kdf_Key (Key);
   Crypto_Kdf_Derive_From_Key (DK1, 1, "Context ", Key);
   Crypto_Kdf_Derive_From_Key (DK2, -1, "Context ", Key);
   Crypto_Kdf_Derive_From_Key (DK3, 1, "Context ", Key);
   Crypto_Kdf_Derive_From_Key (DK4, 1, "Context ", Key);
   
   Put_Line ("Success !");

end Test_Kdf;
