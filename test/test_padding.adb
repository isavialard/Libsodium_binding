pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Padding is

   M : Plain_Text (1 .. 100);
   Blocksize : constant uint64 := 64;
   Padded_M : Plain_Text (1 .. Sodium_Pad_Length (M'Length, Blocksize));

begin
   Randombytes (M);
   for I in M'First .. M'Last loop
      Put (uint8'Image (M (I)));
   end loop;
   Put_Line ("");
   Sodium_Pad (Padded_M, M, Blocksize);
   for I in Padded_M'First .. Padded_M'Last loop
      Put (uint8'Image (Padded_M (I)));
   end loop;
   Put_Line ("");

   declare
      Unpadded_Length : constant uint64 := Sodium_Unpad_Length (Padded_M);
      Unpadded_M : Plain_Text (1 .. Unpadded_Length);
   begin
      Sodium_Unpad (Unpadded_M, Padded_M, Blocksize);
      for I in Unpadded_M'First .. Unpadded_M'Last loop
         Put (uint8'Image (Unpadded_M (I)));
      end loop;
   end;

end Test_Padding;
