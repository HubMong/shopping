package service;

import model.Member;
import java.util.List;

public interface MemberService {
    Member login(String id, String password);
    List<Member> getAllMembers();
    boolean join(Member m);
    boolean modify(Member m);
    boolean remove(String id);
}
