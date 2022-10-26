package com.petcare.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.petcare.service.InfoService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdministratorController {
	private InfoService infoservice;
//	@GetMapping("/admin.do")
//	public ModelAndView main() {
//		ModelAndView mv = new ModelAndView();
//		return mv;
//	}
	@GetMapping("/main.do")
	public String main() {
		return "administrator/main";
	}
}