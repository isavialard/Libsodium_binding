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
   Put_Line ("Salt :");
   for I in Salt'First .. Salt'Last loop
      Put (uint8'Image (Salt (I)));
   end loop;
   Put_Line ("");
   Put_Line ("Key :");
   for I in K'First .. K'Last loop
      Put (uint8'Image (K (I)));
   end loop;
   Put_Line ("");
end Test_Pwhash;
