# Automação Android com Appium e Cucumber

Exemplo de automação para cadastrar, editar, excluir e modificar a
quantidade de produtos em um app Android. Usa Ruby, Cucumber e Appium.
## Estrutura de pastas

```text
appgas/
├─ Gemfile                   # dependências Ruby
├─ features/
│  ├─ bdd/                   # cenários Gherkin
│  ├─ step_definitions/      # código dos passos
│  └─ support/               # configurações e hooks
└─ product_registration.apk   # app Android para testes
```
## Pré-requisitos

1. **Android Studio** 
2. **Appium** instalado e executando no Windows (PowerShell) ou WSL.
3. **Ruby 3.x** com Bundler (`rbenv`/`rvm` etc.).
4. **WSL2** (ou Linux) opcionalmente para executar os comandos Ruby.

> **Importante:** O servidor Appium está rodando no Windows, então as
depthabilidades `app` devem apontar para um caminho Windows (`C:/...`).

## Configuração rápida

1. Inicie um emulador ou conecte um dispositivo (USB debugging ativo).
2. Verifique que `product_registration.apk` está na raiz do projeto.
3. Abra o PowerShell e execute `appium` para iniciar o servidor.
4. No WSL/terminal Linux, no diretório do projeto:
   ```bash
   rm -f Gemfile.lock  
   bundle install
   ```
## Capabilities

`features/support/capabilities.yml` define as capabilities para Appium. A
chave `app` aponta para o APK via caminho Windows:

```yaml
caps:
  app: C:/Users/gabri/OneDrive/Desktop/appgas/product_registration.apk
  platformName: Android
  deviceName: emulator-5554
  automationName: UiAutomator2
  appPackage: br.com.pztech.estoque
  appActivity: br.com.pztech.estoque.Inicio
  appWaitActivity: br.com.pztech.estoque.Inicio
  avdArgs: -no-window
  newCommandTimeout: 3600
  autoGrantPermissions: true
  autoAcceptAlerts: true
  disableAndroidWatchers: true
  resetKeyboard: true

appium_lib:
  server_url: http://127.0.0.1:4723/wd/hub
```

`env.rb` transforma strings em símbolos e ajusta caminhos relativos.
## Executando os testes

Com Appium rodando e o emulador ativo, basta rodar no WSL:

```bash
bundle exec cucumber
```

Se o WSL não alcançar o Appium, substitua `127.0.0.1` pelo IP do Windows em
`capabilities.yml`.
## Cenários

Os testes estão descritos em
`features/bdd/product_registration.feature`:

- Registrar produto
- Editar produto
- Excluir produto
- Diminuir quantidade (Scenario Outline)

Os step definitions ficam em
`features/step_definitions/product_registration.step.rb`.
## Dicas rápidas

- `adb install -r "C:/Users/.../product_registration.apk"` instala o APK.
- Drag‑&‑drop do APK no emulador também funciona.
- Se houver falha de conexão, use o IP do Windows em vez de
  `127.0.0.1`.
---


