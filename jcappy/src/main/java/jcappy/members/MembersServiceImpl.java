package jcappy.members;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MembersServiceImpl implements MembersService {

	@Autowired
	MembersDao dao;

	@Override
	public MembersVo login(MembersVo vo) {
		return dao.login(vo);
	}

	@Override
	public int insert(MembersVo vo) {
		return dao.insert(vo);
	}

	@Override
	public int isDuplicateEmail(String email) {
		return dao.isDuplicateEmail(email);
	}

	@Override
	public int isDuplicatePhone(String phone) {
		return dao.isDuplicatePhone(phone);
	}

	@Override
	public MembersVo findEmail(MembersVo vo) {
		return dao.findEmail(vo);
	}

	@Override
	public MembersVo findPwd(MembersVo vo) {
		// 1. 아이디, 이메일로 조회
		MembersVo mv = dao.findPwd(vo);
		// 2. 조회결과가 있으면 임시비밀번호 생성 수정
		if (mv != null) {
			// 임시 비밀번호 생성
			String tempPwd = "";
			for (int i = 0; i < 3; i++) {
				tempPwd += (char) ((Math.random() * 26) + 65);
			}
			for (int i = 0; i < 3; i++) {
				tempPwd += (int) ((Math.random() * 9));
			}

			vo.setMpwd(tempPwd); // 임시 비밀번호를 vo에 저장
			dao.updateTempPwd(vo); // 임시 비밀번호를 db에 수정

			// 3. 이메일로 임시비밀번호 전송
			SendMail.sendMail("jcappy0322@gmail.com", mv.getMemail(), "JCAPPY - 임시 비밀번호입니다.", "임시비밀번호: " + tempPwd);
		}

		return mv;
	}

	@Override
	public int delete(MembersVo vo) {
		return dao.delete(vo);
	}

	@Override
	public int update(MembersVo vo, HttpSession sess) {

		MembersVo membersInfo = (MembersVo) sess.getAttribute("membersInfo");
		int result = 0;

		if (membersInfo != null) {
			membersInfo.setMno(vo.getMno());
			result = dao.update(vo);
			sess.setAttribute("membersInfo", dao.detail(membersInfo));
			return result;
		}
		return dao.update(vo);
	}

	@Override
	public MembersVo detail(MembersVo vo) {
		return dao.detail(vo);
	}

}
