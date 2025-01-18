*** Settings ***
Library    SeleniumLibrary

Test Setup    เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
Test Teardown   Close Browser

*** Variables ***
${URL}    https://www.google.com
${BROWSER}    headlesschrome

*** Test Cases ***
ทดสอบใส่คำค้น "PIM" และควรเจอ "สถาบันการจัดการปัญญาภิวัฒน์"
    ค้นหาและตรวจสอบ    PIM    สถาบันการจัดการปัญญาภิวัฒน์

ทดสอบใส่คำค้น "Rick Roll" และควรเจอ "Rick Astley"
    ค้นหาและตรวจสอบ    Rick Roll    Rick Astley

ทดสอบใส่คำค้น "nothing phone" และควรเจอ "Nothing Thailand"
    ค้นหาและตรวจสอบ    nothing phone    Nothing Thailand

*** Keywords ***
เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
    Open Browser    url=${URL}    browser=${BROWSER}

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