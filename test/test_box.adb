pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Box is
   M_Alice  : Plain_Text (1 .. 100);
   C        : Cipher_Text (M_Alice'First .. M_Alice'Last + 16);
   PK_Alice : Box_Public_Key;
   SK_Alice : Box_Secret_Key;
   PK_Bob   : Box_Public_Key;
   SK_Bob   : Box_Secret_Key;
   M_Bob    : Plain_Text (M_Alice'First .. M_Alice'Last);
   N        : Box_Nonce;

begin
   Randombytes (M_Alice);
   Crypto_Box_Keypair (PK_Alice, SK_Alice);
   Crypto_Box_Keypair (PK_Bob, SK_Bob);
   Randombytes (N);
   Crypto_Box_Easy (C, M_Alice, N, PK_Bob, SK_Alice);
   Crypto_Box_Open_Easy (M_Bob, C, N, PK_Alice, SK_Bob);
   Put_Line ("M Initial :");
   for I in M_Bob'First .. M_Bob'Last loop
      Put (uint8'Image (M_Alice (I)));
   end loop;
   Put_Line ("");
   Put_Line ("C :");
   for I in C'First .. C'Last loop
      Put (uint8'Image (C (I)));
   end loop;
   Put_Line ("");
   Put_Line ("M Final :");
   for I in M_Bob'First .. M_Bob'Last loop
      Put (uint8'Image (M_Bob (I)));
   end loop;

end Test_Box;
