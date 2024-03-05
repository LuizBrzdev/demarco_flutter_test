# Nome do Seu Projeto

Teste para demarco

## Arquitetura: Clean Dart

O Clean Dart é uma abordagem de arquitetura de software para desenvolvimento de aplicativos Flutter. Ele visa tornar os aplicativos mais organizados, testáveis e fáceis de manter, através da separação de responsabilidades em diferentes camadas.

Mais detalhes confira [aqui](https://github.com/Flutterando/Clean-Dart) para obter mais detalhes!

src
├── domain
│   ├── entities
│   │   └── my_entity.dart
│   └── repositories
│       └── my_repository.dart
├── external
│   ├── datasources - (Implementation)
│   │    └── db_access.dart
│   └── adapters
│         └── my_adapter.dart
├── infra
│   ├── datasources
│   │   └── my_datasource.dart
│   └── repositories - (Implementation)
│       └── my_repository_imp.dart
├── presentation
│   ├── pages
│   │   └── my_page.dart
│   ├── widgets
│   │   └── my_widget.dart
│   ├── bindings
│   │   └── my_bindings.dart
│   └── blocs
│       ├── states
│       │   └── my_states.dart
│       └── cubits
│           └── my_cubit.dart
│ 
└── main.dart


### Domain
- Define as entidades principais e os contratos dos repositórios.

### External
- Contém implementações para acessar fontes de dados externas.
- Adapta os dados externos para o formato esperado pela aplicação.

### Infra
- Implementa os contratos definidos no domínio.
- Acessa fontes de dados internas e manipula os dados.

### Presentation
- Gerencia a interface do usuário.
- Inclui telas, widgets reutilizáveis, injeção de dependências e gerenciamento de estado.


## Bibliotecas Utilizadas

- **cupertino_icons**: Ícones específicos do iOS para Flutter.
  - [Cupertino Icons](https://pub.dev/packages/cupertino_icons)

- **bloc**: Gerenciamento de estado 
  - [Bloc](https://pub.dev/packages/bloc)

- **flutter_bloc**: Implementação de bloc para Flutter.
  - [Flutter Bloc](https://pub.dev/packages/flutter_bloc)

- **get_it**: Service locator para injeção de dependências .
  - [Get It](https://pub.dev/packages/get_it)

- **mask_text_input_formatter**: Um plug-in Flutter para formatar e validar campos de texto.
  - [Mask Text Input Formatter](https://pub.dev/packages/mask_text_input_formatter)

- **animate_do**: Conjunto de widgets de animação prontos para usar para Flutter.
  - [Animate Do](https://pub.dev/packages/animate_do)

- **isar**: Um banco de dados NoSQL nativo rápido e leve para Flutter.
  - [Isar](https://pub.dev/packages/isar)

- **isar_flutter_libs**: Pacote complementar para uso do Isar com Flutter.
  - [Isar Flutter Libs](https://pub.dev/packages/isar_flutter_libs)

- **path_provider**: Fornece funções para encontrar caminhos de diretórios típicos no sistema de arquivos.
  - [Path Provider](https://pub.dev/packages/path_provider)

- **intl**: Oferece suporte a internacionalização e formatação de datas e números.
  - [Intl](https://pub.dev/packages/intl)

- **skeletonizer**: Um esqueleto de tela personalizável e animado para Flutter.
  - [Skeletonizer](https://pub.dev/packages/skeletonizer)

- **file_picker**: Uma biblioteca para selecionar arquivos do sistema de arquivos.
  - [File Picker](https://pub.dev/packages/file_picker)

## Dependências de Desenvolvimento

- **flutter_test**: Pacote de teste para Flutter.
  - [Flutter Test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)

- **flutter_lints**: Um conjunto de lints recomendados pela equipe do Flutter.
  - [Flutter Lints](https://pub.dev/packages/flutter_lints)

- **build_runner**: Um conjunto de comandos e bibliotecas para gerar código.
  - [Build Runner](https://pub.dev/packages/build_runner)

- **isar_generator**: Gerador de código para o Isar.
  - [Isar Generator](https://pub.dev/packages/isar_generator)

- **mocktail**: Uma biblioteca de simulação para testes.
  - [Mocktail](https://pub.dev/packages/mocktail)


## Como executar um projeto Flutter

1. **Instale o Flutter e o Dart SDK**: Se você ainda não tem o Flutter e o Dart SDK instalados, siga as instruções na [documentação oficial](https://flutter.dev/docs/get-started/install) para sua plataforma.

2. **Clone o repositório do projeto**: Se você ainda não o fez, clone o repositório do projeto para o seu ambiente de desenvolvimento local.

3. **Execute o comando `flutter pub get`**: Antes de executar o projeto, certifique-se de que todas as dependências estejam instaladas. No terminal, navegue até o diretório do projeto e execute o comando `flutter pub get` para baixar as dependências necessárias.

4. **Execute o aplicativo**: Agora você pode executar o aplicativo em um emulador ou dispositivo físico (Recomendo que seja em um Android)

Lembre-se de consultar a [documentação de instalação do Flutter](https://flutter.dev/docs/get-started/install) se precisar de mais orientações sobre como configurar seu ambiente de desenvolvimento.
