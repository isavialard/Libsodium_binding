pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Secretbox is
   M : Plain_Text (1 .. 100);
   C : Cipher_Text (M'First .. M'Last + 16);
   M_Final : Plain_Text (M'First .. M'Last);
   N : Secretbox_Nonce;
   K : Secretbox_Key;

begin
   Randombytes (M);
   Crypto_Secretbox_Key (K);
   Randombytes (N);
   Crypto_Secretbox_Easy (C, M, N, K);
   Crypto_Secretbox_Open_Easy (M_Final, C, N, K);
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

end Test_Secretbox;
