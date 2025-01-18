*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${DEV_URL}    http://159.223.89.151/product/list
${SIT_URL}    http://165.22.255.65/product/list
${UAT_URL}    http://159.223.71.75/product/list
${BROWSER}    chrome

*** Test Cases ***
ทดสอบซื้อสินค้าหลังจากนั้นชำระเงินด้วย Credit card ของ visa และชำระเงินสำเร็จ
    ค้นหาสินค้าด้วยคำค้นหา    Bicycle
    ตรวจสอบผลลัพธ์การค้นหา    Balance Training Bicycle    ฿4,314.60    product-card-name-1    product-card-price-1 
    เลือกดูสินค้า    product-card-name-1
    ตรวจสอบรายละเอียดสินค้า    Balance Training Bicycle    ฿4,314.60    43 Points    product-detail-product-name    product-detail-price-thb    product-detail-point
    # เพิ่มสินค้าลงในตะกร้า
    เพิ่มจำนวนสินค้าที่ต้องการซื้อ
    ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของสินค้าในตะกร้า    388
    กดปุ่ม Checkout
    ใส่ที่อยู่จัดส่งสินค้า    abc    defg    บ้านพ่อมึง    ปทุมธานี     คลองหลวง    คลองหนึ่ง    12120    1234567890 
    เลือกวิธีในการจัดส่งเป็น Thai post
    ตรวจสอบค่าจัดส่งสินค้าของ Thai post เท่ากันกัน 50.00 บาท
    เลือกช่องทางชำระเงิน Visa mastercard    John Cena    000000000000000021    111112    2224
    ยืนยันการชำระเงิน
    # ยืนยัน OTP
    # ตรวจสอบหมายเลขพัสดุ
    # ยืนยันการส่งการแจ้งเตือนด้วย email และเบอร์โทรศัพท์
    

*** Keywords ***
ค้นหาสินค้าด้วยคำค้นหา
    [Arguments]    ${SEARCH_KEY}
    Open Browser    ${DEV_URL}    ${BROWSER}
    Input Text    id=search-product-input    ${SEARCH_KEY}
    Click Button    id=search-product-btn

ตรวจสอบผลลัพธ์การค้นหา
    [Arguments]    ${name}     ${price}     ${name_id}    ${price_id}
    Wait Until Page Contains    ${name}    timeout=10s
    Element Text Should Be    id=${name_id}    ${name}
    Element Text Should Be    id=${price_id}    ${price}

เลือกดูสินค้า
    [Arguments]    ${name_id}
    Click Element    id=${name_id}

ตรวจสอบรายละเอียดสินค้า
    [Arguments]    ${name}     ${price}    ${point}     ${name_id}    ${price_id}    ${point_id}
    Wait Until Page Contains    ${name}    timeout=10s
    Element Text Should Be    id=${name_id}    ${name}
    Element Text Should Be    id=${price_id}    ${price}
    Element Text Should Be    id=${point_id}    ${point}
    
# เพิ่มสินค้าลงในตะกร้า
#     Wait Until Element Is Visible    id=product-detail-add-to-cart-btn    timeout=10s
#     Click Button    id=product-detail-add-to-cart-btn
#     Element Text Should be    id=header-menu-cart-badge    1

เพิ่มจำนวนสินค้าที่ต้องการซื้อ
    Click Button    id=product-detail-quantity-increment-btn
    ${quantity}    Get Value    id=product-detail-quantity-input
    Should Be Equal    ${quantity}    2

ตรวจสอบจำนวนแต้มต่อชิ้นที่จะได้รับของสินค้าในตะกร้า
    [Arguments]    ${point}
    Click Button    id=header-menu-cart-btn
    Wait Until Element Is Visible    id=product-1-point    timeout=10s
    # Element Text Should be    id=product-1-point   ${point}

กดปุ่ม Checkout
    Wait Until Element Is Visible    id=shopping-cart-checkout-btn    timeout=10s
    Click Element    id=shopping-cart-checkout-btn
    Title Should Be    Checkout

ใส่ที่อยู่จัดส่งสินค้า
    [Arguments]    ${firstname}    ${lastname}    ${address}    ${province}    ${district}    ${subdistrict}    ${postcode}    ${phone}
    Wait Until Element Is Visible    id=shipping-form-first-name-input    timeout=10s
    Input Text    id=shipping-form-first-name-input    ${firstname}
    Input Text    id=shipping-form-last-name-input    ${lastname}
    Input Text    id=shipping-form-address-input    ${address}
    Select From List By Label    id=shipping-form-province-select    ${province}
    Select From List By Label    id=shipping-form-district-select    ${district}
    Select From List By Label    id=shipping-form-sub-district-select    ${subdistrict}
    ${output_zip}    Get Value    id=shipping-form-zipcode-input
    Should Be Equal    ${output_zip}    ${postcode}
    Input Text    id=shipping-form-mobile-input    ${phone}

เลือกวิธีในการจัดส่งเป็น Thai post
    Click Element    id=shipping-method-2-card
    
ตรวจสอบค่าจัดส่งสินค้าของ Thai post เท่ากันกัน 50.00 บาท
    Wait Until Element Is Visible    id=order-summary-shipping-fee-price
    Element Text Should Be    id=order-summary-shipping-fee-price    ฿50.00

เลือกช่องทางชำระเงิน Visa mastercard
    [Arguments]    ${name}    ${cardnumber}    ${expire}    ${cvv}
    Click Element    id=payment-credit-input
    Input Text    id=payment-credit-form-fullname-input    ${name}
    Input Text    id=payment-credit-form-card-number-input    ${cardnumber}
    Input Text    id=payment-credit-form-expiry-input    ${expire}
    Input Text    id=payment-credit-form-cvv-input    ${cvv}

ยืนยันการชำระเงิน
    Wait Until Element Is Visible    id=payment-now-btn    timeout=10s
    Click Button    id=payment-now-btn
    Wait Until Page Contains    SCK Payment Gateway    timeout=10s
    Title Should Be    SCK Payment Gateway