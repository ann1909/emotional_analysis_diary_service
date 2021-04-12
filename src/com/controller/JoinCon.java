package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.MemberDAO;
import com.model.MemberDTO;

@WebServlet("/JoinCon")
public class JoinCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDTO dto = new MemberDTO(name, birth, id, pw);
		MemberDAO dao = new MemberDAO();
		
		int cnt = dao.join(dto);
		
		if(cnt > 0) {
			response.sendRedirect("index.html");
			System.out.println("회원가입 성공");
		}else {
			response.sendRedirect("join.html");
			System.out.println("회원가입 실패");
		}
	
	}

}
