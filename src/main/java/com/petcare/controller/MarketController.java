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
		//listVo�� �޾ƿ� �������� �Խñ۸��� ��ǥ ���� �̾� ����
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
		// ��ȸ�� �ߺ��� �����ϱ� ����
		List<HashMap<String, Object>> recentPosts = new ArrayList<HashMap<String, Object>>(); //�ֱ� �� �Խù��� ���� ������ �迭�� ���
		
		Cookie viewProof = null;
		Cookie[] allCookies = request.getCookies();
		
		List<Cookie> realAllCookies = Arrays.asList(allCookies); //�ֱ� �� �Խù��� �������� ���;� ��
		Collections.reverse(realAllCookies);
		
		
		if(realAllCookies != null) {
			for(Cookie cookie : realAllCookies) {
				if(cookie.getName().equals(sm_seq)) viewProof = cookie; // ��ȸ�� �� �ִ� ��Ű�� ��ƶ�
				
				if(!cookie.getName().contains(sm_seq) && cookie.getName().contains("SM")) { //���� ���� �Խñ��� �ƴϸ鼭 �̸��� SM�� ���Ե� ��Ű
					ShareMarket recentPost = smService.getShareMarketContents(cookie.getName());
					String recentFileName = null;
					//�����ڰ� DB�� �ǵ������� ������ �� ��Ű���� �������� �����Ǿ� �ֱ� ������ 
					if(fService.getFiles(cookie.getName()).size() != 0) {
						recentFileName = fService.getFiles(cookie.getName()).get(0).getFname();
					}else {
						//��Ű�� DB�� �����ϱ� ��������� ��
						Cookie removedCookie = new Cookie(cookie.getName(), null);
						removedCookie.setMaxAge(0);
						response.addCookie(removedCookie);
					}
					if(recentPost != null) { //�ѹ� �Ÿ� ��Ű�� ������ �Խñ��� �ƴϸ�
						if(recentPosts.size() == 3) continue; //�� �ֱ� �Խù� 3���� ������ �Ŷ�
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
		
		// �Խñ� �������� ���� ������ ������ ���ƿ� ���θ� �Ǵ��ϱ� ����
		String email = String.valueOf(session.getAttribute("email"));
		boolean hasLike = false;
		if(email != null) {
			String b_seq = sm_seq;
			hasLike = likesService.getHasLike(b_seq, email);
		}
		
		ModelAndView mv = new ModelAndView();
		
		PrevAndNext pn = smService.getPrevAndNext(sm_seq); // ���� seq �������� prev, next seq �ޱ�
		HashMap<String, Object> prevAndNext = new HashMap<String, Object>();
		
		prevAndNext.put("shareMarket", smService.getShareMarketContents(pn.getPrevSeq())); // ���� �Խñ� ����
		prevAndNext.put("fname", pn.getPrevFname()); // ���� �Խñ� ��ǥ ����
		
		mv.addObject("prevContent", prevAndNext); 
		prevAndNext = new HashMap<String, Object>(); // �ʱ�ȭ clear() ����ϴ� �� ���� �� ��ü�� �����ϴ� �� �δ��� ����
		
		prevAndNext.put("shareMarket", smService.getShareMarketContents(pn.getNextSeq())); // ���� �Խñ� ����
		prevAndNext.put("fname", pn.getNextFname()); // ���� �Խñ� ��ǥ ���� 
		
		mv.addObject("nextContent", prevAndNext);
		mv.addObject("shareMarketContents", smService.getShareMarketContents(sm_seq));
		mv.addObject("imgNames", fService.getFiles(sm_seq));
		mv.addObject("lastPage", new Pagination(new ListVo(0, 5), coService.getTotalRowCounts(sm_seq)).getTotalPageCounts()); // �Խñ� ���� �� �׻� ����� ������ �������� �����ֱ� ����
		mv.addObject("hasLike", hasLike);
		mv.addObject("recentPosts", recentPosts);
		return mv;
	}
	
	@GetMapping("/comment") // ��� ����Ʈ ����
	public HashMap<String,Object> comment(HttpSession session, ListVo listVo){
		//��� �ۼ�, ���� �� ���� ���� �ִ� �������� ����ֱ� ���� ���� ����
		session.setAttribute("currPage", listVo.getPageNum());
		HashMap<String, Object> results = new HashMap<String, Object>();
		results.put("lists", coService.getComntLists(listVo));
		results.put("pagination", new Pagination(listVo, coService.getTotalRowCounts(listVo.getB_seq())));
		return results;
	}
	
	@PostMapping(value = {"/comment", "/recomment"}) // ��� �ۼ�
	public long coWrite(HttpServletRequest request, HttpSession session, Comnt comment) {
		comment.setEmail(String.valueOf(session.getAttribute("email")));
		long currPage = 0;
		if(request.getServletPath().equals("/market/comment.json")) {
			coService.setComnt(comment);
			// ����� ��� �ۼ��ϸ� ������ �������� ���� �ÿ� �޶��� �� �ֱ� ������  totalPage�� ���� ���
			currPage = new Pagination(new ListVo(0, 5), coService.getTotalRowCounts(comment.getB_seq())).getTotalPageCounts();
		}else if(request.getServletPath().equals("/market/recomment.json")){
			coService.setReply(comment);
			// ���� �ۼ� �� ����ڰ� ���� �ִ� ������ ��ȣ�� �����ϱ� ���� 
			currPage = Long.parseLong(String.valueOf(session.getAttribute("currPage")));
		}
		return currPage;
	}
	
	@PutMapping("/comment") // ��� ����
	public long coUpdate(HttpSession session, Comnt comment) {
		coService.renewComnt(comment);
		// ��� ���� �� ����ڰ� ���� ��� �������� �����ϱ� ���� 
		return Long.parseLong(String.valueOf(session.getAttribute("currPage")));
	}
	
	@DeleteMapping("/comment") // ��� ����
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
	
	@PostMapping("/write") // �Խñ� �ۼ�
	public boolean write(HttpSession session, ShareMarket shareMarket, ArrayList<MultipartFile> multipartFiles) {
		log.info("###"+multipartFiles);
		shareMarket.setEmail(String.valueOf(session.getAttribute("email")));
		shareMarket.setLocation("���α� ���ε�");
		shareMarket.setContent(shareMarket.getContent().replace("\r\n", "<br/>")); //���๮�� �ݿ�
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
	
	@PostMapping("/update") // �Խñ� ����
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
			shareMarket.setContent(shareMarket.getContent().replace("\r\n", "<br/>")); //���๮�� �ݿ�
			smService.renewShareMarketContents(shareMarket);
		}
		return true;
	}
	
	@DeleteMapping("/delete") // �Խñ� ����
	public void delete(String sm_seq) {
		smService.removeShareMarketContents(sm_seq);
	}
	
	@PostMapping("/likes") // + ���ƿ�
	public long plusLike(LikesList likesList) {
		likesService.setLike(likesList);
		return smService.getShareMarketContents(likesList.getB_seq()).getLikes();
	}
	
	@DeleteMapping("/likes") // - ���ƿ�
	public long minusLike(LikesList likesList) {
		likesService.removeLike(likesList);
		return smService.getShareMarketContents(likesList.getB_seq()).getLikes();
	}
	
}