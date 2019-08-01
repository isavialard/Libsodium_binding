pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Test_Kx is

   Client_PK : Kx_Public_Key;
   Client_SK : Kx_Secret_Key;
   Server_PK : Kx_Public_Key;
   Server_SK : Kx_Secret_Key;
   Client_RX : Kx_Session_Key;
   Server_RX : Kx_Session_Key;
   Client_TX : Kx_Session_Key;
   Server_TX : Kx_Session_Key;

begin

   Crypto_Kx_Keypair (Client_PK, Client_SK);
   Crypto_Kx_Keypair (Server_PK, Server_SK);
   Crypto_Kx_Client_Session_Keys (Client_RX, Client_TX, Client_PK,
                                  Client_SK, Server_PK);
   Crypto_Kx_Server_Session_Keys (Server_RX, Server_TX, Server_PK,
                                  Server_SK, Client_PK);
   Put_Line ("Client reception key");
   for I in Client_RX'First .. Client_RX'Last loop
      Put (uint8'Image (Client_RX (I)));
   end loop;
   Put_Line ("");
   Put_Line ("Client transfer key");
   for I in Client_RX'First .. Client_RX'Last loop
      Put (uint8'Image (Client_TX (I)));
   end loop;
   Put_Line ("");
   Put_Line ("Server reception key");
   for I in Client_RX'First .. Client_RX'Last loop
      Put (uint8'Image (Server_RX (I)));
   end loop;
   Put_Line ("");
   Put_Line ("Server transfer key");
   for I in Client_RX'First .. Client_RX'Last loop
      Put (uint8'Image (Server_TX (I)));
   end loop;
   Put_Line ("");

end Test_Kx;
