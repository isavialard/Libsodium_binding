pragma SPARK_Mode;

with Interfaces.C; use Interfaces.C;
with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test is
   use Libsodium_Binding;

   procedure TestGenericHash is
      FP : Key(1 .. 32);
      M : MyArray :=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32);
      K : Key :=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32);
   begin
      Libsodium_interface.crypto_generichash(FP,M,K); --then Put("");end if;
   end TestGenericHash;


begin
   TestGenericHash;
end Test;
