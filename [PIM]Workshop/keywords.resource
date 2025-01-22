*** Settings ***
Library    SeleniumLibrary
Library    String 

*** Variables ***
${DEV_URL}    https://www.allonline.7eleven.co.th/
${SIT_URL}    https://www.allonline.7eleven.co.th/
${UAT_URL}    https://www.allonline.7eleven.co.th/
${BROWSER}    firefox

*** Keywords ***
Open Web Browser
    Open Browser    browser=${BROWSER}

Go to Webpage And Accept cookies
    Go To    ${DEV_URL}
    Wait Until Element Is Visible 	 id=page 	 timeout=2s
    Wait Until Element Is Visible 	 id=btn-accept-gdpr 	 timeout=5s
    Click Button    id=btn-accept-gdpr
    
Execute Purchase Process
    [Arguments]    ${email}    ${password}    ${product_name}    ${expect_result}    ${product_price}    ${allmember_point_earned}    ${name}    ${last_name}    ${tel}    ${house_no}    ${moo}    ${province}    ${district}    ${sub_district}    ${postal_code}    ${card_name}    ${card_num}    ${card_exp}    ${card_cvv}    ${order_no}
    Logs In with Valid Credentials    ${email}    ${password}
    Search And Verify Product    ${product_name}    ${expect_result}
    Choose, Verify and Checkout Product From Results    ${product_name}    ${product_price}    ${allmember_point_earned}
    Select Shipping Method And Fill Shipping Details    ${name}    ${last_name}    ${tel}    ${house_no}    ${moo}    ${province}    ${district}    ${sub_district}    ${postal_code}
    Choose Payment Method And Fill Payment Details    ${card_name}    ${card_num}    ${card_exp}    ${card_cvv}
    Verify Purchase Success    ${order_no}

Logs In with Valid Credentials
    [Arguments]    ${email}    ${password}
    Click Element 	 Xpath=//*[@id="page"]/header/div[4]/div/div/div/ul/li[4]/a
    Wait Until Element Is Visible 	 name=email 	 timeout=3s
    Input text    name=email    ${email}
    Input text    name=password    ${password}
    Click Element    Xpath=/html/body/div[1]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]
    Wait Until Page Contains    ALL member    timeout=3s
    Click Button    Xpath=/html/body/div[1]/div/div/div[2]/div[2]/div/div/div[3]/div/button[2]

Search And Verify Product
    [Arguments]    ${product_name}    ${expect_result}
    Wait Until Element Is Visible    name=q    timeout=3s
    Input text    name=q    ${product_name}
    Click Button 	 Xpath=/html/body/div[13]/header/div[5]/div/div/div/div/ul/li[3]/div/div[1]/form/div/span/button
    ${search_result}    Get Text 	 class=header-category
    Should Contain    ${search_result}    ${expect_result}
    Wait Until Page Contains    ${product_name}

Choose, Verify and Checkout Product From Results
    [Arguments]    ${product_name}    ${product_price}    ${allmember_point_earned}
    ${dynamic_product_xpath}=    Set Variable    //div[contains(@class, 'product-item') and contains(., '${product_name}')]
    Wait Until Element Is Visible    xpath=${dynamic_product_xpath}    timeout=3s
    Scroll Element Into View    xpath=${dynamic_product_xpath}
    Click Element    xpath=${dynamic_product_xpath}
    Wait Until Element Is Visible    id=title-product    timeout=3s
    Element Should Contain 	 id=title-product 	 ${product_name}
    Element Should Contain 	 class=price 	 ${product_price}
    Element Should Contain    class=isEarned-Burn-allmember    ${allmember_point_earned}
    Wait Until Element Is Visible    class=buy-now    timeout=3s
    Click Button 	 class=buy-now

Select Shipping Method And Fill Shipping Details
    [Arguments]    ${name}    ${last_name}    ${tel}    ${house_no}    ${moo}    ${province}    ${district}    ${sub_district}    ${postal_code}
    Wait Until Element Is Visible    class=tab-address    timeout=3s
    Click Element    class=tab-address
    Wait Until Element Is Visible    class=new-address    timeout=3s
    Click Element    class=new-address
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
    Wait Until Element Is Enabled 	 id=selected-location 	 timeout=3s
    Sleep    2s
    Click Element    id=selected-location
    Wait Until Element Is Visible    id=conf-dif-addr    timeout=3s
    Click Element    id=conf-dif-addr
    Wait Until Element Is Visible    id=new-address-postal-code    timeout=3s
    ${get_postal_code}    Get Value    id=new-address-postal-code
    Should Be Equal    ${get_postal_code}    ${postal_code}
    Sleep    2s
    Wait Until Element Is Visible 	 id=continue-payment-btn 	 timeout=3s
    Click Button    id=continue-payment-btn

Choose Payment Method And Fill Payment Details
    [Arguments]    ${card_name}    ${card_num}    ${card_exp}    ${card_cvv}
    Wait Until Element Is Visible    id=payment-options    timeout=3s
    Click Button    Xpath=/html/body/div[3]/div/form/div[1]/div[1]/div[3]/div[1]/button
    Wait Until Element Is Enabled    class=continue-payment-btn    timeout=5s
    Sleep    2s
    Click Button    class=continue-payment-btn
    Wait Until Element Is Visible    id=contentCreditCard    timeout=10s
    Input text    id=cardName    ${card_name}
    Input text    id=cardNumber    ${card_num}
    Input text    id=expiryDate    ${card_exp}
    Input text    id=cvCode    ${card_cvv}
    Click Button    id=subFormPay

Verify Purchase Success
    [Arguments]    ${order_no}
    #ไม่แน่ใจว่าต้องเขียนยังไงครับ พอดีมันอยู่หลังหน้าจ่ายเงิน
    # Element Should Contain 	 id=order-number 	 ${order_no}