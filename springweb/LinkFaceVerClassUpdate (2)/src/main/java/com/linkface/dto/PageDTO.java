package com.linkface.dto;

import lombok.Data;

@Data
public class PageDTO {

	private PageUnit unit;
	private int total;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;

	public PageDTO(PageUnit unit, int total) {
		this.unit = unit;
		this.total = total;
		this.endPage=(int)(Math.ceil(unit.getPage()/10.0))*10;
		this.startPage=this.endPage-9;
		int realEnd=(int)(Math.ceil((total*1.0)/unit.getAmount()));
		if(realEnd<this.endPage) this.endPage=realEnd;
		this.prev = this.startPage>1;
		this.next = this.endPage<realEnd;
	}
	
	
}
