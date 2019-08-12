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
   for I in M'First .. M'Last loop
      if M(I) /= M_Final(I) then raise Crypto_Error;
      end if;
   end loop;
   Put_Line ("Success !");
   
end Test_Box_Seal;
