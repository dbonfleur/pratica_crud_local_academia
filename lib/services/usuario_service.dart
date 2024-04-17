// lib/services/usuario_service.dart
import 'package:password_hash_plus/password_hash_plus.dart';
import 'package:pratica_crud_local_academia/database/database_helper.dart';
import 'package:pratica_crud_local_academia/utils/password_utils.dart';
import 'package:sqflite/sqflite.dart';
import '../models/usuario.dart';

class UsuarioService {
  

  Future<void> inserirUsuario(Usuario usuario) async {
    final db = await DatabaseHelper.instance.database;
    var passwordUtils = PasswordUtils();
    String salt = Salt.generateAsBase64String(24);
    String hashedPassword = passwordUtils.hashPassword(usuario.senha);
    var usuarioMap = usuario.toMap();
    usuarioMap['senha'] = hashedPassword;
    usuarioMap['salt'] = salt;
    await db.insert('usuarios', usuarioMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Usuario>> buscarUsuarios() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<void> deletarUsuario(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
