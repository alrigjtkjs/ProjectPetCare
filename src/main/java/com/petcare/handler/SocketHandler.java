package com.petcare.handler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.websocket.OnClose;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.petcare.domain.Chatting;
import com.petcare.service.ChattingService;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class SocketHandler extends TextWebSocketHandler {
	//HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); //웹소켓 세션을 담아둘 맵
	List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions
	private Gson gson = new Gson();
	List<Chatting> chattinglist = new ArrayList<Chatting>();
	@Autowired
	private ChattingService chattingservice;
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		//메시지 발송
		String msg = message.getPayload();
		JSONObject obj = jsonToObjectParser(msg);
		String msgType = (String) obj.get("type");
		String objmsg = (String) obj.get("msg");
		String objuserName = (String) obj.get("userName");
		if(msgType.equals("enterEvent")) {
			
		}else{
			System.out.println("메세지메세지:"+msg);
			System.out.println("메세지메세지:"+obj);
			System.out.println("메세지메세지:"+obj.get("type"));
			System.out.println("메세지메세지:"+obj.get("msg"));
		}
			String rN = (String) obj.get("roomNumber");
			HashMap<String, Object> temp = new HashMap<String, Object>();
			System.out.println("rls: "+rls);
			if(rls.size() > 0) {
				for(int i=0; i<rls.size(); i++) {
					String roomNumber = (String) rls.get(i).get("roomNumber"); //세션리스트의 저장된 방번호를 가져와서
					chattinglist = chattingservice.listallS();
					System.out.println("핸들러단 룸넘버"+roomNumber);
					if(roomNumber.equals(rN)) { //같은값의 방이 존재한다면
						temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
						chattingservice.updateS(roomNumber);
						saveFile(objmsg,roomNumber, msgType, objuserName);
						break;
					}
				}
				
				//해당 방의 세션들만 찾아서 메시지를 발송해준다.
				for(String k : temp.keySet()) { 
					if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
						System.out.println("건너뛰고있어요");
						System.out.println(k);
						System.out.println(temp.get(k));
						continue;
					}
					
					WebSocketSession wss = (WebSocketSession) temp.get(k);
					System.out.println("wss: "+wss);
					if(wss != null) {
						try {
							System.out.println("덥에스에스");
							System.out.println("덥에스에스"+wss);
							wss.sendMessage(new TextMessage(obj.toJSONString()));
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//소켓 연결
		super.afterConnectionEstablished(session);
		boolean flag = false;
		String url = session.getUri().toString();
		System.out.println("urL:"+url);
		String roomNumber = url.split("/chating/")[1];
		int idx = rls.size(); //방의 사이즈를 조사한다.
		if(rls.size() > 0) {
			for(int i=0; i<rls.size(); i++) {
				String rN = (String) rls.get(i).get("roomNumber");
				chattinglist = chattingservice.listallS();
				String roomNumberTest = (String) chattinglist.get(i).getC_number();
				//readFile(roomNumber);
				if(rN.equals(roomNumber)) {
					flag = true;
					idx = i;
					break;
				}
			}
		}
		
		if(flag) { //존재하는 방이라면 세션만 추가한다.
			HashMap<String, Object> map = rls.get(idx);
			map.put(session.getId(), session);
		}else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("roomNumber", roomNumber);
			map.put(session.getId(), session);
			rls.add(map);
		}
		
		//세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//소켓 종료
		if(rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			System.out.println("소켓이 종료됨");
			for(int i=0; i<rls.size(); i++) {
				rls.get(i).remove(session.getId());
			}
		}
		super.afterConnectionClosed(session, status);
		
	}
	private static JSONObject jsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	private void saveFile(String objmsg, String roomNumber, String msgType, String objuserName) {
		String saveuserName = "";
		String savemsg = "";
		if(msgType.equals("enterEvent")) {
			System.out.println("세이브파일:"+msgType);
		}else if(msgType.equals("wsClose")){
			
		}else if(objmsg.equals("")){
			
		}else{
			System.out.println("세이브파일:"+objuserName);
			System.out.println("세이브파일:"+objmsg);
			System.out.println("세이브파일:"+roomNumber);
			saveuserName = "userName:"+objuserName+"\n";
			savemsg = "msg:"+objmsg+"\n";
			try (FileOutputStream stream = new FileOutputStream("C:/Users/Kosmo/Desktop/file/roomnumber"+roomNumber+".txt", true)) {
				stream.write(saveuserName.getBytes("UTF-8"));
				stream.write(savemsg.getBytes("UTF-8"));    
				} catch (Throwable e) {
					
					e.printStackTrace();    
				}
		}
		
	}
	
	public void readFile(String roomNumber) {
		File file = new File("C:/Users/Kosmo/Desktop/file/roomnumber"+roomNumber+".txt");
		String records ="";
		if (!file.exists()) {
			System.out.println("파일이 없어요");
		}
		try(BufferedReader br = new BufferedReader(new FileReader(file))) {
			while((records = br.readLine()) != null) {
				System.out.println("기록된 메세지"+records);
			}
		}catch(Throwable e) {
			System.out.println("저런 파일이 없어요");
		}
		
	}
}