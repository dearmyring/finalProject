package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.repository.AdminDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.MemberCountVO;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class AdminRestController {

	@Autowired
	private AdminDao adminDao;
	
	@PostMapping("/admin")
	public String login(
			@RequestBody AdminDto adminDto) {
		AdminDto findDto = adminDao.login(adminDto.getAdminId());
		
		if(findDto == null) {
			return "fail";
		}
		
		if(findDto.getAdminPw().equals(adminDto.getAdminPw())) {
			return findDto.getAdminNick();
		}
		return "fail";
	}
	
	@PostMapping("/admin-count")
	public ListSearchVO adminCount(@RequestBody ListSearchVO vo) {
		vo.setCount(adminDao.adminPostCount(vo));
		vo.setFirstBlock(vo.startBlock());
		vo.setLastBlock(vo.endBlock());
		vo.setHavePrev(vo.hasPrev());
		vo.setHaveNext(vo.hasNext());
		return vo;
	}
	
	
	@GetMapping("memberCount")
	public MemberCountVO memberCount() {
		
		return  adminDao.memberCount();
	}
	
	
}

