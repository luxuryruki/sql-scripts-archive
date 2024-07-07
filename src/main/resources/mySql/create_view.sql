
-- 산재되어있는 데이터를 가져오기 위한 뷰 생성
CREATE VIEW v_orderSheetDetail AS
SELECT
    os.orderDate as orderDate,
    os.id as orderSheet,
    os.orderSheetType,
    pi.id as priceInfo,
    pi.totalOrderPrice,
    pi.totalOrderSupplyPrice,
    COALESCE(SUM(cu.amount), 0) as totalUsedChargeAmount,
    (pi.totalOrderPrice - pi.totalOrderSupplyPrice) as vat,
    u.id as user,
    u.isRepresentative,
    u.userId,
    u.name as userName,
    ug.id as userGroup,
    ug.groupCompanyType,
    ug.name as groupName,
    ug.groupType,
    payment_data.payMethod,
    payment_data.paymentDate,
    payment_data.totalPaidAmount,
    payment_data.paymentStatus
FROM orderSheet os -- 주문원장
LEFT JOIN priceInfo pi ON os.priceInfo = pi.id -- 가격정보
LEFT JOIN user u ON os.user = u.id -- 사용자
LEFT JOIN userGroup ug ON os.userGroup = ug.id -- 사용자 그룹
LEFT JOIN creditUsage cu ON cu.orderSheet = os.id -- 크래딧 사용정보
LEFT JOIN (
    SELECT
        p.orderSheet,
        CASE
            WHEN COUNT(DISTINCT p.payMethod)=1 THEN MAX(p.payMethod)
            ELSE 'mixed'
        END as payMethod, -- 결제 방법이 하나만 존재하면 해당 방법을 사용하고, 그렇지 않으면 'mixed'로 설정
        CASE
            WHEN COUNT(DISTINCT p.paymentStatus)=1 THEN MAX(p.paymentStatus)
            ELSE 'unkonwn'
        END as paymentStatus, -- 결제 상태가 하나만 존재하면 해당 상태를 사용하고, 그렇지 않으면 'unknown'으로 설정
        CASE
            WHEN COUNT(DISTINCT p.paymentDate)=1 THEN MAX(p.paymentDate)
            ELSE 'unkonwn'
        END as paymentDate, --  결제 날짜가 하나만 존재하면 해당 날짜를 사용하고, 그렇지 않으면 'unknown'으로 설정
        SUM(CASE
                WHEN (p.payMethod NOT IN ('credit') AND p.paymentStatus = 'paymentCompleted')
                THEN p.paymentPrice
                ELSE 0
            END) as totalPaidAmount, -- 결제가 완료되었으며 충전금 결제가 아닌 결제금액의 합
        GROUP_CONCAT(p.id ORDER BY p.id) as payments
    FROM payment p
    GROUP BY p.orderSheet
) as payment_data ON os.id = payment_data.orderSheet
GROUP BY
    os.id,
    os.orderDate,
    os.orderSheetType,
    pi.id,
    pi.totalOrderPrice,
    pi.totalOrderSupplyPrice,
    u.id,
    u.isRepresentative,
    u.userId,
    u.name,
    ug.id,
    ug.groupCompanyType,
    ug.name,
    ug.groupType,
    payment_data.payMethod,
    payment_data.paymentDate,
    payment_data.totalPaidAmount,
    payment_data.paymentStatus;