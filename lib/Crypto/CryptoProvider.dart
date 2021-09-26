import 'package:encrypt/encrypt.dart';

class CryptoProvider {

  final key = Key.fromUtf8('UqXQYmV3fQmRhza9vyz70bnOp5T1qtuQ');
  final iv = IV.fromLength(16);

  Encrypter encrypter;

  CryptoProvider(){
    encrypter = Encrypter(AES(this.key));
  }


  Encrypted encrypt(String data) => encrypter.encrypt(data, iv: iv);

  String decrypt(Encrypted data) => encrypter.decrypt(data, iv: iv);
}