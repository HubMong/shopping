
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

    public Member login(String userId, String password) {
        Member m = memberMapper.selectByUserId(userId);
        if (m != null && m.getPassword().equals(password)) {
            return m;
        }
        return null;
    }

    public Member loginById(int id, String password) {
        Member m = memberMapper.selectById(id);
        if (m != null && m.getPassword().equals(password)) {
            return m;
        }
        return null;
    }

    public Member selectByUserId(String userId) {
        return memberMapper.selectByUserId(userId);
    }
    
    public Member selectById(int id) {
        return memberMapper.selectById(id);
    }

    public Member selectByPhone(String phone) {
        return memberMapper.selectByHp(phone);
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

    public boolean modifyById(Member m) {
        return memberMapper.updateById(m) > 0;
    }

    public boolean remove(String userId) {
        return memberMapper.delete(userId) > 0;
    }

    public boolean removeById(int id) {
        return memberMapper.deleteById(id) > 0;
    }
}
