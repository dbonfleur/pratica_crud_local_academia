class Usuario {
  int? id; 
  String nome;
  String sobrenome;
  DateTime dataNascimento;
  String ?fotoPerfil;
  String senha;
  String salt;
  String email;
  String telefone;
  String telefoneEmergencia;

  Usuario({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.dataNascimento,
    this.fotoPerfil,
    required this.senha,
    required this.salt,
    required this.email,
    required this.telefone,
    required this.telefoneEmergencia,
  });

  Map<String, dynamic> toMap() {
    String formattedDataNascimento = '${dataNascimento.day.toString().padLeft(2, '0')}/${dataNascimento.month.toString().padLeft(2, '0')}/${dataNascimento.year}';
    return {
      'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'dataNascimento': formattedDataNascimento,  // Permite nulo
      'fotoPerfil': fotoPerfil,  // Permite nulo
      'senha': senha,
      'salt': salt,
      'email': email,
      'telefone': telefone,
      'telefoneEmergencia': telefoneEmergencia,
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    
    DateTime parseDataDeNascimento(String dataStr) {
      List<String> partes = dataStr.split('/');
      if (partes.length != 3) {
        throw const FormatException('Formato de data inválida');
      }
      int dia = int.parse(partes[0]);
      int mes = int.parse(partes[1]);
      int ano = int.parse(partes[2]);
      return DateTime(ano, mes, dia);
    }

    return Usuario(
      id: map['id'],
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      dataNascimento: parseDataDeNascimento(map['dataNascimento']),
      fotoPerfil: map['fotoPerfil'],
      senha: map['senha'],
      salt: map['salt'],
      email: map['email'],
      telefone: map['telefone'],
      telefoneEmergencia: map['telefoneEmergencia'],
    );
  }
}
