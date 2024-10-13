package kr.bit.entity;

import lombok.Data;

@Data
public class Criteria {
  private int page; //현재 페이지 번호
  private int perPageNum; // 한페이지에 보여줄 게시글의 수
  // 검색기능에 필요한 변수
  private String type;
  private String keyword;
  
  public Criteria() {
	  this.page=1;
	  this.perPageNum=5;   
  }
  // 현재 페이지의 게시글의 시작번호
  public int getPageStart() {     
	  return (page-1)*perPageNum; 
  }  
}