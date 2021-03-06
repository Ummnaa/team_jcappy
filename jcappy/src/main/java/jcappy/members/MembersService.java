package jcappy.members;

import javax.servlet.http.HttpSession;

public interface MembersService {

	MembersVo login(MembersVo vo);
	int insert(MembersVo vo);
	int isDuplicateEmail(String email);
	int isDuplicatePhone(String phone);
	MembersVo findEmail(MembersVo vo);
	MembersVo findPwd(MembersVo vo);
	int delete(MembersVo vo);
	int update(MembersVo vo, HttpSession sess);
	MembersVo detail(MembersVo vo);
	
}
