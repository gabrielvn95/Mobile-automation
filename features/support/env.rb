require 'appium_lib'
require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'faker'
require 'rubygems'

raw_caps = YAML.load(File.read(File.join(File.dirname(__FILE__), 'capabilities.yml')))

# Convert top-level string keys to symbols to satisfy appium_lib deprecation
caps = {}
raw_caps.each do |k, v|
	caps[k.to_sym] = v
end

# Also convert nested caps keys to symbols (Appium expects symbol keys)
if caps[:caps].is_a?(Hash)
	caps[:caps] = caps[:caps].transform_keys { |k| k.to_sym }
end

# Resolve `app` to an absolute path only when it's a relative path.
# If the `app` is already an absolute Windows path (e.g. C:/...) or an absolute
# Unix/WSL path (/mnt/...), leave it as-is because the Appium server must be
# able to access that exact path on the machine where it runs.
if caps[:caps] && caps[:caps][:app]
	app_path = caps[:caps][:app]
	is_windows_abs = app_path =~ /^[A-Za-z]:\\|\A[A-Za-z]:\//
	is_unix_abs = app_path.start_with?('/')
	unless is_windows_abs || is_unix_abs
		caps[:caps][:app] = File.expand_path(File.join(File.dirname(__FILE__), app_path))
	end
end

# Start driver and expose globally for hooks/steps
$driver = Appium::Driver.new(caps, true)
Appium.promote_appium_methods Object