package jcappy.coupon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CouponServiceImpl implements CouponService {
	
	@Autowired
	CouponDao couponDao;
	
	@Override
	public List<CouponVo> selectAllByMno(CouponVo vo) {
		int totCount = couponDao.countByMno(vo); // 총갯수
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
		
		return couponDao.selectAllByMno(vo);
	}
	
	@Override
	public int use(CouponVo vo) {
		return couponDao.use(vo);
	}
	
	@Override
	public CouponVo detail(CouponVo vo) {
		return couponDao.detail(vo);
	}
	
	
}
