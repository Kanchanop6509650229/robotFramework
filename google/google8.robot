*** Settings ***
Suite Setup    เปิดเว็บเบราว์เซอร์
Test Setup    เข้าสู่เว็บไซต์ Google
# Test Teardown   Close Browser
Suite Teardown   Close Browser

Test Template    ค้นหาและตรวจสอบ

Resource    keywords.resource

*** Test Cases ***                              search_term    result_term
ทดสอบใส่คำค้น "PIM" และควรเจอ "สถาบันการจัดการปัญญาภิวัฒน์"    PIM    สถาบันการจัดการปัญญาภิวัฒน์
ทดสอบใส่คำค้น "Rick Roll" และควรเจอ "Rick Astley"    Rick Roll    Rick Astley
ทดสอบใส่คำค้น "nothing phone" และควรเจอ "Nothing Thailand"    nothing phone    Nothing Thailand