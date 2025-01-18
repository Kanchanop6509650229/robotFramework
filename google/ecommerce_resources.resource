*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.allonline.7eleven.co.th/
${BROWSER}    headlesschrome

*** Keywords ***
เปิดเว็บเบราว์เซอร์
    Open Browser    browser=${BROWSER}

เข้าสู่เว็บไซต์ All Online
    Go To    url=${URL}

ใส่คำค้นหาและตรวจสอบรายละเอียดสินค้า
    [Arguments]    ${search_key}    ${product_name}    ${product_code}
    ใส่คำค้นหา    ${search_key}
    กดปุ่ม Enter
    ตรวจสอบผลการค้นหา    ${product_name}
    กดดูรายละเอียดสินค้า    ${product_name}
    ตรวจสอบรายละเอียดสินค้า    ${product_code}

ใส่คำค้นหา
    [Arguments]    ${search_key}
    Input Text    name=q    ${search_key}

กดปุ่ม Enter
    Press Keys    None    RETURN

ตรวจสอบผลการค้นหา
    [Arguments]    ${product_name}
    Wait Until Page Contains    ${product_name}

กดดูรายละเอียดสินค้า
    [Arguments]    ${product_name}
    ${product_selector}=    Set Variable    css=a.productlink[title*="${product_name}"]
    Wait Until Element Is Visible    ${product_selector}
    Scroll Element Into View    ${product_selector}
    Click Element    ${product_selector}

ตรวจสอบรายละเอียดสินค้า
    [Arguments]    ${product_code}
    Wait Until Page Contains    ${product_code}

กดเพิ่มสินค้าในตะกร้า
    Wait Until Element Is Visible    class=btn-addtocart
    Scroll Element Into View    class=btn-addtocart
    Click Element    class=btn-addtocart