*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.google.com
${PIM}    สถาบันการจัดการ PIM ปัญญาภิวัฒน์
${BROWSER}    chrome

*** Test Cases ***
ทดสอบใส่คำค้น "PIM" และควรเจอ "สถาบันการจัดการปัญญาภิวัฒน์"
    เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
    ใส่คำค้นหา
    กดปุ่ม Enter
    ตรวจสอบผลการค้นหา

*** Keywords ***
เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ Google
    Open Browser    url=${URL}    browser=${BROWSER}
ใส่คำค้นหา
    Input Text    name=q    PIM
กดปุ่ม Enter
    Press Keys    None    RETURN
ตรวจสอบผลการค้นหา
    Wait Until Page Contains    ${PIM}