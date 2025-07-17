package mapper;

import java.util.List;
import model.Member;

public interface MemberMapper {
    
    // 회원 가입
    int insert(Member member);

    // 아이디로 회원 조회
    Member selectById(String id);

    // 이메일로 회원 조회
    Member selectByEmail(String email);

    // 전화번호로 회원 조회
    Member selectByHp(String hp);

    // 전체 회원 조회
    List<Member> selectAll();

    // 회원 정보 수정
    int update(Member member);

    // 회원 삭제
    int delete(String id);
}
