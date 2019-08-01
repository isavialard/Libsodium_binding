pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Interfaces.C; use Interfaces.C;

procedure Test_integer is
begin
   Put_Line (uint64'Image (uint64'First));
   Put_Line (Integer'Image (Integer'First));
   Put_Line (int'Image (int'First));
   Put_Line (uint64'Image (uint64'Last));
   Put_Line (Integer'Image (Integer'Last));
   Put_Line (int'Image (int'Last));
end Test_integer;
