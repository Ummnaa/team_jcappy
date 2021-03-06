package jcappy.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminLoginController {

	@Autowired
	AdminService service;
	
	// 로그인 폼
	@GetMapping({"/admin/login", "/admin"})
	public String loginForm(Model model, AdminVo vo, HttpSession session) {
		if (session.getAttribute("adminInfo") != null) {
			return "redirect:/admin/main";
		} else {
			return "admin/index";
		}
	}

	// 로그인처리
	@PostMapping("/admin/login")
	public String login(Model model, AdminVo vo, HttpSession session) {
		
		AdminVo adminInfo = service.login(vo);
		
		if (adminInfo != null) {
			adminInfo.setAuthList(adminInfo.getAuth().split(":"));
			session.setAttribute("adminInfo", adminInfo);
			return "redirect:/admin/main";
		} else {
			model.addAttribute("msg", "아이디와 비밀번호를 확인해주세요.");
			model.addAttribute("url", "login");
			return "include/alert";
		}
	}
	
	@RequestMapping("/admin/logout")
	public String logout(Model model, AdminVo vo, HttpSession session) {
		
		session.invalidate();
		
		model.addAttribute("msg", "로그아웃 되었습니다.");
		model.addAttribute("url", "login");
		
		return "include/alert";
	}

	/*============================
	 관리자 로그인 시, 메인페이지
	 ===========================*/
	
	// 메인페이지
	@RequestMapping("/admin/main")
	public String main(Model model) {
		model.addAttribute("boardList", service.boardList());
		model.addAttribute("productList", service.productList());
		model.addAttribute("orderList", service.orderList());
		model.addAttribute("salesList", service.salesList());
		return "admin/main";
	}
}
