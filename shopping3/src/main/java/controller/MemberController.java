package controller;

import model.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import service.MemberService;
import service.OrderService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private OrderService orderService;

    @GetMapping("/loginform")
    public String loginForm() {
        return "user/login"; // /WEB-INF/views/user/login.jsp
    }
    
    @GetMapping("/login")
    public String loginPage() {
        return "user/login"; // /WEB-INF/views/user/login.jsp
    }
    
    @GetMapping("/registerform")
    public String registerForm() {
        return "user/register"; // /WEB-INF/views/user/register.jsp
    }
    
    @GetMapping("/info")
    public String memberInfo(HttpSession session, Model model) {
        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/member/loginform";
        }
        model.addAttribute("member", loginUser);
        model.addAttribute("orders", orderService.getOrdersByMemberId(loginUser.getId()));
        return "user/info"; // /WEB-INF/views/user/info.jsp
    }

    @PostMapping("/login")
    public String login(@RequestParam("id") String id, @RequestParam("password") String password, 
                        HttpSession session, RedirectAttributes redirectAttributes) {
        Member member = memberService.login(id, password);
        
        if (member != null) {
            session.setAttribute("loginUser", member);
            if ("admin".equals(member.getId())) {
                return "redirect:/admin/books";
            }
            return "redirect:/books";
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/member/loginform";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/books";
    }

    @GetMapping("/list")
    @ResponseBody
    public List<Member> list() {
        return memberService.getAllMembers();
    }

    @PostMapping("/join")
    public String join(@RequestParam("id") String id, @RequestParam("password") String password,
                       @RequestParam("name") String name, @RequestParam("email") String email,
                       @RequestParam("hp") String hp, @RequestParam("address") String address,
                       RedirectAttributes redirectAttributes) {
        // 아이디 중복 확인
        if (memberService.selectById(id) != null) {
            redirectAttributes.addFlashAttribute("idError", "이미 존재하는 아이디입니다.");
            return "redirect:/member/registerform";
        }

        // 이메일 중복 확인
        if (memberService.selectByEmail(email) != null) {
            redirectAttributes.addFlashAttribute("emailError", "이미 사용 중인 이메일입니다.");
            return "redirect:/member/registerform";
        }

        // 전화번호 중복 확인
        if (memberService.selectByHp(hp) != null) {
            redirectAttributes.addFlashAttribute("hpError", "이미 사용 중인 전화번호입니다.");
            return "redirect:/member/registerform";
        }

        Member member = new Member();
        member.setId(id);
        member.setPassword(password);
        member.setName(name);
        member.setEmail(email);
        member.setHp(hp);
        member.setAddress(address);
        
        boolean result = memberService.join(member);
        
        if (result) {
            return "redirect:/member/loginform";
        } else {
            redirectAttributes.addFlashAttribute("generalError", "회원가입에 실패했습니다. 다시 시도해주세요.");
            return "redirect:/member/registerform";
        }
    }

    @PostMapping("/update")
    @ResponseBody
    public boolean modify(@RequestBody Member m) {
        return memberService.modify(m);
    }

    @PostMapping("/delete")
    @ResponseBody
    public boolean remove(@RequestParam("id") String id) {
        return memberService.remove(id);
    }
}
