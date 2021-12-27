require "selenium/webdriver"

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :selenium_chrome do |app|
  config = IntegrationConfig.new
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: config.options)
end

Capybara.register_driver :headless_selenium_chrome do |app|
  ENV["CIRCLECI"] ? create_driver_for_remote_browser(app) : create_driver_for_local_browser(app)
end

def create_driver_for_remote_browser(app)
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://localhost:4444/wd/hub",
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless no-sandbox window-size=1400,900] }
    )
  )
end

def create_driver_for_local_browser(app)
  config = IntegrationConfig.new
  config.enable_headless_mode!
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: config.options)
end
