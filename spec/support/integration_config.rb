require "selenium/webdriver"

class IntegrationConfig
  SERVER_HOST = ENV['CAPYBARA_SERVER_HOST']
  SERVER_PORT = ENV['CAPYBARA_SERVER_PORT']
  APP_HOST = ENV['CAPYBARA_APP_HOST']

  attr_reader :options

  def initialize
    @options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1400,900")
  end

  def enable_headless_mode!
    options.add_argument("--headless")
  end
end