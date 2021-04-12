package com.model;

public class EmotionDTO {
	private String id;
	private String emotion;
	private String title;
	private String content;
	private String date;
	private String analysis_e;
	
	public EmotionDTO(String id, String emotion, String title, String content, String date, String analysis_e) {
		this.id = id;
		this.emotion = emotion;
		this.title = title;
		this.content = content;
		this.date = date;
		this.analysis_e = analysis_e;
	}
	
	public EmotionDTO(String id, String emotion, String title, String content, String date) {
		this.id = id;
		this.emotion = emotion;
		this.title = title;
		this.content = content;
		this.date = date;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEmotion() {
		return emotion;
	}

	public void setEmotion(String emotion) {
		this.emotion = emotion;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getAnalysis_e() {
		return analysis_e;
	}

	public void setAnalysis_e(String analysis_e) {
		this.analysis_e = analysis_e;
	}
	
}
