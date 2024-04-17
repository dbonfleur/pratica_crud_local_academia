
import 'package:password_hash_plus/password_hash_plus.dart';

class PasswordUtils {
  String hashPassword(String password) {
    var generator = PBKDF2();
    var salt = Salt.generateAsBase64String(24); // Gera um salt aleatório
    var hash = generator.generateBase64Key(password, salt, 1000, 32); // 1000 iterações, 32 comprimento da chave
    return hash;
  }

  bool verifyPassword(String password, String storedHash, String storedSalt) {
    var generator = PBKDF2();
    var hash = generator.generateBase64Key(password, storedSalt, 1000, 32);
    return hash == storedHash;
  }
}