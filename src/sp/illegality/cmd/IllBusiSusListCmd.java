package sp.illegality.cmd;

import javax.servlet.http.HttpServletRequest;

import kjf.action.KJFCommand;
import kjf.cfg.Config;
import kjf.ops.ReportDAO;
import kjf.ops.ReportEntity;
import kjf.util.KJFLog;
import kjf.util.KJFUtil;
import kjf.util.LoginException;

import org.apache.struts.action.ActionForm;

import sp.illegality.IllegalityParam;
import sp.uent.UserEnt;

/***************************************************************************
 * <p>Title       : IllBusiSusListCmd Class</p>
 * <p>Description : 영업정지 리스트 클래스</p>
 * <p>Copyright   : Copyright(c) 2007 PKT. All rights reserved.</p>
 * 
 * NOTE :영업정지 리스트 처리를 한다. 
 * 
 * @version 1.0
 * @author  PKT
 **************************************************************************/
public class IllBusiSusListCmd implements KJFCommand {
    
    UserEnt user;
    
    public IllBusiSusListCmd() {        
    }
    
    public String execute(HttpServletRequest request, ActionForm form) throws Exception {        
        
        user = (UserEnt)request.getSession().getAttribute("user");
        
        // 로그인 유무 체크
        if (KJFUtil.isEmpty(user)) {
            throw new LoginException(request, "회원용 페이지 로그인 체크", "../member/login.do");
        }  
        
        // 검색조건 설정및 체크
        IllegalityParam pm = checkPm(request, form);
        
        // 위법현황 정보 
        loadData(request, pm);
        
        return request.getParameter("cmd");
    }
    
    
    /**
     * 영업정지 리스트 정보를 가져온다.
     * 
     * @param request
     * @param form
     * @throws Exception
     */
    public void loadData(HttpServletRequest request, IllegalityParam pm) throws Exception {
        
        ReportEntity rEntity = null;        
            
        ReportDAO rDAO = new ReportDAO();      
        
        int i = 1;
        
        StringBuffer sbSQL = new StringBuffer();        
        sbSQL.append(" SELECT                                   \n");
        sbSQL.append("        PT_C.COI_WRT_NUM,                 \n");   // 공사업등록번호
        sbSQL.append("        PT_M.TMP_WRT_NUM,                 \n");   // 가등록번호
        sbSQL.append("        PT_M.WRT_NUM,                     \n");   // 등록번호
        sbSQL.append("        PT_M.VIOL_DT,                     \n");   // 위법일자
        sbSQL.append("        PT_C1.CODE_NAME AS VIOL_CONT,     \n");   // 위법내용     
        sbSQL.append("        PT_M.DISPO_DT,                    \n");   // 처분일자
        sbSQL.append("        PT_S.BUSISUSP_START_DT,           \n");   // 시작일자
        sbSQL.append("        PT_S.BUSISUSP_END_DT,             \n");   // 종료일자
        sbSQL.append("        PT_M.MOT_STE,                     \n");   // 진행상태
        sbSQL.append("        PT_C2.CODE_NAME AS MOT_STE_NM     \n");   // 진행상태
        
        
        sbSQL.append("   FROM (PT_R_COMPANY_MASTER PT_C INNER JOIN PT_M_MASTER PT_M     \n");
        sbSQL.append("     ON RTRIM(PT_C.TMP_WRT_NUM) = PT_M.TMP_WRT_NUM)               \n");
        
        sbSQL.append("   INNER JOIN (                                               \n");   
        sbSQL.append("               SELECT TMP_WRT_NUM, WRT_NUM,                   \n");   
        sbSQL.append("                      BUSISUSP_START_DT, BUSISUSP_END_DT      \n");  
        sbSQL.append("                 FROM PT_M_SUSPENSION                         \n");  
        sbSQL.append("              ) PT_S ON PT_M.TMP_WRT_NUM = PT_S.TMP_WRT_NUM   \n");
        sbSQL.append("                    AND PT_M.WRT_NUM = PT_S.WRT_NUM           \n");        
        
        sbSQL.append("   LEFT JOIN (                                    \n");  
        sbSQL.append("              SELECT P_CODE, CODE, CODE_NAME      \n"); 
        sbSQL.append("                FROM PT_COM_CODE                  \n");   
        sbSQL.append("               WHERE P_CODE = 'PTMCONT'           \n");   
        sbSQL.append("              ) PT_C1 ON PT_M.VIOL_CONT_CODE = PT_C1.CODE         \n");  
        
        sbSQL.append("   LEFT JOIN (                                    \n");  
        sbSQL.append("              SELECT P_CODE, CODE, CODE_NAME      \n"); 
        sbSQL.append("                FROM PT_COM_CODE                  \n");   
        sbSQL.append("               WHERE P_CODE = 'PTMSTE'            \n");   
        sbSQL.append("              ) PT_C2 ON PT_M.MOT_STE = PT_C2.CODE    \n");
        
        sbSQL.append("  WHERE PT_C.COI_WRT_NUM = ?  \n");   // 공사업등록번호  
        sbSQL.append("    AND PT_C.MANA_NUM = ?     \n");   // 사업자 번호
        sbSQL.append("  ORDER BY PT_M.VIOL_DT       \n");   // 정렬: 위법일자
        
        rDAO.setValue(i++, user.getREG_NUM());     
        rDAO.setValue(i++, user.getCOM_NUM());    
        
        /* ************************** 페이징 관련 START **************************/
        StringBuffer sbCntSQL = new StringBuffer();
        sbCntSQL.append(" SELECT COUNT(*)  CNT  \n");
        sbCntSQL.append("   FROM (PT_R_COMPANY_MASTER PT_C INNER JOIN PT_M_MASTER PT_M      \n");
        sbCntSQL.append("         ON RTRIM(PT_C.TMP_WRT_NUM) = PT_M.TMP_WRT_NUM)            \n");   
        sbCntSQL.append("   INNER JOIN (                                                    \n");   
        sbCntSQL.append("               SELECT TMP_WRT_NUM, WRT_NUM                         \n");   
        sbCntSQL.append("                 FROM PT_M_SUSPENSION                              \n");  
        sbCntSQL.append("              ) PT_S ON PT_M.TMP_WRT_NUM = PT_S.TMP_WRT_NUM        \n");
        sbCntSQL.append("                    AND PT_M.WRT_NUM = PT_S.WRT_NUM                \n");
        sbCntSQL.append("  WHERE PT_C.COI_WRT_NUM = ?       \n");   // 공사업등록번호  
        sbCntSQL.append("    AND PT_C.MANA_NUM = ?          \n");   // 사업자 번호         
        
        //전체 목록 수
        String totalCount="";

        //페이지별 목록 수
        int rowPerPage = KJFUtil.str2int(pm.getRowPerPage());

        //현재 페이지 번호
        int nowPage = 1;
        nowPage = KJFUtil.isEmpty(pm.getNowPage()) ? 1 : Integer.parseInt(pm.getNowPage());

        rEntity = rDAO.select(sbCntSQL.toString());
        
        totalCount = rEntity.getValue(0, "CNT");
        
        if (rowPerPage == 0) rowPerPage = Integer.parseInt(totalCount);//추가
        if ((rowPerPage*nowPage) - Integer.parseInt(totalCount) > rowPerPage) nowPage = 1;

        pm.setTotalCount(totalCount);
        pm.setNowPage(String.valueOf(nowPage));
        /* *************************** 페이징 관련  END **************************/

        rEntity = rDAO.select(sbSQL.toString(), nowPage, rowPerPage);

        /****** 검색조건 초기값 ***********/
        request.setAttribute("pm", pm);
        request.setAttribute("rEntity", rEntity);
    }
    
    
    /**
     * 폼 체크 메소드
     * 
     * @param request
     * @param form
     * @return
     * @throws Exception
     */
    private IllegalityParam checkPm(HttpServletRequest request, ActionForm form) throws Exception {

        IllegalityParam pm = (IllegalityParam)form;

        // 파라미터 디버깅
        KJFLog.debug(pm.toString(request));
        
        // 페이징 라인
        if (KJFUtil.isEmpty(pm.getRowPerPage())) {            
            pm.setRowPerPage(Config.props.get("ROW_PER_PAGE"));
        }

        return pm;
    }

}
