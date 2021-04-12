package com.model;

public class MemberDTO {
	private String name;
	private String birth;
	private String id;
	private String pw;
	
	public MemberDTO(String name, String birth, String id, String pw) {
		this.name = name;
		this.birth = birth;
		this.id = id;
		this.pw = pw;
	}
	
	public MemberDTO(String id, String pw) {
		this.id = id;
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}
}
