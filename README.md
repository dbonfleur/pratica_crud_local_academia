# Sistema de Gerenciamento de Academia

Este projeto é um sistema de gerenciamento de academia criado com Flutter demonstrar o cadastro de usuarios de uma academia.

## Recursos

- Cadastro, atualização, visualização e remoção de usuários.
- Persistência de dados local com SQLite.
- Criptografia de senha de usuário.

## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento do aplicativo móvel.
- **Dart**: Linguagem de programação usada pelo Flutter.
- **Sqflite**: Pacote Flutter para acesso e manipulação de banco de dados SQLite.
- **Password_hash_plus**: Pacote Flutter para criptografia de senhas (para uso em plataformas móveis e desktop).

## Estrutura do Projeto

O projeto segue uma estrutura modular e é dividido em várias camadas:

- `lib/main.dart`: Ponto de entrada do aplicativo Flutter.
- `lib/models/`: Definições de modelos de dados.
- `lib/views/`: Telas e componentes da interface do usuário.
- `lib/controllers/`: Controladores que gerenciam a lógica entre as views e os services.
- `lib/services/`: Serviços que contêm a lógica de negócios e operações de banco de dados.
- `lib/utils/`: Utilitários e funções auxiliares, como criptografia de senha.
- `lib/database/`: Inicialização e configuração do banco de dados SQLite.

## Instalação e Configuração

Para instalar e configurar o Sistema de Gerenciamento de Academia, siga os passos abaixo:

### Pré-requisitos

Certifique-se de ter o seguinte instalado no seu sistema antes de começar:
- [Flutter](https://flutter.dev/docs/get-started/install)
- Um editor de código de sua preferência (como Visual Studio Code ou Android Studio)

### Clonar o Repositório

Para obter o código fonte do projeto, clone o repositório Git utilizando o comando:

```bash
git clone https://github.com/dbonfleur/pratica_crud_local_academia
```

### Instalar Dependências

Navegue até a pasta do projeto clonado e execute o seguinte comando para instalar todas as dependências necessárias:

```bash
flutter pub get
```

### Executar o Aplicativo

Para iniciar o aplicativo em um emulador ou dispositivo conectado, execute:

```bash
flutter run
```

ATENÇÃO! Não execute com um emulador do navegador web, o banco de dados não vai estar operando!