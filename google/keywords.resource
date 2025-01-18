*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.google.com
${BROWSER}    headlesschrome

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