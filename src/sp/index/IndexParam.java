package sp.index;

import javax.servlet.http.HttpServletRequest;

import kjf.util.KJFUtil;

import org.apache.struts.action.ActionForm;

public class IndexParam extends ActionForm {

    /*페이징 관련*/ 
    private String nowPage;
    private String totalCount;
    private String rowPerPage;
    
    /**
     *	request로 부터 parameter의 해당 value를 얻어
     *	paramName : value
     *	형식으로 출력
     */
     public String toString(HttpServletRequest request){
     	return KJFUtil.reportParameters(request) ;
     }

	public String getNowPage() {
		return nowPage;
	}

	public void setNowPage(String nowPage) {
		this.nowPage = nowPage;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public String getRowPerPage() {
		return rowPerPage;
	}

	public void setRowPerPage(String rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
     
}
