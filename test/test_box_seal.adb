pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Box_Seal is
   M : Plain_Text (1 .. 100);
   C : Cipher_Text (M'First .. M'Last + 48);
   PK : Box_Public_Key;
   SK : Box_Secret_Key;
   M_Final : Plain_Text (M'First .. M'Last);

begin
   Randombytes (M);
   Crypto_Box_Keypair (PK, SK);
   Crypto_Box_Seal (C, M, PK);
   Crypto_Box_Seal_Open (M_Final, C, PK, SK);
   Put_Line ("M Initial :");
   for I in M'First .. M'Last loop
      Put (uint8'Image (M (I)));
   end loop;
   Put_Line ("");
   Put_Line ("C :");
   for I in C'First .. C'Last loop
      Put (uint8'Image (C (I)));
   end loop;
   Put_Line ("");
   Put_Line ("M Final :");
   for I in M'First .. M'Last loop
      Put (uint8'Image (M_Final (I)));
   end loop;
end Test_Box_Seal;
