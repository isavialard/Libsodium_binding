pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Sign is
   M : Plain_Text (1 .. 100);
   SM : Plain_Text (M'First .. M'Last + 64);
   PK : Sign_Public_Key;
   SK : Sign_Secret_Key;
   M_Final : Plain_Text (M'First .. M'Last);

begin
   Randombytes (M);
   Crypto_Sign_Keypair (PK, SK);
   Crypto_Sign (SM, M, SK);
   Crypto_Sign_Open (M_Final, SM, PK);

   Put_Line ("M Initial :");
   for I in M'First .. M'Last loop
      Put (uint8'Image (M (I)));
   end loop;
   Put_Line ("");
   Put_Line ("Signed M :");
   for I in SM'First .. SM'Last loop
      Put (uint8'Image (SM (I)));
   end loop;
   Put_Line ("");
   Put_Line ("M Final :");
   for I in M_Final'First .. M_Final'Last loop
      Put (uint8'Image (M_Final (I)));
   end loop;

end Test_Sign;
