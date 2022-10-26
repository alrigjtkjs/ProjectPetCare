package com.petcare.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Files;
import com.petcare.domain.Info;
import com.petcare.domain.InfoVo;
import com.petcare.service.FileService;
import com.petcare.service.InfoService;


import com.petcare.domain.Path;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/info")
@Controller
public class InfoController implements Cloneable {
	private InfoService infoservice;
	private FileService filestoreservice;
	@GetMapping("/list.do")
	public ModelAndView list(HttpServletRequest request, HttpSession session) {
		String cpStr = request.getParameter("cp");
		
		int cp = 1;
		if(cpStr == null) {
			Object cpObj = session.getAttribute("cp");
			if(cpObj != null) {
				cp = (Integer)cpObj;
			}
		}else {
			cpStr = cpStr.trim();
			cp = Integer.parseInt(cpStr);
		}
		session.setAttribute("cp", cp);
		
		int ps = 10;
		session.setAttribute("ps", ps);
		
		
		InfoVo listVo = infoservice.getInfoVo(cp, ps);
		listVo.setRange(cp);
		
		
		List<Info> list = infoservice.listS();
		log.info("list:"+list);
		log.info("listS:"+listVo);
		ModelAndView mv = new ModelAndView("info/list","listVo",listVo);
		if(listVo.getList().size() == 0) {
			if(cp>1) {
				return new ModelAndView("redirect:list.do?cp="+(cp-1));
			}else {
				return new ModelAndView("info/list", "listVo", null);
			}
		}else {
			return mv;
		}
		
	}
	@GetMapping("/infowrite.do")
	public String infowrite() {
		return "info/infowrite";
	}
	@PostMapping("/infowrite.do")
	public String write(Info info) {
		infoservice.insertS(info);
		return "redirect:list.do";
	}
	@GetMapping("/infodelete.do")
	public String delete(String n_seq) {
		infoservice.deleteS(n_seq);
		
		List<Files> filecontent = filestoreservice.filecontentS(n_seq);
		for(int i=0;i<filecontent.size();++i) {
			log.info(filecontent.get(i).getFname());
			String fname = filecontent.get(i).getFname();
			File file = new File(Path.FILE_STORE, fname);
			log.info("#�뙆�씪:"+file);
			if(file.exists()) file.delete();
		}
		log.info("#�뙆�씪 �궘�젣�썑: ");
		filestoreservice.deleteS(n_seq);
		return "redirect:list.do";
	}
	@GetMapping("/infocontent.do")
	public ModelAndView content(String n_seq) {
		Info list = infoservice.contentS(n_seq);
		List<Files> filelist = filestoreservice.filecontentS(n_seq);
		ModelAndView mv = new ModelAndView();
		mv.addObject("infolist",list);
		mv.addObject("filelist",filelist);
		mv.setViewName("info/infocontent");
		return mv;
	}
	
	@GetMapping("/infoupdate.do")
	public ModelAndView updatepage(String n_seq) {
		Info list = infoservice.contentS(n_seq);
		List<Files> filelist = filestoreservice.filecontentS(n_seq);
		log.info("filelist: "+filelist);
		ModelAndView mv = new ModelAndView();
		mv.addObject("infolist",list);
		mv.addObject("filelist",filelist);
		mv.setViewName("info/infoupdate");
		return mv;
	}
	@PostMapping("/infoupdate.do")
	public String update(Info info) {
		infoservice.updateS(info);
		String n_seq=info.getN_seq();	
		String url="redirect:infocontent.do?n_seq=";
		url = url + n_seq;
		return url;
	}
	
