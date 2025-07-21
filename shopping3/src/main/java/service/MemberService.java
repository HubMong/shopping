package service;

import model.Member;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.MemberMapper;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    public Member login(String id, String password) {
        Member m = memberMapper.selectById(id);
        if (m != null && m.getPassword().equals(password)) {
            return m;
        }
        return null;
    }

    public Member selectById(String id) {
        return memberMapper.selectById(id);
    }
    
    public Member selectByEmail(String email) {
        return memberMapper.selectByEmail(email);
    }

    public Member selectByHp(String hp) {
        return memberMapper.selectByHp(hp);
    }

    public List<Member> getAllMembers() {
        return memberMapper.selectAll();
    }

    public boolean join(Member m) {
        return memberMapper.insert(m) > 0;
    }

    public boolean modify(Member m) {
        return memberMapper.update(m) > 0;
    }

    public boolean remove(String id) {
        return memberMapper.delete(id) > 0;
    }

    public Member getMemberById(String id) {
        return memberMapper.selectById(id);
    }
}
