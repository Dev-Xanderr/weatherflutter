# OpenWeather

Este é um aplicativo de previsão do tempo construído em Flutter utilizando a arquitetura MVVM (Model-View-ViewModel).

## Descrição

O aplicativo OpenWeather MVVM permite aos usuários verificar as condições meteorológicas atuais e detalhes adicionais para sua localização atual e outras cidades selecionadas.

## Funcionalidades Principais

- **Exibição Inicial**: Tela de splash com animação de transição suave para a tela inicial.
- **Conectividade**: Verifica a conexão com a internet para atualizações de dados.
- **Localização**: Utiliza a geolocalização para obter as coordenadas atuais do usuário.
- **Previsão do Tempo**: Mostra informações detalhadas como temperatura, umidade, pressão, nascer e pôr do sol.
- **Armazenamento Local**: Salva os dados meteorológicos usando SharedPreferences para acesso offline.

## Estrutura do Projeto

O projeto está estruturado com base nos seguintes componentes principais:

- **Model**: Contém as classes de modelo (`Weather`) para representar os dados meteorológicos.
- **ViewModel**: Lida com a lógica de negócios e a comunicação entre a camada de modelo e a camada de visualização.
- **View**: Contém as interfaces de usuário (`Screens`, `Widgets`) que são renderizadas para o usuário.
- **Utils**: Classes utilitárias como `Constants`, `Helper` para funções auxiliares e constantes.
- **Services**: Contém serviços como `LocationService` para obter a localização atual do usuário.


## Requisitos de Configuração

- Flutter SDK instalado
- Conexão com a internet para atualizações de dados em tempo real

## Como Executar o Projeto

1. Clone este repositório:

   ```bash
   git clone https://github.com/Dev-Xanderr/weatherflutter.git
   ```

2. Entre no diretório do projeto:

   ```bash
   cd openweather_mvvm
   ```

3. Instale as dependências:

   ```bash
   flutter pub get
   ```

4. Execute o aplicativo:

   ```bash
   flutter run
   ```
