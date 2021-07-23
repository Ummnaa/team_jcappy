package jcappy.product;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class AdminProductController {

	@Autowired
	AdminProductService service;

	@RequestMapping("/admin/product/list")
	public String list(Model model, ProductVo vo) {
		model.addAttribute("list", service.selectAll(vo));
		return "admin/product/list";
	}

	@RequestMapping("/admin/product/detail")
	public String detail(Model model, ProductVo vo) {
		model.addAttribute("vo", service.detail(vo));
		return "admin/product/detail";
	}

	@RequestMapping("/admin/product/write")
	public String write(Model model, ProductVo vo) {
		return "admin/product/write";
	}

	@RequestMapping("/admin/product/insert")
	public String insert(Model model, ProductVo vo, @RequestParam MultipartFile file, HttpServletRequest req) {
		if (!file.isEmpty()) {
			try {
				String org = file.getOriginalFilename();
				String ext = "";

				ext = org.substring(org.lastIndexOf("."));
				String real = new Date().getTime() + ext;

				String path = req.getRealPath("/upload/");
				file.transferTo(new File(path + real));

				vo.setPimg1_org(org);
				vo.setPimg1_real(real);
				vo.setPimg2_org(org);
				vo.setPimg2_real(real);
				vo.setPimg3_org(org);
				vo.setPimg3_real(real);
			} catch (Exception e) {

			}
		}
		int r = service.insert(vo);

		if (r > 0) {
			model.addAttribute("msg", "정상적으로 등록되었습니다.");
			model.addAttribute("url", "list");
		} else {
			model.addAttribute("msg", "등록실패");
			model.addAttribute("url", "write");
		}
		return "include/alert";
	}

	@RequestMapping("/admin/product/update")
	public String update(Model model, ProductVo vo, @RequestParam MultipartFile file, HttpServletRequest req) {

		if (!file.isEmpty()) {
			try {
				String org = file.getOriginalFilename();
				String ext = "";
				ext = org.substring(org.lastIndexOf("."));

				String real = new Date().getTime() + ext;
				String path = req.getRealPath("/upload/");

				file.transferTo(new File(path + real));
				vo.setPimg1_org(org);
				vo.setPimg1_real(real);
				vo.setPimg2_org(org);
				vo.setPimg2_real(real);
				vo.setPimg3_org(org);
				vo.setPimg3_real(real);
			} catch (Exception e) {
			}
		}
		int r = service.update(vo);

		if (r > 0) {
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "list");
		} else {
			model.addAttribute("msg", "수정실패");
			model.addAttribute("url", "detail?pno=" + vo.getPno());
		}
		return "include/alert";
	}

	@RequestMapping("/admin/product/delete")
	public String delete(Model model, ProductVo vo, HttpServletRequest req) {
		int r = service.delete(vo);
		if (r > 0) {
			model.addAttribute("result", "true");
		} else {
			model.addAttribute("result", "false");
		}
		return "include/result";
	}
}
