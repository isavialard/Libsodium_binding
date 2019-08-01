pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Generichash_multipart is
   M : constant Block8 := (1, 2, 3, 4, 5, 6, 7, 8);
   FP : Generichash_Fingerprint;
   FP_Keyless : Generichash_Fingerprint;
   K : Generichash_Key;
   State : crypto_generichash_state;
   State_Keyless : crypto_generichash_state;
begin
   Crypto_Generichash_Init_Keyless (State_Keyless);
   Crypto_Generichash_Update (State_Keyless, M);
   Crypto_Generichash_Final (State_Keyless, FP_Keyless);
   for I in FP'First .. FP'Last loop
      Put (uint8'Image (FP_Keyless (I)));
   end loop;
   Put_Line ("");
   Crypto_Generichash_Key (K);
   Crypto_Generichash_Init (State, K);
   Crypto_Generichash_Update (State, M);
   Crypto_Generichash_Final (State, FP);
   for I in FP'First .. FP'Last loop
      Put (uint8'Image (FP (I)));
   end loop;
   Put_Line ("");

end Test_Generichash_multipart;
