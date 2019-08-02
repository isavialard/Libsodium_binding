with Ada.Text_IO;   use Ada.Text_IO;

procedure TC_Example is
   pragma Assertion_Policy (Assert => Check);

begin
   Put_Line ("Hello World!");
end TC_Example;
