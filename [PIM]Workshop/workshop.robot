*** Settings ***
Suite Setup   Open Web Browser
Test Setup    Go to Webpage And Accept cookies
Suite Teardown   Close Browser

Test Template    Execute Purchase Process

Resource    keywords.resource

*** Test Cases ***                                                      email                   password            product_name                    expect_result                    product_price  allmember_point_earned  name    last_name   tel    house_no moo  province     district  sub_district  postal_code card_name   card_num          card_exp card_cvv  order_no
Successful Purchase Process with Address Confirmation and Payment    pahnkcnforyt@gmail.com    Pim123456!    ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม    ผลการค้นหาสำหรับ »ยำยำช้างน้อย รสบาร์บีคิว 120 กรัม«    ฿ 38    คุณจะได้รับ 9 คะแนน    พันกร    ชมจันทร์    0619917765    45/9    7    สมุทรปราการ    บางพลี    บางปลา    10540    พันกร ชมจันทร์    46246977491778712    0129    476    A437089605