pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Sign_Multipart is
   M_1 : Plain_Text (1 .. 100);
   M_2 : Plain_Text (1 .. 50);
   PK : Sign_Public_Key;
   SK : Sign_Secret_Key;
   State : crypto_sign_state;
   State_Verify : crypto_sign_state;
   Sig : Signature;

begin
   Randombytes (M_1);
   Randombytes (M_2);
   Sodium_Init;
   Crypto_Sign_Keypair (PK, SK);
   Crypto_Sign_Init (State);
   Crypto_Sign_Update (State, M_1);
   Crypto_Sign_Update (State, M_2);
   Crypto_Sign_Final_Create (State, Sig, SK);


   Crypto_Sign_Init (State_Verify);
   Crypto_Sign_Update (State_Verify, M_1);
   Crypto_Sign_Update (State_Verify, M_2);
   Crypto_Sign_Final_Verify (State_Verify, Sig, PK);
   Put_Line ("Success !");

end Test_Sign_Multipart;
