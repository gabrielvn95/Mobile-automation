def wait
  @wait ||= Selenium::WebDriver::Wait.new(timeout: 30)
end

Given('I am registering a product in inventory') do
  begin
    $driver.find_element(id: "android:id/button1").click
  rescue
  end
  
  begin
    wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/Button1") }.click
  rescue
    wait.until { $driver.find_element(xpath: "//*[@content-desc='Novo' or @text='Novo']") }.click
  end
end

When('I enter valid product informations') do
  @product_name = "Prod#{Time.now.to_i}"
  
  fields = [
    { id: "br.com.pztec.estoque:id/txt_codigo", val: "123" },
    { id: "br.com.pztec.estoque:id/txt_descricao", val: @product_name },
    { id: "br.com.pztec.estoque:id/txt_unidade", val: "1" },
    { id: "br.com.pztec.estoque:id/txt_quantidade", val: "10" },
    { id: "br.com.pztec.estoque:id/txt_valora", val: "5.50" },
    { id: "br.com.pztec.estoque:id/txt_lote", val: "L99" }
  ]

  fields.each do |field|
    el = wait.until { $driver.find_element(id: field[:id]) }
    el.send_keys(field[:val])
    $driver.hide_keyboard rescue nil
  end

  begin
    $driver.find_element(:uiautomator, 'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("SALVAR"))').click
  rescue
    $driver.find_element(id: "br.com.pztec.estoque:id/btn_gravar_estoque").click
  end
end

Then('product will be registred sucessefully') do
  wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/btn_pesquisar") }
  lista = $driver.find_elements(id: "br.com.pztec.estoque:id/txt_descricao")
  expect(lista.any? { |el| el.text == @product_name }).to be true
end

Given('I already registering a product') do
  step "I am registering a product in inventory"
  step "I enter valid product informations"
end

When('I edit this product informations') do
  wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/btn_editar") }.click
  field = wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/txt_descricao") }
  field.clear
  field.send_keys("Editado")
  $driver.hide_keyboard rescue nil
  $driver.find_element(id: "br.com.pztec.estoque:id/btn_gravar_estoque").click
end

Then('product will be edited sucessefully') do
  res = wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/txt_descricao") }
  expect(res.text).to eq("Editado")
end

Given('I have a product in inventory') do
  step "I already registering a product"
end

When('I delete this product') do
  wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/btn_excluir") }.click
  wait.until { $driver.find_element(id: "android:id/button1") }.click 
end

Then('product will be deleted successfully') do
  wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/btn_pesquisar") }
  produtos = $driver.find_elements(id: "br.com.pztec.estoque:id/txt_descricao")
  expect(produtos.select { |p| p.text == @product_name }).to be_empty
end

Given('I have a product amount {string}') do |amount|
  step "I am registering a product in inventory"
  @product_name = "Stock#{Time.now.to_i}"
  wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/txt_descricao") }.send_keys(@product_name)
  $driver.find_element(id: "br.com.pztec.estoque:id/txt_quantidade").send_keys(amount)
  $driver.hide_keyboard rescue nil
  $driver.find_element(id: "br.com.pztec.estoque:id/btn_gravar_estoque").click
end

When('I decrease this product amount') do
  wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/btn_menos") }.click
end

Then('product amount will be decreased to {string} successfully') do |newValue|
  res = wait.until { $driver.find_element(id: "br.com.pztec.estoque:id/txt_quantidade") }.text
  expect(res).to eq(newValue)
end