package com.petcare.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.petcare.domain.Files;
import com.petcare.domain.FilesVo;
import com.petcare.domain.Path;
import com.petcare.mapper.FilesMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FileServiceImpl implements FileService {
	@Autowired private FilesMapper filesmapper;
	@Autowired private MultipartHttpServletRequest multipartRequest;
	private Map<String, List<Object>> map;
	
	@Override
	public void setFiles(ArrayList<MultipartFile> multipartFiles, String b_seq, String seqinit) {//seq
		Map<MultipartFile, String> uploadImages = new HashMap<MultipartFile, String>(); 

		for(MultipartFile image : multipartFiles) {
			String ofName = image.getOriginalFilename().trim();
			int idx = ofName.lastIndexOf(".");
			String ofHeader = ofName.substring(0, idx);
			String ext =  ofName.substring(idx);
			long ms = System.currentTimeMillis();
			
			StringBuilder sb = new StringBuilder();
			sb.append(ofHeader).append("_").append(ms).append(ext);
			
			String imgName = sb.toString();
			uploadImages.put(image, imgName);
		}		
		if(writeFiles(uploadImages)) {
			for(MultipartFile img : uploadImages.keySet()) {
				FilesVo filesVo = new FilesVo(img, uploadImages.get(img),seqinit);			
				if(b_seq == null) {
					filesmapper.insertFiles(filesVo);
				}else {
					filesVo.setB_seq(b_seq);
					log.info(filesVo);
					filesmapper.insertFiles(filesVo);
				}
			}
		}
	}
	public boolean writeFiles(Map<MultipartFile, String> uploadImages) {
		File dir = new File(Path.FILE_STORE);
		if(!dir.exists()) dir.mkdirs();
		FileOutputStream fos = null;		
		try {
			for (MultipartFile img : uploadImages.keySet()) {
				byte data[] = img.getBytes();
				fos = new FileOutputStream(Path.FILE_STORE + uploadImages.get(img));
				fos.write(data);
				fos.flush();
			}
			return true;
		}catch(IOException ie) {
			return false;
		}finally {
			try {
				if(fos != null) fos.close();
			}catch(IOException ie) {}
		}
	}
	@Override
	public List<Files> getFiles(String b_seq) {
		return filesmapper.selectFiles(b_seq);
	}
	@Override
	public ResponseEntity<Resource> findFiles(String imgName) {
		String path = Path.FILE_STORE + imgName;		
		Resource resource = new FileSystemResource(path);
		if(!resource.exists()) return new ResponseEntity<>(HttpStatus.NOT_FOUND);		
		HttpHeaders headers = new HttpHeaders();
		java.nio.file.Path filePath = null;		
		try {
			filePath = Paths.get(path);
			headers.add("Content-Type", java.nio.file.Files.probeContentType(filePath));
		}catch(IOException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	@Override
	public void removeFiles(String fname) {
		filesmapper.deleteFiles(fname);
	}
	
	//LJY
	
	@Override
	public List<Files> filecontentS(String n_seq){
		return filesmapper.filecontent(n_seq);
	}
	@Override
	public void insertS(Files files) {
		filesmapper.insert(files);
	}
	@Override
	public void deleteS(String n_seq) {
		filesmapper.delete(n_seq);
	}
	@Override
	public MultipartHttpServletRequest getMultipartRequest() {
		return multipartRequest;
	}
	
	@Override
	public void setMultipartRequest(MultipartHttpServletRequest multipartRequest) {
		this.multipartRequest = multipartRequest;
	}
	
	@Override
	public Map<String, List<Object>> getUpdateFileName(){
		upload();
		return map;
	}
	private void upload() {
		map = new Hashtable<String, List<Object>>();
		
		Iterator<String> itr = multipartRequest.getFileNames();
		List<Object> ofnames = new ArrayList<Object>();
		List<Object> savefnames = new ArrayList<Object>();
		List<Object> fsizes = new ArrayList<Object>();
		
		while(itr.hasNext()) {
			StringBuilder sb = new StringBuilder();
			MultipartFile mpf = multipartRequest.getFile(itr.next());
			String ofname = mpf.getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
			String ctm = sdf.format(System.currentTimeMillis());
			sb.append(ctm)
			.append(UUID.randomUUID().toString())
			.append(ofname.substring(ofname.lastIndexOf(".")));
			
			String savefname = sb.toString();
			long fsize = mpf.getSize();
			String fileFullPath = Path.FILE_STORE + savefname;
			
			try {
				mpf.transferTo(new File(fileFullPath)); //�뾽濡쒕뵫
				ofnames.add(ofname);
				savefnames.add(savefname);
				fsizes.add(fsize);
				log.info("�뀋�뀋"+ofname+savefname+fsize);
			}catch(IOException ie) {
				log.info("DragdropServiceImpl upload() ie: " + ie);
			}
		}
		map.put("ofnames", ofnames);
		map.put("savefnames", savefnames);
		map.put("fsizes", fsizes);
	}

	@Override
	public void fileupdateinsertS(Files files) {
		filesmapper.fileupdateinsert(files);
	}
	
	@Override
	public void fileupdatedeleteS(String n_seq, String ofname) {
		filesmapper.fileupdatedelete(n_seq, ofname);
	}
	@Override
	public List<Files> fileupdatedeleteselectS(String n_seq, String ofname) {
		return filesmapper.fileupdatedeleteselect(n_seq, ofname);
	}
}