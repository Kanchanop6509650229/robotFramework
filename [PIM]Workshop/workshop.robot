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
    Verify Search Results    ผลการค้นหาสำหรับ »ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม« (9164 สินค้า)    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม
    Choose Product from Results    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม
    Verify Product Details    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม    ฿ 38
    Place Order
    Select Shipping Method
    Fill Shipping Details    พันกร    ชมจันทร์    061-991-7765    45/9    7    สมุทรปราการ    บางพลี    บางปลา    10540
    Proceed To Checkout

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

Place Order
    Wait Until Element Is Visible    class=buy-now    timeout=3s
    Click Button 	 class=buy-now

Select Shipping Method
    Wait Until Element Is Visible    class=tab-address    timeout=3s
    Click Element    class=tab-address

Fill Shipping Details
    [Arguments]    ${name}    ${last_name}    ${tel}    ${house_no}    ${moo}    ${province}    ${district}    ${sub_district}    ${postal_code}
    Wait Until Element Is Visible    id=address    timeout=3s
    Input text    id=new-address-name    ${name}
    Input text    id=new-address-lastname    ${last_name}
    Input text    id=new-address-mobile    ${tel}
    Input text    id=new-address-addrno    ${house_no}
    Input text    id=new-address-moo    ${moo}
    Click Element    id=select2-new-address-province-container
    Wait Until Element Is Visible    id=select2-new-address-province-results    timeout=3s
    Input text    class=select2-search__field    ${province}
    Press Keys    class=select2-search__field    RETURN
    Click Element    id=select2-new-address-district-container
    Wait Until Element Is Visible    id=select2-new-address-district-results    timeout=3s
    Input text    class=select2-search__field    ${district}
    Press Keys    class=select2-search__field    RETURN
    Click Element    id=select2-new-address-sub-district-container
    Wait Until Element Is Visible    id=select2-new-address-sub-district-results    timeout=3s
    Input text    class=select2-search__field    ${sub_district}
    Press Keys    class=select2-search__field    RETURN
    Wait Until Element Is Visible    id=selected-location    timeout=3s
    Click Element    id=selected-location
    Wait Until Element Is Visible    id=new-address-postal-code    timeout=3s
    ${get_postal_code}    Get Value    id=new-address-postal-code
    Should Be Equal    ${get_postal_code}    ${postal_code}
    Wait Until Element Is Visible    id=conf-dif-addr    timeout=3s
    Click Element    id=conf-dif-addr
    Sleep    3s

Proceed To Checkout