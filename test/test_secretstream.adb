pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Secretstream is
   K : Secretstream_Key;
   State_Acc : crypto_secretstream_state;
   State_Open : crypto_secretstream_state;
   M_1 : Plain_Text (1 .. 32);
   M_2 : Plain_Text (1 .. 127);
   C_1 : Cipher_Text (M_1'First .. M_1'Last + 17);
   C_2 : Cipher_Text (M_2'First .. M_2'Last + 17);
   M_Open_1 : Plain_Text (M_1'First .. M_1'Last);
   M_Open_2 : Plain_Text (M_2'First .. M_2'Last);
   H : Header;

begin
   Randombytes (M_1);
   Randombytes (M_2);
   Crypto_Secretstream_Key (K);
   Crypto_Secretstream_Init_Push (State_Acc, H, K);
   Crypto_Secretstream_Push (State_Acc, C_1, M_1, 0);
   Crypto_Secretstream_Push (State_Acc, C_2, M_2, 0);
   Crypto_Secretstream_Init_Pull (State_Open, H, K);
   Crypto_Secretstream_Pull (State_Open, M_Open_1, 0, C_1);
   Crypto_Secretstream_Pull (State_Open, M_Open_2, 0, C_2);

   for I in M_1'First .. M_1'Last loop
      Put (uint8'Image (M_1 (I)));
   end loop;
   Put_Line ("");
   for I in M_1'First .. M_1'Last loop
      Put (uint8'Image (M_Open_1 (I)));
   end loop;
   Put_Line ("");
   for I in M_2'First .. M_2'Last loop
      Put (uint8'Image (M_2 (I)));
   end loop;
   Put_Line ("");
   for I in M_2'First .. M_2'Last loop
      Put (uint8'Image (M_Open_2 (I)));
   end loop;
   Put_Line ("");

end Test_Secretstream;
