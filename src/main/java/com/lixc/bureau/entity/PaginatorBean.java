package com.lixc.bureau.entity;

public class PaginatorBean {
	/**
	 * 获得总页数
	 * @param tot
	 * @param psz
	 * @return
	 */
	public int getTotPage(int tot,int psz){
		int tp = 0;
		if(tot > 0 && psz > 0){
			tp = tot/psz;
			if(tot%psz > 0){
				tp = tp + 1;
			}
		}else{
			tp = 1;
		}
		return tp;
	}
	/**
	 * 获得开始页
	 * @param curp
	 * @param psz
	 * @return
	 */
	public int getStartPage(int curp,int psz){
		int sp = 0;
		if(curp > 0 && psz > 0){
			sp = (curp - 1) * psz;
		}
		return sp;
	}
	/**
	 * 获得数据行序号
	 * @param count
	 * @param currPage
	 * @param start
	 * @return
	 */
	public static int getRowSeq(int count,int currPage,int start){
		int seq = 0;
		if(currPage == 1){
			seq = count;
		}else{
			seq = count + start;
		}
		return seq;
	}
	/**
	 * 分页
	 * @param total
	 * @param curpage
	 * @param totpage
	 * @param pageform
	 * @return
	 */
	public static String getPage(String total,String curpage,String totpage,String pageform){
		String pageStr = "";
		try{
			if(total == null || total.equals("")){total = "0";}
			if(totpage == null || totpage.equals("")){totpage = "0";}
			if(curpage == null || curpage.equals("")){curpage = "0";}else
			 if(Integer.parseInt(curpage) > Integer.parseInt(totpage)){ curpage = totpage; }
			pageStr = "<div class=\"pager\"><ul class=\"pages\">" +
				"<li class=\"pagerinfo\">共 " + total + " 条记录" + " 当前 " + curpage + " / " + totpage +" 页" + " </li>";
			if(curpage.equals("1") || curpage.equals("0")){
				pageStr = pageStr + "<li><a style=\"color:#AAA;\" > 首页 </a></li>"+"<li><a style=\"color:#AAA\">上一页 </a></li>";
			}else{  
				pageStr = pageStr + "<li><a style=\"color:#000;text-decoration:none\" href=\"javascript:toPage('" + pageform + "',1,'F','" + totpage + "')\"> 首页 </a></li>"+
					"<li><a style=\"color:#000;text-decoration:none\" class=\" prev\" href=\"javascript:toPage('" + pageform + "','" + curpage + "','P')\"> 上一页 </a></li>";
			} 
			if(curpage.equals(totpage) || totpage.equals("0")){
				pageStr = pageStr + "<li><a style=\"color:#AAA\" > 下一页  </a></li>"+ "<li><a style=\"color:#AAA\" >  尾页 </a></li>"; 
			}else{
				pageStr = pageStr + "<li><a style=\"color:#000;text-decoration:none\" class=\" next\" href=\"javascript:toPage('" + pageform + "','" + curpage + "','N','" + totpage + "')\"> 下一页 </a></li>"+
					"<li><a style=\"color:#000;text-decoration:none\" href=\"javascript:toPage('" + pageform + "','" + totpage + "','E')\"> 尾页 </a></li>";
			}
			pageStr = pageStr + "<li class=\"pagerjp\"><input type=\"text\" name=\"pagenum\" id=\"pagenum\" value=\"" + curpage + "\" style=\"margin-top:1px;_margin-top:0px;\" " + 
			" onkeyup=\"onlyNumber(this)\" onafterpaste=\"onlyNumber(this)\" /></li>" + 
			"<li><a style=\"color:#000;text-decoration:none\" href=\"javascript:jpPage('" + pageform + "','" + totpage + "')\">GO</a></li>" + "</ul></div>";
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageStr;
	}
	
	protected void initPaginator(Paginator paginator, int totCount) {
		paginator.setTotCount(totCount);
		paginator.setPageSize(paginator.getPageSize() == 0 ? Paginator.SIZE : paginator.getPageSize());
		paginator.setTotPage(this.getTotPage(totCount,paginator.getPageSize()));
		paginator.setCurPage(paginator.getCurPage()>paginator.getTotPage()?paginator.getTotPage():paginator.getCurPage());
		paginator.setStart(this.getStartPage(paginator.getCurPage(), paginator.getPageSize()));
		paginator.setEnd(paginator.getPageSize());
	}
	
}
