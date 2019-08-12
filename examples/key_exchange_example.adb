pragma SPARK_Mode;

with Ada.Text_IO;  use Ada.Text_IO;
with Libsodium_Binding; use Libsodium_Binding;
with Libsodium_Interface; use Libsodium_Interface;

procedure Key_Exchange_Example is
   Client_PK : Kx_Public_Key;
   Client_SK : Kx_Secret_Key;
   Server_PK : Kx_Public_Key;
   Server_SK : Kx_Secret_Key;
   Client_RX : Kx_Session_Key;
   Server_RX : Kx_Session_Key;
   Client_TX : Kx_Session_Key;
   Server_TX : Kx_Session_Key;
   Q_Client : Plain_Text (1 .. 100);
   Q_Server : Plain_Text (1 .. 100);
   A_Client : Plain_Text (1 .. 100);
   A_Server : Plain_Text (1 .. 100);
   N_Q : Secretbox_Nonce;
   N_A : Secretbox_Nonce;
   Cipher_Q : Cipher_Text (1 .. 100 + Crypto_Secretbox_MACBYTES);
   Cipher_A : Cipher_Text (1 .. 100 + Crypto_Secretbox_MACBYTES);

begin

   Put_Line ("The server and the client exchange keys");
   Crypto_Kx_Keypair (Client_PK, Client_SK);
   Crypto_Kx_Keypair (Server_PK, Server_SK);
   Crypto_Kx_Client_Session_Keys (Client_RX, Client_TX, Client_PK,
                                  Client_SK, Server_PK);
   Crypto_Kx_Server_Session_Keys (Server_RX, Server_TX, Server_PK,
                                  Server_SK, Client_PK);
   Randombytes (N_A);
   Randombytes (N_Q);
   Randombytes (Q_Client);
   Randombytes (A_Server);
   Put_Line ("The client asks a question to the server:");
   Crypto_Secretbox_Easy (Cipher_Q, Q_Client, N_Q, Client_TX);
   for I in Q_Client'First .. Q_Client'Last loop
      Put (uint8'Image(Q_Client(I)));
   end loop;
   Put_Line ("");
   Put_Line (" Encrypted question :");
   for I in Q_Client'First .. Q_Client'Last + Crypto_Secretbox_MACBYTES loop
      Put (uint8'Image(Cipher_Q(I)));
   end loop;
   Put_Line ("");
   Put_Line ("The server decrypts it");
   Crypto_Secretbox_Open_Easy (Q_Server, Cipher_Q, N_Q, Server_RX);
    for I in Q_Server'First .. Q_Server'Last loop
      Put (uint8'Image(Q_Server(I)));
   end loop;
   Put_Line ("");
   Put_Line ("The server answers to the client:");
   Crypto_Secretbox_Easy (Cipher_A, A_Server, N_A, Server_TX);
   for I in Q_Client'First .. Q_Client'Last loop
      Put (uint8'Image(A_Server(I)));
   end loop;
   Put_Line ("");
   Put_Line (" Encrypted answer :");
   for I in Q_Client'First .. Q_Client'Last + Crypto_Secretbox_MACBYTES loop
      Put (uint8'Image(Cipher_A(I)));
   end loop;
   Put_Line ("");
   Put_Line ("The client decrypts it");
   Crypto_Secretbox_Open_Easy (A_Client, Cipher_A, N_A, Client_RX);
   for I in Q_Server'First .. Q_Server'Last loop
      Put (uint8'Image(A_Client(I)));
   end loop;
   Put_Line ("");





end Key_Exchange_Example;
