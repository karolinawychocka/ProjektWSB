*** Settings ***
Documentation    Log in https://www.saucedemo.com/. Add 3 product to shopping cart. Delete 1 product from shopping cart. Go to checkout. Buy items. Close browser.
Library          SeleniumLibrary

*** Variables ***
${BROWSER}              chrome
${URL}                  https://www.saucedemo.com/

*** Test Cases ***
Log In Bad Path
    Open Shop Website
    Log In (bad path)
Log In Happy Path
    Log In (happy path)
Adding product to shopping cart
    Sort by price low to high
    Add Products To Shopping Cart
Check Cart
    Check Shopping Cart
    Delete Product From Shopping Cart
    Checkout
Back to home page
    Back to home page
    Close browser


*** Keywords ***
Open Shop Website
    Set Selenium Speed          0.2
    Open Browser                ${URL}      ${BROWSER}
    Maximize Browser Window
Log In (bad path)
    Input Text                  //input[@id='user-name']        user
    Input Text                  //input[@id='password']         pass
    Click element               //input[@id='login-button']
    Element Should Contain      //body/div[@id='root']/div[1]/div[2]/div[1]/div[1]/div[1]/form[1]/div[3]/h3[1]      Epic sadface: Username and password do not match any user in this service
Log In (happy path)
    Input Text                  //input[@id='user-name']        standard_user
    Input Text                  //input[@id='password']         secret_sauce
    Click element               //input[@id='login-button']
Sort by price low to high
    Click element               //body/div[@id='root']/div[@id='page_wrapper']/div[@id='contents_wrapper']/div[@id='header_container']/div[2]/div[2]/span[1]/select[1]
    Select From List By Label   //body/div[@id='root']/div[@id='page_wrapper']/div[@id='contents_wrapper']/div[@id='header_container']/div[2]/div[2]/span[1]/select[1]      Price (low to high)
Add Products To Shopping Cart
    Click element               //*[contains(text(),'Bolt T-Shirt')]
    Wait Until Page Contains    Add to cart
    Click Button                //button[@id='add-to-cart-sauce-labs-bolt-t-shirt']
    Click Button                //button[@id='back-to-products']
    Click element               //*[contains(text(),'Backpack')]
    Click Button                //button[@id='add-to-cart-sauce-labs-backpack']
    Click Button                //button[@id='back-to-products']
    Click element               //*[contains(text(),'Fleece Jacket')]
    Click Button                //button[@id='add-to-cart-sauce-labs-fleece-jacket']
Check Shopping Cart
    Click element               //body/div[@id='root']/div[@id='page_wrapper']/div[@id='contents_wrapper']/div[@id='header_container']/div[1]/div[3]/a[1]
Delete Product From Shopping Cart
    Wait Until Page Contains    Sauce Labs Fleece Jacket
    Click Button                //button[@id='remove-sauce-labs-fleece-jacket']
Checkout
    Click Element               //button[@id='checkout']
    Input text                  //input[@id='first-name']       Anna
    Input text                  //input[@id='last-name']        Kowalska
    Input text                  //input[@id='postal-code']      10-100
    Click Element               //input[@id='continue']
    Wait Until Page Contains Element    //button[@id='finish']
    Click Button                //button[@id='finish']
Back to home page
    Wait Until Page Contains Element    //button[@id='back-to-products']
    Click Button                 //button[@id='back-to-products']
    Close browser
