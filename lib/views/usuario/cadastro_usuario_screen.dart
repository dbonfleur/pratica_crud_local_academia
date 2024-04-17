// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../controllers/usuario_controller.dart';
import '../../models/usuario.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  final UsuarioController controller;
  
  const CadastroUsuarioScreen({super.key, required this.controller});

  @override
  _CadastroUsuarioScreenState createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _telefoneEmergenciaController = TextEditingController();
  final _telefoneFormater = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  final _dataNascimentoFormatter = MaskTextInputFormatter(mask: '!#/@#/####', filter: { "!": RegExp(r'[0-3]'), 
                                                                                        "#": RegExp(r'[0-9]'),
                                                                                        "@": RegExp(r'[0-1]')});
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuário')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sobrenomeController,
                decoration: const InputDecoration(labelText: 'Sobrenome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o sobrenome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataNascimentoController,
                inputFormatters: [_dataNascimentoFormatter],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Data de Nascimento',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua data de nascimento';
                  }
                  if (RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                    List<String> partes = value.split('/');
                    
                    if (partes.length != 3) {
                      return 'Data inválida!';
                    }
                  } else {
                    return 'Data inválida!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _senhaController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                inputFormatters: [_telefoneFormater],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneEmergenciaController,
                inputFormatters: [_telefoneFormater],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Telefone de Emergência',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone de emergência';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
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
      
      final novoUsuario = Usuario(
        nome: _nomeController.text,
        sobrenome: _sobrenomeController.text,
        dataNascimento: parseDataDeNascimento(_dataNascimentoController.text),
        email: _emailController.text,
        senha: _senhaController.text,
        salt: '',
        telefone: _telefoneController.text,
        telefoneEmergencia: _telefoneEmergenciaController.text,
      );

      widget.controller.addUsuario(novoUsuario).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
        cleanText();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao cadastrar usuário: $error')),
        );
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _dataNascimentoController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _telefoneController.dispose();
    _telefoneEmergenciaController.dispose();
    super.dispose();
  }
  
  void cleanText() {
    _nomeController.clear();
    _sobrenomeController.clear();
    _dataNascimentoController.clear();
    _emailController.clear();
    _senhaController.clear();
    _telefoneController.clear();
    _telefoneEmergenciaController.clear();
  }
}
