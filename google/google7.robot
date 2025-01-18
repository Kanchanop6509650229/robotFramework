*** Settings ***
Library    SeleniumLibrary

Suite Setup    เปิดเว็บเบราว์เซอร์
Test Setup    เข้าสู่เว็บไซต์ Google
# Test Teardown   Close Browser
Suite Teardown   Close Browser

Test Template    ค้นหาและตรวจสอบ

*** Variables ***
${URL}    https://www.google.com
${BROWSER}    headlesschrome

*** Test Cases ***                              search_term    result_term
ทดสอบใส่คำค้น "PIM" และควรเจอ "สถาบันการจัดการปัญญาภิวัฒน์"    PIM    สถาบันการจัดการปัญญาภิวัฒน์
ทดสอบใส่คำค้น "Rick Roll" และควรเจอ "Rick Astley"    Rick Roll    Rick Astley
ทดสอบใส่คำค้น "nothing phone" และควรเจอ "Nothing Thailand"    nothing phone    Nothing Thailand

*** Keywords ***
เปิดเว็บเบราว์เซอร์
    Open Browser    browser=${BROWSER}

เข้าสู่เว็บไซต์ Google
    Go To    ${URL}

ค้นหาและตรวจสอบ
    [Arguments]    ${search_term}    ${result_term}
    ใส่คำค้นหา    ${search_term}
    กดปุ่ม Enter
    ตรวจสอบผลการค้นหา    ${result_term}

ใส่คำค้นหา
    [Arguments]    ${search_term}
    Input Text    name=q    ${search_term}

กดปุ่ม Enter
    Press Keys    None    RETURN
    
ตรวจสอบผลการค้นหา
    [Arguments]    ${result_term}
    Wait Until Page Contains    ${result_term}