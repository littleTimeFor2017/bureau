package com.lixc.bureau.entity;

import java.io.Serializable;

/**
 * @author SLJ
 * @date 2015年3月19日
 */

public class Paginator implements Serializable{
	private static final long serialVersionUID = -271577622158926300L;
	public static final int SIZE = 25;
	protected int curPage;
	protected int totCount;
	protected int totPage;
	protected int goPage;
	protected int start;
	protected int end;
	protected int pageSize;
	/**
	 * @return the curPage
	 */
	public int getCurPage() {
		return curPage;
	}
	/**
	 * @param curPage the curPage to set
	 */
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	/**
	 * @return the goPage
	 */
	public int getGoPage() {
		return goPage;
	}
	/**
	 * @param goPage the goPage to set
	 */
	public void setGoPage(int goPage) {
		this.goPage = goPage;
	}
	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}
	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	/**
	 * @return the totCount
	 */
	public int getTotCount() {
		return totCount;
	}
	/**
	 * @param totCount the totCount to set
	 */
	public void setTotCount(int totCount) {
		this.totCount = totCount;
	}
	/**
	 * @return the totPage
	 */
	public int getTotPage() {
		return totPage;
	}
	/**
	 * @param totPage the totPage to set
	 */
	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}
	/**
	 * @return the start
	 */
	public int getStart() {
		return start;
	}
	/**
	 * @param start the start to set
	 */
	public void setStart(int start) {
		this.start = start;
	}
	/**
	 * @return the end
	 */
	public int getEnd() {
		return end;
	}
	/**
	 * @param end the end to set
	 */
	public void setEnd(int end) {
		this.end = end;
	}
}
