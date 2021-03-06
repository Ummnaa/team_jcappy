package jcappy.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaServiceImpl implements QnaService{

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
	public int insert(QnaVo vo) {
		if	(dao.insert(vo) > 0) {
			dao.gno(vo.getQ_gno());
			return 1;
		} else {
			return 0;
		}
	}
	
	@Override
	public int delete(QnaVo vo) {
		return dao.delete(vo);
	}
	
	@Override
	public QnaVo detail(QnaVo vo) {
		return dao.detail(vo);
	}
	
	@Override
	public List<QnaVo> detailRe(QnaVo vo) {
		return dao.detailRe(vo);
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
	public QnaVo edit(QnaVo vo) {
		return dao.detail(vo);
	}

	@Override
	public int haveRe(QnaVo vo) {
		return dao.haveRe(vo);
	}
	
	@Override
	public List<QnaVo> selectAllUser(QnaVo vo) {
		int totCount = dao.countUser(vo); // 총 개수
		//총 페이지수
		int totPage = totCount / vo.getPageRow();
		if(totCount % vo.getPageRow() > 0) totPage++;
		
		//시작 페이지
		int startPage = (vo.getReqPage() -1) / vo.getPageRange() * vo.getPageRange() + 1;
		int endPage = startPage + (vo.getPageRange()-1);
		if (endPage > totPage) endPage = totPage;
		
		vo.setStartPage(startPage);
		vo.setEndPage(endPage);
		vo.setTotCount(totCount);
		vo.setTotPage(totPage);
		return dao.selectAllUser(vo);
	}
}
