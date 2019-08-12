pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Pwhash is
   PW : constant Password := "Password";
   K : Pwhash_Key (1 .. 17);
   Salt : Pwhash_Salt;

begin
   Randombytes (Salt);
   Crypto_Pwhash (K, PW, Salt);
   Put_Line ("Success !");
end Test_Pwhash;
