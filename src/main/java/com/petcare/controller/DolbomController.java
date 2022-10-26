package com.petcare.controller;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.SearchList;
import com.petcare.domain.Tag;
import com.petcare.domain.Timetable;
import com.petcare.service.AddressService;
import com.petcare.service.DolbomService;
import com.petcare.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/dolbom")
@Controller
public class DolbomController {
	private DolbomService dolbomservice;
	private MemberService memberservice;
	private AddressService addressservice;
		
	@GetMapping("/list.do")
	public String list() {
		return "dolbom/list";
	}
	@GetMapping("/form")
	public String form() {
		return "dolbom/form";
	}
	@PostMapping("/dlist")
	public @ResponseBody List<Dolbomlist> dlist(HttpSession session){
		String email = (String)session.getAttribute("email");
		List<Dolbomlist> dlist = dolbomservice.selectDList(email);
		log.info("#####dlist"+dlist);
		return dlist;
	}
	@PostMapping("/rlist")
	public @ResponseBody List<Dolbomlist> receivelist(HttpSession session){
		String email = (String)session.getAttribute("email");
		List<Dolbomlist> receivelist = dolbomservice.receiveList(email);
		log.info("#####rr"+receivelist);
		return receivelist;
	}
	@PostMapping("/slist")
	public @ResponseBody List<Dolbomlist> sendlist(HttpSession session){
		String email = (String)session.getAttribute("email");
		List<Dolbomlist> sendlist = dolbomservice.sendList(email);
		log.info("#####rr"+sendlist);
		return sendlist;
	}
	@GetMapping("/content.do")
	public ModelAndView content(HttpSession session,String dol_seq) {
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);
		Dolbom dolbom = dolbomservice.contentS(dol_seq);
		List<Dolbom> times = dolbomservice.selectTime(email);
		log.info("@@@times"+times);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dolbom/content");
		mv.addObject("dolbom",dolbom);
		mv.addObject("userNickname",nickname);
		mv.addObject("times",times);
		return mv;
	}
	/*@GetMapping("/search.do")
	public ModelAndView search(HttpSession session,HttpServletRequest request) {
		int currentPage=1;
		int pageSize=6;
		String cpStr = request.getParameter("cp");
		if(cpStr != null) {
			cpStr = cpStr.trim();
			currentPage = Integer.parseInt(cpStr);
		}
		List<Dolbom> dolbom = dolbomservice.selectPerPageS(currentPage, pageSize);
		PageVo page = new PageVo(currentPage,pageSize,dolbomservice.selectCountS());
		String email = (String) session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dolbom/search");
		mv.addObject("dolbom",dolbom);
		mv.addObject("mydong",mydong);
		mv.addObject("page",page);
		return mv;
	}*/
	@GetMapping("/search.do")
	public ModelAndView search(HttpSession session,HttpServletRequest request) {		
		String email = (String) session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		List<String> nearlist = addressservice.selectNeardong(email);
		List<String> region = new ArrayList<String>();
		List<Dolbom> dolbomlist = new ArrayList<Dolbom>();
		region=nearlist;
		region.add(mydong);
		log.info("@@@region:"+region);
		if(mydong!=null) {
			dolbomlist = dolbomservice.searchDong(region);
		}else {
			dolbomlist = dolbomservice.searchAll();
		}
		log.info("@@@dolbomlist:"+dolbomlist);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dolbom/search");
		mv.addObject("dolbom",dolbomlist);
		mv.addObject("mydong",mydong);
		return mv;
	}
	@GetMapping("/form_helper.do")
	public ModelAndView write_helper(HttpSession session) {
		String email = (String) session.getAttribute("email");
		String region = addressservice.selectMydong(email);
		ModelAndView mv = new ModelAndView("dolbom/form_helper","region",region);
		return mv;
	}
	@GetMapping("/form_receiver.do")
	public ModelAndView write_receiver(HttpSession session) {
		String email = (String) session.getAttribute("email");
		String region = addressservice.selectMydong(email);
		ModelAndView mv = new ModelAndView("dolbom/form_receiver","region",region);
		return mv;
	}
	@GetMapping("/receiver_tagitems")
	public @ResponseBody Tag write_receiver(@RequestParam(value="checkboxValues[]") List<String> checkboxValues, String gender, String neighbor,String meeting) {
		Tag tag = new Tag();
		tag.setKind(checkboxValues);
		tag.setGender(gender);
		tag.setMeeting(meeting);
		tag.setNeighbor(neighbor);
		return tag;
	}	
	@PostMapping("/re_write.do")
	public String writeReceiver(HttpSession session,Dolbom dolbom, Timetable timetable, Tag tag){
		if(timetable.getSelectSTime().equals("오후")){
			timetable.setTimeSTable(timetable.getTimeSTable().substring(0, timetable.getTimeSTable().indexOf(":")));		
			int stime = Integer.parseInt(timetable.getTimeSTable());		
			stime = stime+12;		
			timetable.setTimeSTable(Integer.toString(stime)+":00");
		}
		if(timetable.getSelectETime().equals("오후")){
			timetable.setTimeETable(timetable.getTimeETable().substring(0, timetable.getTimeETable().indexOf(":")));
			int etime = Integer.parseInt(timetable.getTimeETable());
			etime = etime+12;
			timetable.setTimeETable(Integer.toString(etime)+":00");
		}
		int year = dolbom.getWorkdate().getYear()+1900;
		int month = dolbom.getWorkdate().getMonth()+1;
		int date = dolbom.getWorkdate().getDate();
		LocalDate localday = LocalDate.of(year, month, date);
		DayOfWeek dayOfWeek = localday.getDayOfWeek();
		String day = dayOfWeek.getDisplayName(TextStyle.NARROW, Locale.KOREAN);		
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);		
		String header = dolbom.getWorkdate()+"("+day+") "+timetable.getTimeSTable()+"~"+timetable.getTimeETable();
		String newTag = "";
		if(tag.getMeeting().equals("X")) {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getGender()+" #"+tag.getNeighbor();
		}else {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getGender()+" #"+tag.getNeighbor()+" #"+tag.getMeeting();
		}
				
		dolbom.setEmail(email);
		dolbom.setNickname(nickname);
		dolbom.setHeader(header);
		dolbom.setCategory("요청");
		dolbom.setWorkday(day);
		dolbom.setWorkstime(timetable.getTimeSTable());
		dolbom.setWorketime(timetable.getTimeETable());
		dolbom.setTag(newTag);
		dolbomservice.insertDolbomS(dolbom);
		
		return "redirect:search.do";
	}
	@PostMapping("he_write.do")
	public String writeHelper(HttpSession session,Dolbom dolbom,Timetable timetable,Tag tag){
		String day = "";
		if(dolbom.getWorkday().equals("월화수목금")) {
			day = "평일";
		}else if(dolbom.getWorkday().equals("토일")) {
			day = "주말";
		}else {
			day = dolbom.getWorkday();
		}
		log.info("##day"+day);
		String workstime="";String worketime="";String worktime="";
		String workstimeStr="";String worketimeStr="";
		int stime = Integer.parseInt(timetable.getTimeSTable());
		int etime = Integer.parseInt(timetable.getTimeETable());
		
		if(timetable.getSelectSTime().equals("오후")) {
			stime = stime+12;
		}
		if(timetable.getSelectETime().equals("오후")) {
			etime = etime+12;
		}
		if(stime<6) {
			workstime="새벽";
		}else if(stime<12) {
			workstime="오전";
		}
		else if(stime<18) {
			workstime="오후";
		}
		else if(stime<24) {
			workstime="저녁";
		}
		if(etime<=6) {
			worketime="새벽";
		}
		else if(etime<=12) {
			worketime="오전";
		}
		else if(etime<=18) {
			worketime="오후";
		}
		else if(etime<=24) {
			worketime="저녁";
		}
		if(workstime.equals(worketime)) {
			worktime=workstime;
		}else {
			worktime=workstime+"/"+worketime;
		}
		if(stime<10) {
			workstimeStr = "0"+stime+":00";
		}else {
			workstimeStr = Integer.toString(stime)+":00";
		}
		if(etime<10) {
			worketimeStr = "0"+etime+":00";
		}else {
			worketimeStr = Integer.toString(etime)+":00";
		}
		log.info("##stime"+stime);
		log.info("##etime"+etime);
			
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);
		String header = day+" "+worktime+" 시간대 가능";
		String newTag = "";
		if(tag.getMeeting().equals("X")) {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getGender()+" #"+tag.getNeighbor();
		}else {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getGender()+" #"+tag.getNeighbor()+" #"+tag.getMeeting();
		}		
		log.info("###newTag"+newTag);
		dolbom.setEmail(email);
		dolbom.setNickname(nickname);
		dolbom.setHeader(header);
		dolbom.setCategory("제공");
		//dolbom.setWorkdate("1111-11-11");
		dolbom.setWorkstime(workstimeStr);
		dolbom.setWorketime(worketimeStr);
		dolbom.setTag(newTag);
		log.info("333#dolbom"+dolbom);
		dolbomservice.insertDolbomS(dolbom);
		
		return "redirect:search.do";
	}
	@GetMapping("/acceptList")
	public @ResponseBody void acceptList(long seq) {
		dolbomservice.setStateContinue(seq);
	}
	@GetMapping("/deleteList")
	public @ResponseBody void deleteList(long seq) {
		dolbomservice.deleteList(seq);
	}
	@GetMapping("/finishList")
	public @ResponseBody void finishList(long seq) {
		dolbomservice.setStateFinish(seq);
	}
	@GetMapping("/cancelList")
	public @ResponseBody void canceltList(long seq) {
		dolbomservice.deleteList(seq);
	}
	@PostMapping("/requestdolbom")
	public @ResponseBody void insertDolbomlist(HttpSession session,String msg,String dol_seq,String kind,String header) {
		/*if(timetable.getSelectSTime().equals("오후")){
			timetable.setTimeSTable(timetable.getTimeSTable().substring(0, timetable.getTimeSTable().indexOf(":")));		
			int stime = Integer.parseInt(timetable.getTimeSTable());		
			stime = stime+12;		
			timetable.setTimeSTable(Integer.toString(stime)+":00");
		}
		if(timetable.getSelectETime().equals("오후")){
			timetable.setTimeETable(timetable.getTimeETable().substring(0, timetable.getTimeETable().indexOf(":")));
			int etime = Integer.parseInt(timetable.getTimeETable());
			etime = etime+12;
			timetable.setTimeETable(Integer.toString(etime)+":00");
		}
		int year = timetable.getWorkdate().getYear()+1900;
		int month = timetable.getWorkdate().getMonth()+1;
		int date = timetable.getWorkdate().getDate();
		LocalDate localday = LocalDate.of(year, month, date);
		DayOfWeek dayOfWeek = localday.getDayOfWeek();
		String day = dayOfWeek.getDisplayName(TextStyle.NARROW, Locale.KOREAN);	
		*/
		Dolbom dolbom = dolbomservice.contentS(dol_seq);
		Dolbomlist requestMsg = new Dolbomlist();
		String category="";
		if(dolbom.getCategory().equals("요청")) {
			category="제공";
		}else if(dolbom.getCategory().equals("제공")) {
			category="요청";
		}
		String semail = (String)session.getAttribute("email");
		String snickname = memberservice.getNicknameS(semail);
		String remail = dolbom.getEmail();
		String rnickname = memberservice.getNicknameS(remail);
		//String region = dolbom.getRegion();
		String state = dolbom.getState();
		String workdate = header;
		//Date workdate = timetable.getWorkdate();
		//String writing = dolbom.getHeader();
		requestMsg.setCategory(category);
		//requestMsg.setMessage(msg);
		requestMsg.setReceiveremail(remail);
		requestMsg.setReceivernick(rnickname);
		requestMsg.setSenderemail(semail);
		requestMsg.setSendernick(snickname);
		//requestMsg.setRegion(region);
		requestMsg.setState(state);
		requestMsg.setDseq(dol_seq);
		requestMsg.setKind(kind);
		requestMsg.setWorkdate(workdate);
		//requestMsg.setWorkday(day);
		//requestMsg.setWorkstime(timetable.getTimeSTable());
		//requestMsg.setWorketime(timetable.getTimeETable());

		log.info("#requestMsg"+requestMsg);
		dolbomservice.insertDolbomListS(requestMsg);
	}
	@GetMapping("searchOption")
	public @ResponseBody List<Dolbom> searchOption(HttpSession session, @RequestParam(value="neighbor[]") List<String> neighbor,String category,String kind,Date workdate) {
		String email = (String) session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		List<String> nearlist = addressservice.selectNeardong(email);
		List<String> region = new ArrayList<String>();
		region=nearlist;
		region.add(mydong);
	
		String tag="";
		if(neighbor.contains("남성")&&neighbor.contains("여성")) {
			tag="#남/여";
		}else if(neighbor.contains("남성")) {
			tag="#남성";
		}else if(neighbor.contains("여성")) {
			tag="#여성";
		}
		if(neighbor.contains("견주")&&neighbor.contains("집사")) {
			tag+=" #견주/집사";
		}else if(neighbor.contains("견주")) {
			tag+=" #견주";
		}else if(neighbor.contains("집사")) {
			tag+=" #집사";
		}
		if(neighbor.contains("사전만남")) {
			tag+=" #사전만남";
		}

		SearchList search = new SearchList();
		search.setKind(kind);
		search.setCategory(category);
		search.setTag(tag);
		search.setRegion(region);
		List<Dolbom> dolbomlist = new ArrayList<Dolbom>();
		
		if(workdate!=null) {
			log.info("야호");
			int year = workdate.getYear()+1900;
			int month = workdate.getMonth()+1;
			int date = workdate.getDate();	
			LocalDate localday = LocalDate.of(year, month, date);
			DayOfWeek dayOfWeek = localday.getDayOfWeek();
			String day = dayOfWeek.getDisplayName(TextStyle.NARROW, Locale.KOREAN);
			search.setWorkdate(workdate);
			search.setWorkday(day);
			if(mydong!=null) {
				dolbomlist = dolbomservice.searchOptionDate(search);
			}else {
				dolbomlist = dolbomservice.searchAllOptionDate(search);
			}
		}else {
			if(mydong!=null) {
				dolbomlist = dolbomservice.searchOption(search);
			}else {
				dolbomlist = dolbomservice.searchAllOption(search);
			}		
		}

		return dolbomlist;
	}
	/*날짜형식 json으로 받을때*/
	@InitBinder
	protected void initBinder(WebDataBinder binder){
		DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}	   	
}