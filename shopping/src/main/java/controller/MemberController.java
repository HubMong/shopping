package controller;

import model.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import service.MemberService;

import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/loginform")
    public String loginForm() {
        return "login"; // /WEB-INF/views/login.jsp
    }

    @PostMapping("/login")
    @ResponseBody
    public Member login(@RequestParam String id, @RequestParam String password) {
        return memberService.login(id, password);
    }

    @GetMapping("/list")
    @ResponseBody
    public List<Member> list() {
        return memberService.getAllMembers();
    }

    @PostMapping("/join")
    @ResponseBody
    public boolean join(@RequestBody Member m) {
        return memberService.join(m);
    }

    @PostMapping("/update")
    @ResponseBody
    public boolean modify(@RequestBody Member m) {
        return memberService.modify(m);
    }

    @PostMapping("/delete")
    @ResponseBody
    public boolean remove(@RequestParam String id) {
        return memberService.remove(id);
    }
}
