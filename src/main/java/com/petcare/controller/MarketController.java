package com.petcare.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Comnt;
import com.petcare.domain.Files;
import com.petcare.domain.LikesList;
import com.petcare.domain.ListVo;
import com.petcare.domain.Objects;
import com.petcare.domain.Pagination;
import com.petcare.domain.PrevAndNext;
import com.petcare.domain.ShareMarket;
import com.petcare.service.ComntService;
import com.petcare.service.FileService;
import com.petcare.service.LikesListService;
import com.petcare.service.ShareMarketService;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Data
@RequestMapping("/market")
@RestController
public class MarketController {
	private ShareMarketService smService;
	private FileService fService;
	private ComntService coService;
	private LikesListService likesService;
	
	@GetMapping("")
	public ModelAndView market() {
		return new ModelAndView("/market/list");
	}
	
	@GetMapping("/list")
	public HashMap<String, Object> list(ListVo listVo){
		HashMap<String, Object> results = new HashMap<String, Object>();
		List<ShareMarket> lists = smService.getShareMarketLists(listVo);
		//listVo로 받아온 시퀀스로 게시글마다 대표 사진 뽑아 오기
		List<String> fnames = new ArrayList<String>();
		for(ShareMarket list : lists) {
			List<Files> files = fService.getFiles(list.getSm_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
		}
		log.info("@@@list:"+lists);
		results.put("fnames", fnames);
		results.put("lists", lists);
		results.put("pagination", new Pagination(listVo, smService.getTotalRowCounts()));
		
		return results;
	}
	
	@GetMapping("/content")
	public ModelAndView content(HttpSession session, HttpServletRequest request, HttpServletResponse response, String sm_seq) {
		// 조회수 중복을 방지하기 위해
		List<HashMap<String, Object>> recentPosts = new ArrayList<HashMap<String, Object>>(); //최근 본 게시물에 대한 정보를 배열에 담기
		
		Cookie viewProof = null;
		Cookie[] allCookies = request.getCookies();
		
		List<Cookie> realAllCookies = Arrays.asList(allCookies); //최근 본 게시물은 역순으로 나와야 함
		Collections.reverse(realAllCookies);
		
		
		if(realAllCookies != null) {
			for(Cookie cookie : realAllCookies) {
				if(cookie.getName().equals(sm_seq)) viewProof = cookie; // 조회한 적 있는 쿠키면 담아라
				
				if(!cookie.getName().contains(sm_seq) && cookie.getName().contains("SM")) { //현재 보는 게시글이 아니면서 이름에 SM이 포함된 쿠키
					ShareMarket recentPost = smService.getShareMarketContents(cookie.getName());
					String recentFileName = null;
					//관리자가 DB를 의도적으로 날렸을 때 쿠키에는 시퀀스가 보존되어 있기 때문에 
					if(fService.getFiles(cookie.getName()).size() != 0) {
						recentFileName = fService.getFiles(cookie.getName()).get(0).getFname();
					}else {
						//쿠키가 DB에 없으니까 삭제해줘야 함
						Cookie removedCookie = new Cookie(cookie.getName(), null);
						removedCookie.setMaxAge(0);
						response.addCookie(removedCookie);
					}
					if(recentPost != null) { //한번 거른 쿠키가 삭제된 게시글이 아니면
						if(recentPosts.size() == 3) continue; //난 최근 게시물 3개만 보여줄 거라서
						HashMap<String, Object> rp = new HashMap<String, Object>();
						rp.put("recentPost", recentPost);
						rp.put("recentFileName", recentFileName);
						recentPosts.add(rp);
					}
				}
			}
		}
		
		if(viewProof == null) {
			response.addCookie(new Cookie(sm_seq, sm_seq));
			smService.renewShareMarketViews(sm_seq);
		}
		
		// 게시글 시퀀스와 세션 정보를 가지고 좋아요 여부를 판단하기 위해
		String email = String.valueOf(session.getAttribute("email"));
		boolean hasLike = false;
		if(email != null) {
			String b_seq = sm_seq;
			hasLike = likesService.getHasLike(b_seq, email);
		}
		
		ModelAndView mv = new ModelAndView();
		
		PrevAndNext pn = smService.getPrevAndNext(sm_seq); // 현재 seq 기준으로 prev, next seq 받기
		HashMap<String, Object> prevAndNext = new HashMap<String, Object>();
		
		prevAndNext.put("shareMarket", smService.getShareMarketContents(pn.getPrevSeq())); // 이전 게시글 정보
		prevAndNext.put("fname", pn.getPrevFname()); // 이전 게시글 대표 사진
		
		mv.addObject("prevContent", prevAndNext); 
		prevAndNext = new HashMap<String, Object>(); // 초기화 clear() 사용하는 것 보다 새 객체를 주입하는 게 부담이 적음
		
		prevAndNext.put("shareMarket", smService.getShareMarketContents(pn.getNextSeq())); // 다음 게시글 정보
		prevAndNext.put("fname", pn.getNextFname()); // 다음 게시글 대표 사진 
		
		mv.addObject("nextContent", prevAndNext);
		mv.addObject("shareMarketContents", smService.getShareMarketContents(sm_seq));
		mv.addObject("imgNames", fService.getFiles(sm_seq));
		mv.addObject("lastPage", new Pagination(new ListVo(0, 5), coService.getTotalRowCounts(sm_seq)).getTotalPageCounts()); // 게시글 입장 시 항상 댓글의 마지막 페이지를 보여주기 위해
		mv.addObject("hasLike", hasLike);
		mv.addObject("recentPosts", recentPosts);
		return mv;
	}
	
	@GetMapping("/comment") // 댓글 리스트 띄우기
	public HashMap<String,Object> comment(HttpSession session, ListVo listVo){
		//댓글 작성, 수정 시 내가 보고 있던 페이지를 띄워주기 위해 세션 설정
		session.setAttribute("currPage", listVo.getPageNum());
		HashMap<String, Object> results = new HashMap<String, Object>();
		results.put("lists", coService.getComntLists(listVo));
		results.put("pagination", new Pagination(listVo, coService.getTotalRowCounts(listVo.getB_seq())));
		return results;
	}
	
	@PostMapping(value = {"/comment", "/recomment"}) // 댓글 작성
	public long coWrite(HttpServletRequest request, HttpSession session, Comnt comment) {
		comment.setEmail(String.valueOf(session.getAttribute("email")));
		long currPage = 0;
		if(request.getServletPath().equals("/market/comment.json")) {
			coService.setComnt(comment);
			// 댓글을 계속 작성하면 마지막 페이지가 입장 시와 달라질 수 있기 때문에  totalPage를 새로 계산
			currPage = new Pagination(new ListVo(0, 5), coService.getTotalRowCounts(comment.getB_seq())).getTotalPageCounts();
		}else if(request.getServletPath().equals("/market/recomment.json")){
			coService.setReply(comment);
			// 대댓글 작성 시 사용자가 보고 있던 페이지 번호를 유지하기 위해 
			currPage = Long.parseLong(String.valueOf(session.getAttribute("currPage")));
		}
		return currPage;
	}
	
	@PutMapping("/comment") // 댓글 수정
	public long coUpdate(HttpSession session, Comnt comment) {
		coService.renewComnt(comment);
		// 댓글 수정 시 사용자가 보던 댓글 페이지를 유지하기 위해 
		return Long.parseLong(String.valueOf(session.getAttribute("currPage")));
	}
	
	@DeleteMapping("/comment") // 댓글 삭제
	public long coDelete(Comnt comment) {
		coService.removeComnt(comment);
		coService.renewChildComnt(comment);
		return new Pagination(new ListVo(0, 5), coService.getTotalRowCounts(comment.getB_seq())).getTotalPageCounts();
	}
	
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgName) {
		return fService.findFiles(imgName);
	}
	
