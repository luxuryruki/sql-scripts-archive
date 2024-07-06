
-- 사용자 유형에 대한 정보와 개인정보 통합
CREATE VIEW VIEW_USER_DETAILS AS
SELECT
    UT.USER_TYPE_ID AS USER_ID,            -- 사용자 아이디
    UT.EMPLOYEE_NUMBER AS EMPLOYEE_ID,     -- 사용자 사번
    UT.USER_TYPE_CODE AS USER_TYPE,        -- 사용자 유형
    UT.PERSON_NAME AS NAME,                -- 이름
    UT.DEPARTMENT_CODE AS DEPT_CODE,       -- 부서코드
    UT.BUSINESS_NAME AS DEPT_NAME,         -- 부서명
    U.HOME_PHONE_NUMBER AS CONTACT,        -- 연락처
    U.OFFICE_PHONE_NUMBER AS WORK_CONTACT, -- 직장 연락처
    U.EMAIL_ADDRESS AS EMAIL               -- 이메일
FROM
    USER_TYPE UT                 -- 사용자 유형
LEFT JOIN
    USER U                       -- 사용자 디테일
ON
    U.INTEGRATION_NUMBER = UT.INTEGRATION_NUMBER; -- 사용자 통합코드