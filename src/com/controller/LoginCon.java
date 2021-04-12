package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.MemberDAO;
import com.model.MemberDTO;

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
	
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO(id, pw);
		MemberDTO returnDto = dao.login(dto);
		
		if(returnDto != null) {
			HttpSession session = request.getSession();
			session.setAttribute("id", returnDto);
			
			response.sendRedirect("calendar.jsp");
			
			System.out.println("로그인 성공");
		} else {
			response.sendRedirect("log.html");
			
			System.out.println("로그인 실패");
		}
	}

}
