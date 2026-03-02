require 'appium_lib'
require 'rspec'

caps = {
  caps: {
    platformName: "Android",
    deviceName: "emulator-5554",
    automationName: "UiAutomator2",
    app: "C:/Users/gabri/OneDrive/Desktop/appgas/product_registration.apk",
    appPackage: "br.com.pztec.estoque",
    appActivity: "br.com.pztec.estoque.Inicio",
    autoGrantPermissions: true,
    newCommandTimeout: 3600,
    noReset: false,
    fullReset: false,
    "appium:appWaitActivity" => "*",
    "appium:adbExecTimeout" => 60000,
    "appium:uiautomator2ServerInstallTimeout" => 60000,
    "appium:uiautomator2ServerReadTimeout" => 60000
  },
  appium_lib: {
    server_url: "http://127.0.0.1:4723"
  }
}

$driver = Appium::Driver.new(caps, true)
Appium.promote_appium_methods Object