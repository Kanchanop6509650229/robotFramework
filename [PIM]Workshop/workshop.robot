*** Settings ***
Library    SeleniumLibrary
Library    String 

*** Variables ***
${DEV_URL}    https://www.allonline.7eleven.co.th/
${SIT_URL}    https://www.allonline.7eleven.co.th/
${UAT_URL}    https://www.allonline.7eleven.co.th/
${BROWSER}    firefox

*** Test Cases ***
Successful Purchase Process with Address Confirmation and Payment
    Open Browser to Webpage
    Accept website cookies
    Logs In with Valid Credentials    pahnkcnforyt@gmail.com    Pim123456!
    Search Product by Name    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม
    Verify Search Results    ผลการค้นหาสำหรับ »ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม« (9155 สินค้า)    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม
    Choose Product from Results    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม
    Verify Product Details    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม    ฿ 38

*** Keywords ***
Open Browser to Webpage
    Open Browser    ${DEV_URL}    ${BROWSER}
    Wait Until Element Is Visible 	 id=page 	 timeout=2s

Accept website cookies
    Wait Until Element Is Visible 	 id=btn-accept-gdpr 	 timeout=5s
    Click Button    id=btn-accept-gdpr
    
Logs In with Valid Credentials
    [Arguments]    ${email}    ${password}
    Click Element 	 Xpath=//*[@id="page"]/header/div[4]/div/div/div/ul/li[4]/a
    Wait Until Element Is Visible 	 name=email 	 timeout=3s
    Input text    name=email    ${email}
    Input text    name=password    ${password}
    Click Element    Xpath=/html/body/div[1]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]
    Wait Until Page Contains    ALL member    timeout=3s
    Click Button    Xpath=/html/body/div[1]/div/div/div[2]/div[2]/div/div/div[3]/div/button[2]

Search Product by Name
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    name=q    timeout=3s
    Input text    name=q    ${product_name}
    Click Button 	 Xpath=/html/body/div[13]/header/div[5]/div/div/div/div/ul/li[3]/div/div[1]/form/div/span/button

Verify Search Results
    [Arguments]    ${expect_result}    ${product_name}
    ${search_result}    Get Text 	 class=header-category
    Should Be Equal    ${search_result}    ${expect_result}
    Wait Until Page Contains    ${product_name}

Choose Product From Results
    [Arguments]    ${product_name}
    ${dynamic_product_xpath}=    Set Variable    //div[contains(@class, 'product-item') and contains(., '${product_name}')]
    Wait Until Element Is Visible    xpath=${dynamic_product_xpath}    timeout=3s
    Scroll Element Into View    xpath=${dynamic_product_xpath}
    Click Element    xpath=${dynamic_product_xpath}

Verify Product Details
    [Arguments]    ${product_name}    ${product_price}
    Wait Until Element Is Visible    id=title-product    timeout=3s
    Element Should Contain 	 id=title-product 	 ${product_name}
    Element Should Contain 	 class=price 	 ${product_price}