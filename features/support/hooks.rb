require 'fileutils'

Before do
  begin
    $driver.start_driver
  rescue StandardError => e
    puts "Falha ao iniciar driver: #{e.message}"
    raise e
  end
end

After do |scenario|
  if scenario.failed?
    begin
      if $driver && $driver.driver
        FileUtils.mkdir_p("screenshots")
        name = scenario.name.gsub(/[^0-9A-Za-z_]/, '_')
        time = Time.now.strftime("%Y-%m-%d_%H.%M.%S")
        path = "screenshots/FAILED_#{name}_#{time}.png"
        $driver.screenshot(path)
        puts "Screenshot salva em: #{path}"
      end
    rescue StandardError => e
      puts "Erro ao capturar screenshot: #{e.message}"
    end
  end

  begin
    $driver.driver_quit
  rescue
    $driver = nil
  end
end