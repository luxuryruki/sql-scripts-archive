# SQL 스크립트 아카이브

이 리포지토리는 다양한 프로젝트에서 사용된 SQL 스크립트를 아카이빙하기 위한 것입니다.   
실제 프로젝트에 사용된 테이블명, 컬럼명과의 차이가 있으며 쿼리를 작성하면서 겪은 어려움과 문제를 해결에 대한 회고를 목적으로 생성하였습니다.   
아래 가이드라인은 SQL 스크립트 관리, 보안 대한 내용을 설명합니다.   

## 목차

1. [보안 지침](#보안-지침)

## 보안 지침
1. **개인정보나 민감한 정보를 스크립트에 포함시키지 않습니다.**
2. **SQL 인젝션을 방지하기 위해 매개변수화된 쿼리를 사용합니다.**
   - **JPA 예시**:
   ```java
      @Repository
      public class UserRepository {
      
          @PersistenceContext
          private EntityManager em;
      
          public User findUserById(Long id) {
              TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.id = :id", User.class);
              query.setParameter("id", id);
              return query.getSingleResult();
          }
      }
     }
   ```
   - **MyBatis 예시**:
   ```java
      @Mapper
      public interface UserMapper {
          
          @Select("SELECT * FROM users WHERE id = #{id}")
          User findUserById(@Param("id") Long id);
      }
   ```
   ```xml
     <mapper namespace="com.example.UserMapper">
        <select id="findUserById" resultType="User">
            SELECT * FROM users WHERE id = #{id}
        </select>
    </mapper>
   ```
4. **실제 프로젝트와 동일한 테이블명 및 컬럼명을 사용하지 않습니다.**
   - 보안을 강화하고 민감한 정보를 보호하기 위해 실제 프로젝트와는 다른 명칭을 사용합니다.

