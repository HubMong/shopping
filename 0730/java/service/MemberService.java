package service;

import model.Member;
import java.util.List;

public interface MemberService {
    Member login(String userId, String password);
    Member loginById(int id, String password);

    Member selectByUserId(String userId);
    Member selectById(int id);
    Member selectByPhone(String phone);

    List<Member> getAllMembers();

    boolean join(Member m);

    boolean modify(Member m);
    boolean modifyById(Member m);

    boolean remove(String userId);
    boolean removeById(int id);
}
