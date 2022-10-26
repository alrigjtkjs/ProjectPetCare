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

@Log4j // log���� ���ؼ� �ʿ�
@AllArgsConstructor
@RequestMapping("/review")
@Controller
public class ReviewController {
	private CareReviewService carereviewservice; // service���� �������°� �˷�����Ѵ� import!!
	private MemberService memberservice;

	@GetMapping("/list.do") //����Ʈ ����
	public ModelAndView list() { // ���񽺿� �ִ� ���� ��������
		List<CareReview> list = carereviewservice.selectperpageS(); // service�� �ִ� selectperpageS()���๮�� ������
		//log.info("#list:"+list);//�ڹٿ����� ����
		ModelAndView mv = new ModelAndView("review/list", "list", list); // ������ ������� list�� review/list�� "list"��� �̸�����
		// "list.view�� �ѷ��ش�
		return mv;
	}

	@PostMapping("/write.do") //���ۼ�
	public String write(CareReview carereview,HttpSession session) {
		String writerEmail = (String)session.getAttribute("email");
		String writerNickname = memberservice.getNicknameS(writerEmail);
		carereview.setWriterEmail(writerEmail);
		carereview.setWriter(writerNickname);
		carereview.setDolbomy("���");
		carereview.setDolbomyEmail("bb@example.com");
		log.info("carereview:"+carereview);
		carereviewservice.insertS(carereview);
		return "redirect:list.do";
	}

	@GetMapping("/write.do")// 
	public String write() {
		return "review/write";
	}

	@GetMapping("/content.do") //list���� ���ñ� ���γ��� Ȯ��
	public ModelAndView contentS(String cr_seq) {// contentS StringŸ������ cr_seq
		CareReview carereview = carereviewservice.selectBySeqS(cr_seq);
		ModelAndView mv = new ModelAndView("review/content", "carereview", carereview); // carereview carereview���� ������
		return mv;
	}

	@GetMapping("/del.do") //content�� ���� ����
	public String delete(String cr_seq) {
		carereviewservice.deleteS(cr_seq);
		return "redirect:list.do";
	}

	@GetMapping("/update") //���������� �������������ͼ� ����
	public ModelAndView update(String cr_seq) {
		ModelAndView mv = new ModelAndView("review/update");
		CareReview crv = carereviewservice.selectBySeqS(cr_seq);
		mv.addObject("carereview", crv);
		return mv;
	}

	@PostMapping("/update.do") //2��°���� ������ ������ DB���ٰ� �������� 
    public String update(CareReview carereview) {
		String seq = carereview.getCr_seq();
		carereviewservice.editS(carereview);
		return "redirect:list.do"; 
	}
}