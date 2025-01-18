*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.google.com
${BROWSER}    headlesschrome

*** Test Cases ***
ทดสอบใส่คำค้น "PIM" และควรเจอ "สถาบันการจัดการปัญญาภิวัฒน์"
    เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
    ใส่คำค้นหา    PIM
    กดปุ่ม Enter
    ตรวจสอบผลการค้นหา    สถาบันการจัดการปัญญาภิวัฒน์

ทดสอบใส่คำค้น "Rick Roll" และควรเจอ "Rick Astley"
    เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
    ใส่คำค้นหา    Rick Roll
    กดปุ่ม Enter
    ตรวจสอบผลการค้นหา    Rick Astley

ทดสอบใส่คำค้น "nothing phone" และควรเจอ "Nothing Thailand"
    เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
    ใส่คำค้นหา    nothing phone
    กดปุ่ม Enter
    ตรวจสอบผลการค้นหา    Nothing Thailand

*** Keywords ***
เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
    Open Browser    url=${URL}    browser=${BROWSER}
ใส่คำค้นหา
    [Arguments]    ${search_term}
    Input Text    name=q    ${search_term}

กดปุ่ม Enter
    Press Keys    None    RETURN
ตรวจสอบผลการค้นหา
    [Arguments]    ${result_term}
    Wait Until Page Contains    ${result_term}