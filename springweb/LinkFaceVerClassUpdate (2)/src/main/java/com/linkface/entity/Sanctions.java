package com.linkface.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Sanctions {

	private int sanctionsKey;
    private Long userKey;
    private Integer RECIPEID;
    private String reasons;
    private Long sanctioner;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy/MM/dd")
    private Date createDate;
    private String sanctionerName;
    
    public void updateSanctionerName(String sanctionerName) {
    	this.sanctionerName = sanctionerName;
    }

}
