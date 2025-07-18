package service;

import model.Member;
import java.util.List;

public interface MemberService {
    Member login(String id, String password);
    Member selectById(String id);
    Member selectByEmail(String email); // 추가
    Member selectByHp(String hp); // 추가
    List<Member> getAllMembers();
    boolean join(Member m);
    boolean modify(Member m);
    boolean remove(String id);
	Member getMemberById(String id);
}