	@GetMapping("/write")
	public ModelAndView write() {
		return new ModelAndView("/market/write");
	}
	
	@PostMapping("/write") // 게시글 작성
	public boolean write(HttpSession session, ShareMarket shareMarket, ArrayList<MultipartFile> multipartFiles) {
		log.info("###"+multipartFiles);
		shareMarket.setEmail(String.valueOf(session.getAttribute("email")));
		shareMarket.setLocation("구로구 구로동");
		shareMarket.setContent(shareMarket.getContent().replace("\r\n", "<br/>")); //개행문자 반영
		log.info("@@@sh1111111"+shareMarket);
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
			}
			fService.setFiles(multipartFiles, shareMarket.getSm_seq(), "SM");
		}
		log.info("@@@sh22222"+shareMarket);
		smService.setShareMarketContents(shareMarket);
		return true;
	}
	
	@GetMapping("/update")
	public ModelAndView update(String sm_seq) {
		ModelAndView mv = new ModelAndView("/market/update");
		mv.addObject("files", fService.getFiles(sm_seq));
		mv.addObject("contents", smService.getShareMarketContents(sm_seq));
		return mv;
	}
	
	@PostMapping("/update") // 게시글 수정
	public boolean update(ShareMarket shareMarket, ArrayList<MultipartFile> multipartFiles, Objects fnames) {
		if(fnames != null) {
			for(String fname : fnames.getFnames()) {
				fService.removeFiles(fname);
			}
		}
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
			}
			fService.setFiles(multipartFiles, shareMarket.getSm_seq(),"SM");
		}
		if(shareMarket != null) {
			shareMarket.setContent(shareMarket.getContent().replace("\r\n", "<br/>")); //개행문자 반영
			smService.renewShareMarketContents(shareMarket);
		}
		return true;
	}
	
	@DeleteMapping("/delete") // 게시글 삭제
	public void delete(String sm_seq) {
		smService.removeShareMarketContents(sm_seq);
	}
	
	@PostMapping("/likes") // + 좋아요
	public long plusLike(LikesList likesList) {
		likesService.setLike(likesList);
		return smService.getShareMarketContents(likesList.getB_seq()).getLikes();
	}
	
	@DeleteMapping("/likes") // - 좋아요
	public long minusLike(LikesList likesList) {
		likesService.removeLike(likesList);
		return smService.getShareMarketContents(likesList.getB_seq()).getLikes();
	}
	
}