package jcappy.qna;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jcappy.members.MembersVo;

@Service
public class AdminQnaServiceImpl implements AdminQnaService {

	@Autowired
	QnaDao dao;
	
	@Override
	public List<QnaVo> selectAll(QnaVo vo) {
		int totCount = dao.count(vo); // 총갯수
		// 총페이지수
		int totPage = totCount / vo.getPageRow();
		if (totCount % vo.getPageRow() > 0) totPage++;
		// 시작페이지
		int startPage = (vo.getReqPage()-1)/vo.getPageRange()
						*vo.getPageRange()+1;
		// 마지막페이지
		int endPage = startPage+vo.getPageRange()-1;
		if (endPage > totPage) endPage = totPage;
		
		//커맨드객체에 세팅
		vo.setStartPage(startPage);
		vo.setEndPage(endPage);
		vo.setTotCount(totCount);
		vo.setTotPage(totPage);
		return dao.selectAll(vo);
	}

	@Override
	public QnaVo detail(QnaVo vo) {
		return dao.detail(vo);
	}

	
	@Override
	public int update(QnaVo vo) {
		//isDel이 1값이면 파일이름 초기화
		if ("1".equals(vo.getIsDel())) {
			dao.delFilename(vo);
		}
		return dao.update(vo);
	}
	
	@Override
	public int delete(QnaVo vo) {
		return dao.delete(vo);
	}

	@Override
	public int insertReply(QnaVo vo) {
		// 답글 알고리즘
		dao.onoUpdate(vo);
		vo.setQ_ono(vo.getQ_ono()+1);
		vo.setQ_nested(vo.getQ_nested()+1);
		return dao.insertReply(vo);
	}

	@Override
	public QnaVo edit(QnaVo vo) {
		return dao.detail(vo);
	}

	@Override
	public QnaVo findZeroQ_ono(QnaVo vo) {
		return dao.findZeroQ_ono(vo);
	}

	@Override
	public int gnoAllDelete(int gnum) {
		return dao.gnoAllDelete(gnum);
	}

}
