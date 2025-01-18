*** Settings ***
Library    SeleniumLibrary

Test Setup    เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ไฟน์ไลน์

*** Variables ***
${URL}    https://www.allonline.7eleven.co.th/
${BROWSER}    edge

*** Test Cases ***
ทดสอบค้นหาสินค้า "ไฟน์ไลน์" แล้วพบข้อมูล "ผลการค้นหาสำหรับ »ไฟน์ไลน์« (88 สินค้า)"
    ใส่ชื่อสินค้า    ไฟน์ไลน์
    กดปุ่ม Enter
    ตรวจสอบผลลัพธ์    ผลการค้นหาสำหรับ »ไฟน์ไลน์« (88 สินค้า)

*** Keywords ***
เปิดเว็บเบราว์เซอร์และเข้าสู่เว็บไซต์ไฟน์ไลน์
    Open Browser    url=${URL}    browser=${BROWSER}
    Maximize Browser Window

ใส่ชื่อสินค้า
    [Arguments]    ${search_key}
    Input Text    name=q    ${search_key}

กดปุ่ม Enter
    Press Keys    None    ENTER

ตรวจสอบผลลัพธ์
    [Arguments]    ${Product_name}
    Wait Until Page Contains    ${Product_name}





