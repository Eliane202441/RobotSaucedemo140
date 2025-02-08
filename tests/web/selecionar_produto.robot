*** Settings ***
Library    SeleniumLibrary            # biblioteca aonde fica a inicialização e finalização
Library    ../../.venv/Lib/site-packages/robot/libraries/XML.py

Test Teardown     Close Browser       # função para encerrar " no final fecha o navegador "

*** Variables ***

${url}    https://www.saucedemo.com/
${browser}    Chrome

*** Test Cases ***  # ordena em que ordem as coisas deve acontecer nas keywords

selecionar Sauce Labs Backpack
    Dado que acesso o site SauceDemo  
    Quando preecho o campo usuario    standard_user
    E preecho o campo senha    secret_sauce
    E clico no botao Login
    Entao sou direcionado para a pagina de produtos 
    Quando clico no produto    Sauce Labs Backpack    $29.99
    Entao sou direcionado para a pagina do produto
    Quando clico em adicionar no carrinho
    Entao visualizo o numero de itens no carrinho    1
    Quando clico no icone do carrinho 
    Entao sou direcionado para a pagina do carrinho

selecionar Sauce Labs Backpack login com Enter
    Dado que acesso o site SauceDemo  
    Quando preecho o campo usuario    standard_user
    E preecho o campo senha    laranja 
    E pressiono a tecla Enter 

*** Keywords ***

Dado que acesso o site Saucedemo 
    Open Browser    url={url}    browser={browser}
    Maximize Browser Window
    Set Browser Implicit Wait    10000ms
    Wait Until Element Is Visible    css=.login_logo    5000ms

Quando preecho o campo usuario
    [Arguments]    ${username}
    Input Text     css=[data-test="username"]    ${username}

E preecho o campo senha
    [Arguments]    ${password}
    Input Password   css=[data-text="password"]    ${password}

E clico no botao Login
    Click Button    id=login-button  

E pressiono a tecla Enter 
    Press Key    css=[data-text="password"]     Enter

 Entao sou direcionado para a pagina de produtos 
     Element Text Should Be    css=[data-text="title"]    products


Quando clico no produto 
    [Arguments]    ${products_name}    ${products_price}
    Set Test Variable    ${test_products_name}    ${products_name}
    Set Test Variable    ${test_products_price}    ${products_price}
    Click Element    css=img[alt="${test_products_name}"]

Entao sou direcionado para a pagina do produto
    Element Text Should Be    name=back-to-products    Back to products
    Element Text Should Be    css=div.inventory_details_name.large_size    ${test_products_name}
    Element Text Should Be    css=div.inventory_details_price    ${test_products_price}

Quando clico em adicionar no carrinho
    Click Element    css=button.btn btn_primary.btn_small.btn_inventory

Entao visualizo o numero de itens no carrinho
    [Arguments]    ${cart_items}
    Set Test Variable    ${test_cart_items}    ${cart_items}
    Element Text Should Be    css=span.shopping_cart_badge    ${test_cart_items}

Quando clico no icone do carrinho 
    Click Link    ${test_cart_items}

Entao sou direcionado para a pagina do carrinho
    Wait Until Element Contains    css.title    Your Cart
    Element Text Should Be    css=div.inventory_item_name     ${test_products_name}
    Element Text Should Be    css=div.inventory_item_price    ${test_products_price}
    Element Text Should Be    css=div.cart_quantity           ${test_cart_items}
    