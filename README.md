**개발사항)도서쇼핑몰
참고사이트)알라딘, 교보문고등 판매사이트를 참고

1)git실습(조직처리하는 방법)
main branch를 이용하여 팀별 업로드를 실습 
각자 맡은 기능을 나누어 폴더명을 정해야 합니다.
main 브런치 하나에 각각 순서를 정해서 업로드 진행

2)팀별 공통기능을 만들어서 github에 업로드 실시

3)팀원들이 main 브런치로 프로젝트를 clone을 한 후 개발진행

4)먼저 개발된 순서대로 github 업로드

<프로젝트 순서>
1 GitHub Organization 생성 및 팀원 초대  
2 프로젝트 구조 설계 및 초기 commit (main)  
3 팀원들 clone 후 각자 브랜치 생성        
4 기능 개발 → 각자 브랜치에서 commit   
5 완료된 기능 순서대로 Pull Request → main 병합 
6 최종 배포 전 main 브랜치 기준 통합 테스트 

<화면 구현>
(사용자)
[메인 페이지] → [회원가입/로그인] → [도서 목록] → [상세보기] → [장바구니] → [구매]

(관리자)
[메인 페이지] → [관리자 로그인] → [도서 목록 관리] → [도서 등록/수정/삭제]

<폴더 구조>
src/main/java/
├── auth/         # 회원가입/로그인
├── booklist/     # 메인페이지 및 책 목록
├── admin/        # 관리자 서적 등록/수정/삭제
├── detail/       # 도서 상세보기
├── cart/         # 장바구니 및 구매

<개발 분담>
| 1  | 초기 환경 설정 (web.xml, Spring 설정) | 팀장                        |
| 2  | 로그인/회원가입 + 세션 처리              | A (`feature-auth`)        |
| 3  | 메인 페이지 + 서적 리스트 출력            | B (`feature-booklist`)    |
| 4  | 도서 상세보기                       | E (`feature-book-detail`) |
| 5  | 관리자 기능 (등록/수정/삭제)             | C (`feature-admin-book`)  |
| 6  | 장바구니/구매 기능                    | D (`feature-user-cart`)   |

<DB 테이블>
(회원 테이블)
| 컬럼명       | 타입           | 설명     |
| --------- | ------------ | ------ |
| seq       | number       | PK     |
| id        | varchar(100) | 아이디    |
| password  | varchar(100) | 비밀번호   |
| email     | varchar(100) | 이메일    |
| name      | varchar(10)  | 이름     |
| phone     | varchar(13)  | 전화번호   |
| address   | varchar(255) | 주소     |
| is\_admin | boolean      | 관리자 여부 |

(상품 테이블)
| 컬럼명          | 타입           | 설명      |
| ------------ | ------------ | ------- |
| seq          | number       | PK      |
| id           | varchar(100) | 상품 ID   |
| name         | varchar(100) | 상품명     |
| content      | clob         | 상세 설명   |
| image        | varchar(100) | 이미지 파일명 |
| quantity     | number       | 재고      |
| update\_date | date         | 재고 수정일자 |
| on\_sale     | boolean      | 판매 여부   |

(구매 테이블) 
| 컬럼명            | 타입           | 설명      |
| -------------- | ------------ | ------- |
| seq            | number       | PK      |
| member\_id     | number       | FK (회원) |
| product\_id    | varchar(100) | FK (상품) |
| purchase\_date | date         | 구매일자    |
| quantity       | number       | 구매 수량   |



