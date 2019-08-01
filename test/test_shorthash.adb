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

   Put_Line ("Key :");
   for I in K'First .. K'Last loop
      Put (uint8'Image (K (I)));
   end loop;
   Put_Line ("");
   Put_Line ("Fingerprint:");
   for I in FP'First .. FP'Last loop
      Put (uint8'Image (FP (I)));
   end loop;
   Put_Line ("");

end Test_Shorthash;
