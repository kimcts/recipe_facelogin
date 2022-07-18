package com.linkface.dto;

import lombok.Data;

@Data
public class PageUnit {

	private int page;
	
	private int amount;
	
	public PageUnit() {
		this.page = 1;
		this.amount = 20;
	}
	
	public PageUnit(int page, int amount) {
		this.page = page;
		this.amount = amount;
	}
	
	
	
}
