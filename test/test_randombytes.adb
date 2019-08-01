pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Randombytes is
   Seed : Random_Seed;
   Buf : Block8 (1 .. 100);
begin
   Randombytes (Seed);
   Randombytes_Seed (Buf, Seed);

   Put_Line ("Random Seed:");
   for I in Seed'First .. Seed'Last loop
      Put (uint8'Image (Seed (I)));
   end loop;
   Put_Line ("");
   Put_Line ("Random Buf from Seed :");
   for I in Buf'First .. Buf'Last loop
      Put (uint8'Image (Buf (I)));
   end loop;
   Put_Line ("");
end Test_Randombytes;
