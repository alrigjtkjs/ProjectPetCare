package com.petcare.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Chatting;
import com.petcare.service.ChattingService;
import com.petcare.service.DolbomService;
import com.petcare.service.MemberService;
import com.petcare.handler.Room;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	List<Room> roomList = new ArrayList<Room>();
	List<Chatting> chattinglist = new ArrayList<Chatting>();
	List<HashMap<String, String>> recordslist = new ArrayList<HashMap<String, String>>();
	static int roomNumber = 0;
	@Autowired
	private MemberService memberservice;
	@Autowired
	private ChattingService chattingservice;
	/*@Autowired
	private DolbomService dservice;*/
	
	@RequestMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/chat");
		return mv;
	}
	
	/**
	 * 방 페이지
	 * @return
	 */
	@RequestMapping("/room")
	public ModelAndView room() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/room");
		return mv;
	}
	
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@RequestMapping("/createRoom")
	public @ResponseBody List<Chatting> createRoom(@RequestParam HashMap<Object, Object> params){
		String roomName = (String) params.get("roomName");
		String email = (String) params.get("email");
		
		
		String gemail = "aa@example.com";
		log.info("방 만들 때 이메일"+email);
		if(roomName != null && !roomName.trim().equals("")) {
			Chatting chatting = new Chatting();
			UUID rNUUID = UUID.randomUUID();
			String rN = rNUUID.toString();
			
			chatting.setC_subject(roomName);
			chatting.setC_guest(gemail);
			chatting.setC_number(rN);
			chatting.setC_owner(email);
			log.info("서비스 위");
			chattingservice.insertS(chatting);
			chattinglist = chattingservice.listS(email, email);
			log.info("서비스 밑");
			
		}
		return chattinglist;
	}
	
	@RequestMapping("/deleteRoom")
	public @ResponseBody List<Chatting> deleteRoom(@RequestParam HashMap<Object, Object> params) {
		String roomNumber = (String) params.get("roomNumber");
		String email = (String) params.get("email");
		chattinglist = chattingservice.listS(email, email);
		chattingservice.deleteS(roomNumber);
		return chattinglist;
	}
	
	/**
	 * 방 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("/getRoom")
	public @ResponseBody List<Chatting> getRoom(@RequestParam HashMap<Object, Object> params){
		log.info("getRoom:"+roomList);
		String email = (String) params.get("email");
		log.info("email: "+email);
		chattinglist = chattingservice.listS(email, email);
		log.info("getRoom:"+chattinglist);

	
		return chattinglist;
	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String roomNumber = (String) params.get("roomNumber");
		String email = (String) session.getAttribute("email");
		String uN = memberservice.getNicknameS(email);
		
		log.info("무브챗 이메일: "+email);
		chattinglist = chattingservice.listS(email, email);
		log.info(chattinglist);
		List<Chatting> new_list = chattinglist.stream().filter(o->o.getC_number().equals(roomNumber)).collect(Collectors.toList());
		log.info("뉴리스트"+roomNumber+new_list);
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", params.get("roomName"));
			mv.addObject("roomNumber", params.get("roomNumber"));
			mv.addObject("uN", uN);
			readFile(roomNumber);
			mv.addObject("recordslist", recordslist);
			mv.setViewName("chat/chat");
		}else {
			mv.setViewName("chat/room");
		}
		return mv;
	}
	
	@RequestMapping("/getNickName")
	public @ResponseBody HashMap<String, String> getNickName(String email) {
		log.info(email);
		String userName = memberservice.getNicknameS(email);
		log.info(userName);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userName", userName);
		return map;
	}
	@PostMapping("/searchroom")
	public @ResponseBody List<Chatting> search(String c_owner, String c_guest, String c_subject){
		List<Chatting> chattinglist = new ArrayList<Chatting>();
		chattinglist = chattingservice.listsearchS(c_owner, c_guest, c_subject);
		return chattinglist;
	}
	
	public void readFile(String roomNumber) {
		File file = new File("C:/Users/Kosmo/Desktop/file/roomnumber"+roomNumber+".txt");
		String records ="";
		//HashMap<String, String> map = new HashMap<String,String>();
		recordslist = new ArrayList<HashMap<String, String>>();
		String userName = "";
		String msg = "";
		if (!file.exists()) {
			System.out.println("파일이 없어요");
		}
		HashMap<String, String> map = new HashMap<String,String>();
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "utf-8"));
			while((records = br.readLine()) != null) {
				log.info("레코즈:"+records);
				
				if(records.contains("userName:")) {
					int idx = records.indexOf(":");
					userName = records.substring(idx+1);
					log.info("아이디 자름"+userName);
					map.put("userName",userName);
					log.info("##유저맵: "+map);
				} 
				if(records.contains("msg:")) {
					int idx = records.indexOf(":");
					msg = records.substring(idx+1);
					log.info("메시지자름"+msg);
					map.put("msg",msg);
					//recordslist.add(map);
					log.info("##메세지맵: "+map);
					recordslist.add(map);
					map = new HashMap<String,String>();
				}
				
				log.info("##리스트: "+recordslist);
			}
		}catch(Throwable e) {
			System.out.println("저런 파일이 없어요");
		}
		
	}
}
