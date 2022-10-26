package com.petcare.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.CareReview;
import com.petcare.service.CareReviewService;
import com.petcare.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j // log찍어보기 위해서 필요
@AllArgsConstructor
@RequestMapping("/review")
@Controller
public class ReviewController {
	private CareReviewService carereviewservice; // service에서 가져오는걸 알려줘야한다 import!!
	private MemberService memberservice;

	@GetMapping("/list.do") //리스트 띄우기
	public ModelAndView list() { // 서비스에 있는 맵퍼 가져오기
		List<CareReview> list = carereviewservice.selectperpageS(); // service에 있는 selectperpageS()실행문을 가져옴
		//log.info("#list:"+list);//자바에서만 가능
		ModelAndView mv = new ModelAndView("review/list", "list", list); // 위에서 만들어진 list를 review/list에 "list"라는 이름으로
		// "list.view에 뿌려준다
		return mv;
	}

	@PostMapping("/write.do") //글작성
	public String write(CareReview carereview,HttpSession session) {
		String writerEmail = (String)session.getAttribute("email");
		String writerNickname = memberservice.getNicknameS(writerEmail);
		carereview.setWriterEmail(writerEmail);
		carereview.setWriter(writerNickname);
		carereview.setDolbomy("비비");
		carereview.setDolbomyEmail("bb@example.com");
		log.info("carereview:"+carereview);
		carereviewservice.insertS(carereview);
		return "redirect:list.do";
	}

	@GetMapping("/write.do")// 
	public String write() {
		return "review/write";
	}

	@GetMapping("/content.do") //list에서 선택글 세부내용 확인
	public ModelAndView contentS(String cr_seq) {// contentS String타입으로 cr_seq
		CareReview carereview = carereviewservice.selectBySeqS(cr_seq);
		ModelAndView mv = new ModelAndView("review/content", "carereview", carereview); // carereview carereview값을 보내줌
		return mv;
	}

	@GetMapping("/del.do") //content에 들어가서 삭제
	public String delete(String cr_seq) {
		carereviewservice.deleteS(cr_seq);
		return "redirect:list.do";
	}

	@GetMapping("/update") //수정누르면 이전정보가져와서 띄우기
	public ModelAndView update(String cr_seq) {
		ModelAndView mv = new ModelAndView("review/update");
		CareReview crv = carereviewservice.selectBySeqS(cr_seq);
		mv.addObject("carereview", crv);
		return mv;
	}

	@PostMapping("/update.do") //2번째수정 누르면 정보가 DB들어갔다가 가져오기 
    public String update(CareReview carereview) {
		String seq = carereview.getCr_seq();
		carereviewservice.editS(carereview);
		return "redirect:list.do"; 
	}
}