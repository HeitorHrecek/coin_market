# Coin Market

## Descrição
Um aplicativo Flutter para visualização de dados de criptomoedas em tempo real.

## Requisitos
- Flutter SDK
- Dart SDK
- Chrome (para execução web)

## Instalação

1. Clone o repositório:
```
git clone https://github.com/HeitorHrecek/coin_market.git
cd coin_market
```

2. Instale as dependências:
```
flutter pub get
```

3. Adicione sua API Key em lib\data\crypto_data_source 
Exemplo:
```
static const _apiKey = 'c7dc7e6f-758c-4e1f-88b6-50d2caf5982d';
```

## Execução

### Execução padrão
```
flutter run
```

### Execução na web com CORS desativado
Para executar o aplicativo no Chrome com as restrições de CORS desativadas, utilize o seguinte comando:
```
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

> **Nota**: A desativação do CORS é necessária para permitir que o aplicativo faça requisições para APIs externas diretamente do navegador.

## Estrutura do Projeto

- `lib/core/` - Constantes e utilitários
- `lib/data/` - Fontes de dados e serviços
- `lib/exceptions/` - Classes de exceção
- `lib/models/` - Modelos de dados
- `lib/repositories/` - Repositórios para acesso aos dados
- `lib/viewmodels/` - ViewModels para lógica de negócios
- `lib/views/` - Telas e widgets da interface

## Licença
Este projeto está licenciado sob a licença MIT.