	@PostMapping("/infotest.do")
	public @ResponseBody void test( MultipartHttpServletRequest mhsr, Files filestore) {
		filestoreservice.setMultipartRequest(mhsr);
		Map<String, List<Object>> map = filestoreservice.getUpdateFileName();
		log.info("#map: "+ map);
		//String appendData = mhsr.getParameter("temp");
		
		Object fnames = map.values().toArray()[0];
		Object ofnames = map.values().toArray()[1];
		Object fsizes = map.values().toArray()[2];
		
		String appendData = mhsr.getParameter("temp");
		log.info("appendData: " + appendData);

		List<Object> fnamelist = (List<Object>) fnames;
		List<Object> ofnamelist = (List<Object>) ofnames;
		List<Object> fsizelist = (List<Object>) fsizes;
		for(int i=0;i<ofnamelist.size();++i) {
			String fname = (String) fnamelist.get(i);
			String ofname = (String) ofnamelist.get(i);
			long fsize = (long) fsizelist.get(i);
			filestore.setFname(fname);
			filestore.setOfname(ofname);
			//filestore.setFsize("0");
			//filestore.setBoardtype("BOARDS");
//			try {
//			TimeUnit.SECONDS.sleep(1);
//			}catch(Exception e) {
//				System.out.println(e);
//			}
			filestoreservice.insertS(filestore);
		}
		
	}
	
	@GetMapping("/filedelete.do")
	public void filedelete(@RequestParam(value="deleteList[]") List<String> deleteList, String n_seq) {
		log.info("�븙�븙�븙�븙�븙�븙");
		log.info(deleteList);
		log.info(n_seq);
		
		for(int i=0; i<deleteList.size();++i) {
			String ofname = deleteList.get(i).toString();
			List<Files> selectlist = filestoreservice.fileupdatedeleteselectS(n_seq,ofname);
			log.info(selectlist);

			log.info(selectlist.get(0).getFname());
			String fname = selectlist.get(0).getFname();
			File file = new File(Path.FILE_STORE, fname);
			log.info("#�뙆�씪:"+file);
			if(file.exists()) file.delete();
		
			filestoreservice.fileupdatedeleteS(n_seq, ofname);
		}
		
	}
	
	@PostMapping("/fileupdate.do")
	public void fileupdateinsertS( MultipartHttpServletRequest mhsr, Files filestore, String n_seq) {
		filestoreservice.setMultipartRequest(mhsr);
		Map<String, List<Object>> map = filestoreservice.getUpdateFileName();
		String appendData = mhsr.getParameter("temp");
		
		Object fnames = map.values().toArray()[0];
		Object ofnames = map.values().toArray()[1];
		Object fsizes = map.values().toArray()[2];
		
		log.info("appendData: " + appendData);
		List<Files> filelist = filestoreservice.filecontentS(n_seq);

		List<Object> fnamelist = (List<Object>) fnames;
		List<Object> ofnamelist = (List<Object>) ofnames;
		List<Object> fsizelist = (List<Object>) fsizes;
		
		
		for(int i=0;i<ofnamelist.size();++i) {
			String fname = (String) fnamelist.get(i);
			String ofname = (String) ofnamelist.get(i);
			log.info("#ofname: "+ofname);
			long fsize = (long) fsizelist.get(i);
			
			log.info("filelist1: "+filelist);
			
			List<String> ofilenamelist = new ArrayList<>();
			String ofnametest ="";
			
			for(int j=0;j<filelist.size();++j) {
				//filelist = filestoreservice.filecontentS(n_seq);
				log.info("ofnametest: " + filelist.get(j).getOfname());
				ofnametest = filelist.get(j).getOfname();
				ofilenamelist.add(ofnametest);
			}
			
			if(ofilenamelist.contains(ofname)) {
				log.info("以묐났�뙆�씪:" + ofname);
				log.info("以묐났�뙆�씪:" + ofnametest);
				log.info("ofnamelist: "+ ofnamelist);
			}else {
				log.info("以묐났�씠 �븘�떂:"+ ofname);
				log.info("以묐났�씠 �븘�떂:" + ofnametest);
				filestore.setFname(fname);
				filestore.setOfname(ofname);
				//filestore.setFsize("0");
				filestoreservice.insertS(filestore);
			}
			
		}
		
		
		
	}
	
	
}