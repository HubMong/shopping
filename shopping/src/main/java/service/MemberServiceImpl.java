package service;

import mapper.MemberMapper;
import model.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public Member login(String id, String password) {
        Member m = memberMapper.selectById(id);
        if (m != null && m.getPassword().equals(password)) {
            return m;
        }
        return null;
    }

    @Override
    public Member selectById(String id) {
        return memberMapper.selectById(id);
    }

    @Override
    public Member selectByEmail(String email) {
        return memberMapper.selectByEmail(email);
    }

    @Override
    public Member selectByHp(String hp) {
        return memberMapper.selectByHp(hp);
    }

    @Override
    public List<Member> getAllMembers() {
        return memberMapper.selectAll();
    }

    @Override
    public boolean join(Member m) {
        return memberMapper.insert(m) > 0;
    }

    @Override
    public boolean modify(Member m) {
        return memberMapper.update(m) > 0;
    }

    @Override
    public boolean remove(String id) {
        return memberMapper.delete(id) > 0;
    }

    @Override
    public Member getMemberById(String id) {
        return memberMapper.selectById(id);
    }
}