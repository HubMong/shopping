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

    public Member login(int id, String password) {
        Member m = memberMapper.selectById(id);
        if (m != null && m.getPassword().equals(password)) {
            return m;
        }
        return null;
    }

    public Member selectById(int id) {
        return memberMapper.selectById(id);
    }
    
    public Member selectByUserId(String userId) {
        return memberMapper.selectByUserId(userId);
    }
    
	/*
	 * public Member selectByEmail(String email) { return
	 * memberMapper.selectByEmail(email); }
	 */

    public Member selectByHp(String phone) {
        return memberMapper.selectByHp(phone);
    }
    
    public Member getMemberById(int id) {
        return memberMapper.selectById(id);
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

    public boolean remove(int id) {
        return memberMapper.delete(id) > 0;
    }

}
