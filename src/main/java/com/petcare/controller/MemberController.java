package com.petcare.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.petcare.domain.Member;
import com.petcare.domain.Pet;
import com.petcare.service.FileService;
import com.petcare.service.MailSendService;
import com.petcare.service.MemberService;
import com.petcare.service.PetService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/member")
@Controller
public class MemberController {
	private MailSendService mailService;	
	private MemberService mService;
	private PetService pService;
	private FileService fService;
	//페이지 이동
	@GetMapping("/goSignupM.do")
	public String goSignupM() {
		return "member/signup";
	}
	@GetMapping("/goMypage.do")
	public String goMypage() {
		return "member/mypage";
	}
	@GetMapping("/goSignupP.do")
	public String goSignupP() {
		return "/member/signupPet";
	}	
	//회원 C
	@PostMapping("/signup.do")
	public String signupM(Member member, HttpSession session, ArrayList<MultipartFile> multipartFiles){
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) log.info("사진을 로드하는데 실패했습니다");
			}
			fService.setFiles(multipartFiles, member.getEmail(),"");
		}
		mService.signupMS(member);
		log.info("@@@member"+member);
		return "redirect:login.do";
	}	
	//회원 R
	@GetMapping(value="mypage.do", params = {"email"})
	public ModelAndView getMyinfo(@RequestParam("email") String id) {
		Member memberone = mService.getMyinfoS(id);
		ModelAndView mv = new ModelAndView("member/mypage", "memberone", memberone);
		return mv;
	}
	//회원 U
	@PostMapping("/updateM.do")
	public String updateM(@RequestBody Member member){
		log.info("#tm"+member);
		mService.updateMS(member);
		return "redirect:mypage.do";
	}
	//회원 D
	@GetMapping("/deleteM.do")
	public String deleteM(@RequestParam("email") String id, HttpServletRequest httprequest) {
		mService.deleteMS(id);
		log.info("삭제완료");
		HttpSession session = httprequest.getSession();
		session.invalidate();
		log.info("완료");
		return "redirect:/";
	}
	//유효성 검사(회원)
	@PostMapping("/emailCheck.do")
	@ResponseBody
	public String checkEmail(@RequestParam("email") String id) {
		String cid = mService.checkEmailS(id);
		if(id.equals(cid)) {
			return "T";
		}else {
			return "F";
		}		
	}
	@PostMapping("/nickCheck.do")
	@ResponseBody
	public String checkNick(@RequestParam("nick") String nick) {
		String cnick = mService.checkNickS(nick);
		log.info("nick: "+nick+" cnick: "+cnick);
		if(nick.equals(cnick)) {
			return "T";
		}else {
			return "F";
		}		
	}
	@GetMapping("/mailCheck")
	@ResponseBody
	public String checkMail(String email) {		
		return mailService.joinEmail(email);
	}
	//로그인&아웃
	@GetMapping("/login.do")
	public String login() {
		return "member/login";
	}
	@PostMapping("/loginCheck.do")
	public String checkLogin(String id, String pwd, HttpSession session) {
		String truePwd = mService.checkLoginS(id);
		log.info(truePwd);log.info(pwd);log.info(id);log.info(session);
		if (truePwd == null) {
			log.info("#회원정보 불일치");
			return "redirect:/member/login.do";
		} else if (!truePwd.equals(pwd)) { //실패시
			log.info("#비밀번호 오류");
			return "redirect:/member/login.do";
		} else if (truePwd.equals(pwd)) {
			log.info("#로그인 성공");
			session.setAttribute("email", id);
		}
		return "redirect:/";
	}
	@GetMapping("/logout.do")
	public String logout(HttpServletRequest httprequest) {
		HttpSession session = httprequest.getSession();
		session.invalidate();
		return "redirect:/";
	}
	//펫 C	
	@PostMapping("/signupPet.do")
	public @ResponseBody String signupP(Pet pet, HttpSession session, ArrayList<MultipartFile> multipartFiles){
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) log.info("사진을 로드하는데 실패");
			}
			fService.setFiles(multipartFiles, pet.getPetseq(),"pet");
		}
		log.info("@@@@@@@@@@@@@@@signupPet"+pet);
		
		pService.signupPS(pet);
		return "redirect:mypage.do";
	}
	//펫 R
	@GetMapping("/checkPet.do")
	@ResponseBody
	public List<Pet> getPetinfo(@RequestParam("email") String id) {
		List<Pet> list = pService.getPetinfoS(id);
		return list;
	}
	//펫 U
	@PostMapping("/updateP.do")
	public @ResponseBody String updateP(@RequestBody Pet pet){
		log.info("#tm"+pet);
		pService.updatePS(pet);
		return "redirect:mypage.do";
	}
	//펫 D
	@GetMapping(value="deleteP.do", params = {"petseq"})
	public String deleteP(@RequestParam("petseq") String petseq) {
		log.info(petseq);
		pService.deletePS(petseq);
		log.info("삭제완료");
		return "member/mypage";
	}
	//Update 진입시 기존정보 출력
	@GetMapping(value="myinfo.do", params = {"email"})
	public ModelAndView printMyinfo(@RequestParam("email") String id) {
		Member memberone = mService.getMyinfoS(id);
		ModelAndView mv = new ModelAndView("member/update", "memberone", memberone);
		return mv;
	}
	@GetMapping(value="updatePinfo.do", params = {"petseq"})
	public ModelAndView getOnePet(@RequestParam("petseq") String petseq) {
		Pet petone = pService.getOnePetS(petseq);
		log.info(petone);
		ModelAndView mv = new ModelAndView("member/updatePet", "petone", petone);
		return mv;
	}
}