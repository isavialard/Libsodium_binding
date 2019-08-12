pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Sign_Then_Encrypt_Example is
   M_Alice  : Plain_Text (1 .. 100);
   SM_Alice : Plain_Text (M_Alice'First .. M_Alice'Last + 64);
   C        : Cipher_Text (SM_Alice'First .. SM_Alice'Last + 16);
   PK_Alice : Box_Public_Key;
   SK_Alice : Box_Secret_Key;
   PK_Bob   : Box_Public_Key;
   SK_Bob   : Box_Secret_Key;
   Sign_PK_Alice : Sign_Public_Key;
   Sign_SK_Alice : Sign_Secret_Key;
   M_Bob    : Plain_Text (M_Alice'First .. M_Alice'Last);
   SM_Bob   : Plain_Text (M_Alice'First .. M_Alice'Last + 64);
   N        : Box_Nonce;

begin
   Randombytes (M_Alice);
   Crypto_Box_Keypair (PK_Alice, SK_Alice);
   Crypto_Box_Keypair (PK_Bob, SK_Bob);
   Crypto_Sign_Keypair (Sign_PK_Alice, Sign_SK_Alice);
   Randombytes (N);
   Crypto_Sign (SM_Alice, M_Alice, Sign_SK_Alice);
   Crypto_Box_Easy (C, SM_Alice, N, PK_Bob, SK_Alice);
   Crypto_Box_Open_Easy (SM_Bob, C, N, PK_Alice, SK_Bob);
   Crypto_Sign_Open (M_Bob, SM_Bob, Sign_PK_Alice);
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

end Sign_Then_Encrypt_Example;
