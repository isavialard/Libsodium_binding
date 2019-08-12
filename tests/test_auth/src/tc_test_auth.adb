pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;
with Interfaces.C; use Interfaces.C;

procedure Test_Auth is
   K : Auth_Key;
   Mac : Auth_Mac;
   M : Plain_Text (1 .. 17);
begin
   Randombytes (M);
   Libsodium_Interface.Crypto_Auth_Key (K);
   Crypto_Auth (Mac, M, K);
   if Crypto_Auth_Verify (Mac, M, K) = 0 then
      Put_Line ("Success !");
   end if;

end Test_Auth;
