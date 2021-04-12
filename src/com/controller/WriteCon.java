package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.EmotionDAO;
import com.model.EmotionDTO;
import com.model.MemberDTO;

@WebServlet("/WriteCon")
public class WriteCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession();
		MemberDTO m_dto = (MemberDTO) session.getAttribute("id");
		String emotion = request.getParameter("emote");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String date = request.getParameter("date");
		String analysis_e =request.getParameter("analysis_e");
		
		EmotionDTO dto = new EmotionDTO(m_dto.getId(), emotion, title, content, date, analysis_e);
		EmotionDAO dao = new EmotionDAO();
		
		// ���̾ ���� dao
		int countDiary = dao.countDiary(m_dto.getId(), date);
		// ���� ������ư�� ������ �� write.jsp���
		if(countDiary > 0) {
			 int updateCnt= dao.update(dto);   
	         // ���� ���� Ȯ�� 
			 if (updateCnt > 0) {
	            System.out.println("���� ����");
	            response.sendRedirect("select_read.jsp");
	            // ������ ���� wDto�� ����
	            session.setAttribute("wDto", dto); 
	         } else {
	            System.out.println("���� ����");
	         }
		}else {
			// �ٷ� write.jsp�� ���� ��
			int cnt = dao.write(dto);
			if (cnt > 0) {
				System.out.println("���̾ �ۼ� ����");
				response.sendRedirect("select_read.jsp");
				session.setAttribute("wDto", dto);
			} else {
				System.out.println("���̾ �ۼ� ����");
				response.sendRedirect("write.jsp");
			}
		}
	
	}

}
