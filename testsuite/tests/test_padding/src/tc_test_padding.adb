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
   Sodium_Pad (Padded_M, M, Blocksize);
   declare
      Unpadded_Length : constant uint64 := Sodium_Unpad_Length (Padded_M);
      Unpadded_M : Plain_Text (1 .. Unpadded_Length);
   begin
      Sodium_Unpad (Unpadded_M, Padded_M, Blocksize);
      
   end;
   Put_Line("Success !");
end Test_Padding;
