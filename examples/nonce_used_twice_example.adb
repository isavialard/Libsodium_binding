pragma SPARK_Mode;
with Libsodium_Interface; use Libsodium_Interface;
with Libsodium_Binding; use Libsodium_Binding;
with Ada.Text_IO; use Ada.Text_IO;

procedure Nonce_Used_Twice_Example is
   M : Plain_Text (1 .. 100);
   C : Cipher_Text (M'First .. M'Last + 16);
   M_Final : Plain_Text (M'First .. M'Last);
   M_2 : Plain_Text (1 .. 100);
   C_2 : Cipher_Text (M'First .. M'Last + 16);
   M_Final_2 : Plain_Text (M'First .. M'Last);
   N : Secretbox_Nonce;
   K : Secretbox_Key;

begin
   Randombytes (M);
   Crypto_Secretbox_Key (K);
   Randombytes (N);
   Crypto_Secretbox_Easy (C, M, N, K);
   Crypto_Secretbox_Open_Easy (M_Final, C, N, K);
   Randombytes (M_2);
   Crypto_Secretbox_Easy (C_2, M_2, N, K);
   Crypto_Secretbox_Open_Easy (M_Final_2, C_2, N, K);
   Put_Line ("M Final :");
   for I in M'First .. M'Last loop
      Put (uint8'Image (M_Final (I)));
   end loop;
   Put_Line ("M Final :");
   for I in M'First .. M'Last loop
      Put (uint8'Image (M_Final_2 (I)));
   end loop;

end Nonce_Used_Twice_Example;
