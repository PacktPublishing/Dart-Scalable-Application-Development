import 'dart:io';

InternetAddress HOST = InternetAddress.LOOPBACK_IP_V6;
const int PORT = 4777;
SecureSocket socket;

void main() {
  SecureSocket.connect(HOST, PORT, onBadCertificate: (X509Certificate c) {
    print("Certificate WARNING: ${c.issuer}:${c.subject}");
    return true;
  }).then(handleSecureSocket);
}

handleSecureSocket(SecureSocket ss) {
  // send to server:
  ss.write("From client: can you encrypt me server?");
  // read from server:
  ss.listen((List data) {
    String msg = new String.fromCharCodes(data).trim();
    print(msg);
  });
}