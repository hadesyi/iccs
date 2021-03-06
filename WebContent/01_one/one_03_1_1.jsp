<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="kjf.ops.*" %>
<%@ page import="kjf.util.*" %>
<%@ page import="sp.usebefore.*" %>

<%
	//ReportEntity recEntity = KJFUtil.REntPrint( (ReportEntity)request.getAttribute("recEntity") );
	ReportEntity rEntity = KJFUtil.REntPrint( (ReportEntity)request.getAttribute("rEntity") );
	
	UseBeforeParam pm = (UseBeforeParam)request.getAttribute("pm");
	
	// 페이징 관련(필수)
	String nowPage    = KJFUtil.print(pm.getNowPage());
	String rowPerPage = KJFUtil.print(pm.getRowPerPage());
	String totalCount = KJFUtil.print(pm.getTotalCount());

	// 상단 플래쉬 링크 정보
	String top_pageNum  = "1";
	String top_sub      = "3";
	
	// 좌측 플래쉬 링크 정보
	String left_pageNum = "3";
	String left_sub     = "1";
	
	int int_rnum = KJFUtil.str2int(totalCount)-(KJFUtil.str2int(nowPage) *KJFUtil.str2int(rowPerPage) - KJFUtil.str2int(rowPerPage));
%>

<html lang="ko">
<head>
<title>사용전검사 현황 페이지입니다.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="robots" content="noindex,nofollow">
<meta name="author" content="부산광역시">
<meta name="keywords" content="정보통신공사업시스템">
<meta name="description" content="정보통신공사업시스템">
<meta http-equiv="imagetoolbar" content="no">

<!-- 공통 : S -->
<link href="../css/total.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../com/js/com.js" type="text/javascript"></script>
<script language="JavaScript" src="../com/js/topMenu.js" type="text/javascript"></script>
<script language="JavaScript" src="../flash/flash.js" type="text/javascript"></script>
<script language="javascript" src="../com/js/httpRequest.js" type="text/javascript"></script>
<script language="JavaScript" src="../com/js/ozViewerPop.js" type="text/javascript"></script>
<!-- 공통 : E -->

<script language="JavaScript" type="text/javascript">

// 검색
function fn_search() {
    var fm = document.fmParam;
    
   	fm.scRecv_num.focus();
   	fm.scRecv_num.select();
    
    fm.nowPage.value = 1;
    fm.submit();
}

//  상세보기
function viewDetail(recv_num) {
    var fm = document.fmParam;
    
    fm.action = "../usebefore/UseBeforeAction.do";
    fm.cmd.value = "UseBeforeChkContent";
    fm.scRecvNum.value = recv_num;
    fm.submit();
}
/*
// 사용전 검사 정보 삭제
 function fn_delUserBefore(recv_num) {
	
    if (confirm("선택된 항목을 삭제 하시겠습니까?")) {
    	var fm = document.fmParam;
        
        fm.action = "../usebefore/UseBeforeAction.do?cmd=UseBeforeD";
        fm.recv_num.value = recv_num;
        
    	fm.submit();
    }  
}

// 검색된정보 등록
function fn_regUserBefore(recv_num) {
	sendRequest("../usebefore/UseBeforeAction.do", "cmd=UseBeforeC&recv_num=" + recv_num, fn_UserBeforeView, "POST");
}

// 등록 결과
function fn_UserBeforeView() {
	var result = httpRequest.responseText;

	if (result == "Y") {
		location.href="../usebefore/UseBeforeAction.do?cmd=UseBeforeChkStatus";
	} else if(result == "N") {
		alert("이미 등록된 정보 입니다.");
	} else {
		alert("처리중 오류가 발생하였습니다 다시 실행해 주십시오.");
	}
}
*/
</script>

</head>
<body>
<noscript><p>자바스크립트를 지원해야 올바르게 동작하는 페이지입니다.</p></noscript>
<!-- 전체 : S -->
<div id="wrapper">
	<div id="skipnavigation">
		<ul>
		<li><a tabindex="0" href="#contents">본문으로 바로가기</a></li>
		<li><a tabindex="0" href="#topmenu">대메뉴로 바로가기</a></li>
		<li><a tabindex="0" href="#leftmenu">소메뉴로 바로가기</a></li>
		</ul>
	</div>
		
	<!-- header : S-->
	<div id="header">
  		<div id="top_navi"><%@ include file="../inc/top.jsp" %></div>	
  		<div id="login"><%@ include file="../inc/top_login.jsp" %></div>
  	</div>
  	<!-- header : E -->
  
    <!-- 페이지 타이틀 : S-->
  	<div id="sub_visual"><%@ include file="sub_visual.jsp" %></div>
 	<!-- 페이지 타이틀 : E -->
 	 
  	<!-- BODY : S -->
	<div id="body">
  	
	  	<!-- left : S -->
	  	<div id="sub_left"><%@ include file="left_menu.jsp" %></div>
		<!-- left : E -->	
	
		<!-- 중간컨텐츠 : S -->
   		<div id="sub_contents"><a name="contents"></a>
			
			<!-- 현재위치 : S -->
			<div id="con_head">
				<p class="position">
					<a href="../"><img src="../images/common/icon_home.gif" alt="HOME"></a> 원스톱민원센타 | 사용전검사 관리 | 사용전검사현황
				</p>
			</div>
			<!-- 현재위치 : E -->
	
			<!-- 서브타이틀 : S -->
			<div id="sub_title">
				<h3 class="cont01"><img src="../01_one/images/titile_02_3.gif" alt="사용전검사  현황"></h1>
			</div>
			<!-- 서브타이틀 : E -->
   
		  	<!-- 컨텐츠 : S -->
			<div id="contents">
			
				<form name=fmParam method="post" action="../usebefore/UseBeforeAction.do" >
					<input type="hidden" name="cmd" value = "UseBeforeChkStatus">
					<input type="hidden" name="scRecvNum">
					<input type="hidden" name="scRecvName" value="<%=user.getUSER_NAME()%>">
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
					<input type="text" name="none" style="display:none">
				
				<h4>사용전검사 접수검색</h4>
				<p class="txt">
					<!-- 신규신청인 경우 <span class="font_greenB" >접수번호</span>를 이용  검색 후 결과를 확인하시고, <span class="font_greenB">[추가]버튼</span>을 클릭하시면 아래 접수현황리스트에 추가됩니다. -->
				</p>

				<!--검색 : S -->
				<table  class="t1" summary="검색를 나타내는 표">
        	<caption class="caption">검색</caption>
					<colgroup>
						<col style="width: 90px; " />
						<col style="width: 130px; " />
						<col style="width: 90px; " />
						<col style="width: 140px; " />
						<col style="width: 90px; " />
						<col style="width: 90px; " />
					</colgroup>
					<tbody>
						<tr>
              <th>이름</th>
              <td><%=KJFUtil.print(user.getUSER_NAME()) %></td>
              <th>기업명</th>
              <td><%=KJFUtil.print(user.getCOM_NAME()) %></td>
						  <th>회원종류</th>
	            <td align="center">
	            <% if ( KJFUtil.print(user.getCAPITAL()).equals("U") ) { %>
									개인회원
							<% } else if ( KJFUtil.print(user.getCAPITAL()).equals("UE") ) { %>
									기업회원
							<% } %>
						  </td>
	          </tr>

						<tr>
            	<th>접수번호</th>
            	<td colspan="5">
             		<input class="input_bbs" name="scRecv_num" size="28" maxlength="28" onkeyup="if(event.keyCode == 13) fn_search();" value="<%=KJFUtil.print(pm.getScRecv_num())%>" title="접수번호를 입력해주세요">
             		<a href="javascript:fn_search()"><img src="../images/bbs/btn_search.gif" alt="검색" align="absmiddle"></a>
      		  	</td>
           </tr>
					
					</tbody>
       	</table>
                
				
				<div class="right" style="padding-bottom: 0px;">&nbsp;</div>
				<!--검색 : E -->
				
				<!-- 사용전검사 접수현황 리스트 : S -->
				<h4>사용전검사 접수현황</h4>
				<table class="t2" summary="">
				    <caption></caption>
				    <colgroup>
					    <col style="width: 35px; text-align: center" />
					    <col style="width: 90px; text-align: center" />				    
					    <col style="width: 90px; text-align: center" />
					    <col style="" />
					    <col style="width: 70px; text-align: center" />
					    <col style="width: 70px; text-align: center" />
					    <col style="width: 70px; text-align: center" />
							<col style="width: 70px; text-align: center" />
				    </colgroup>
				    <thead>
				        <tr>
				        	<th scope="col">번호</th>
									<th scope="col">접수번호</th>
									<th scope="col">신청인</th>
				          <th scope="col">시공업체</th>
									<th scope="col">현장주소</th>
									<th scope="col">접수일자</th>						
									<th scope="col">진행상태</th>
									<th scope="col">필증발급</th>
				        </tr>
				    </thead>
				    <tbody>

						<% 
							if (rEntity.getRowCnt() > 0 ) {
								String proc_ste = "";String server_yn="";
								String ub_print_chk ="";String recv_num = "";
								String online_cert_use_yn = "N";
								for (int i = 0; i < rEntity.getRowCnt(); i++) {
									proc_ste = KJFUtil.print(rEntity.getValue(i, "PROC_STE"));
									server_yn = KJFUtil.print(rEntity.getValue(i, "SERVER_YN"),"0");
									recv_num = KJFUtil.print(rEntity.getValue(i, "RECV_NUM"),"0");
									online_cert_use_yn = KJFUtil.print(rEntity.getValue(i,"ONLINE_CERT_USE_YN"),"N");

									if ( "Y".equals(online_cert_use_yn)){
										 if ("처리완료".equals(proc_ste) && "1".equals(server_yn)){
											 	ub_print_chk = "<img src='../images/btn/btn_cert_public.gif' alt='사용전필증출력' onClick=\"fn_print('"+recv_num+"');\">";
										 } else {
											 if ("처리완료".equals(proc_ste) && "0".equals(server_yn)){
												 ub_print_chk ="<img src='../images/btn/btn_cert_public.gif' alt='사용전필증출력' onClick=\"javascript:alert('서비스 지역이 아닙니다');\" />";
											 } else if (!"처리완료".equals(proc_ste)){
												 ub_print_chk ="<img src='../images/btn/btn_cert_public.gif' alt='사용전필증출력' onClick=\"javascript:alert('처리완료시에 발급가능합니다.');\" />";
											 }
										}
									} else {
										 ub_print_chk ="X";
									}
						%>
							<tr>
			            <td align="center" class="letter0"><%=int_rnum--%></td>
			            <td align="center" class="letter0"><a href="javascript:viewDetail('<%=recv_num%>')"><%=KJFUtil.print(rEntity.getValue(i, "CIV_RECV_NUM")) %></a></td>
							    <td align="center"><%=KJFUtil.print(rEntity.getValue(i, "APPLPER_NM")) %></td>
							    <td align="center" class="letter0"><%=KJFUtil.print(rEntity.getValue(i, "OPE_NAME")) %></td>
							    <td align="center" class="letter0"><%=KJFUtil.print(rEntity.getValue(i, "INSP_SPOT_NM")) %></td>
									<td align="center" class="letter0"><%=KJFUtil.print(KJFDate.getChangDatePattern(rEntity.getValue(i, "RECV_DT"), "yyyyMMdd", "yyyy/MM/dd"), "&nbsp;") %></td>
									<td align="center" class="letter0"><%=proc_ste %></td>
									<td align="center" class="letter0"><%=ub_print_chk %></td>
							</tr>
						<% } // for 
						 	} else { %>
							<tr>
								<td  align="center" colspan="8">등록된 정보가 없습니다.</td>
							</tr>
						<% } %>
				    </tbody>
				</table>
				<!-- 사용전검사 접수현황 리스트 : E -->

				<!-- 페이징 : S -->
				<div class="center">
					<jsp:include page="../com/inc/paging.jsp" flush="true">
					  <jsp:param name="pagePerScreen" value="10"/>
					  <jsp:param name="rowPerPage" value="<%=rowPerPage%>"/>
					  <jsp:param name="totalCount" value="<%=totalCount%>"/>
					  <jsp:param name="nowPage" value="<%=nowPage %>"/>
					</jsp:include>	
				</div>
				<!-- 페이징 : E -->

				</form>
				
			</div>
		   	<!-- 컨텐츠 : E -->
		   	
		</div>
		<!-- 중간컨텐츠 : E -->
  	
  	
	  	<!--퀵메뉴 : S -->
		<div id="quick"><%@ include file="../inc/quick.jsp" %></div>			
		<!--퀵메뉴 : E -->
 	
 	</div>
 	<!-- BODY : E -->
 	
  	<!-- copyright : S -->
 	<div id="foot"><%@ include file="../inc/copy.jsp" %></div> 
 	<!-- copyright : E -->
 	
</div>
<!-- 전체 : E -->

<script language="JavaScript" type="text/javascript">

//츨력 처리
function fn_print(recv_num){
args = new Array();

	var fm = document.fmParam;

	var ozFile 		= "/BeforeInvest/InvestR_home.ozr";
	var ozOdiname 	= "Q)InvestR_home";
	<%
		String ip = request.getRemoteHost();
		String ip_result = "N";
		if ("99".equals(ip.substring(0,ip.indexOf(".")).trim())){
			ip_result ="Y";
		}
	%>
	args[0] = "RECV_NUM=" + recv_num;
	args[1] = "SIDO_CODE=" + "<%=user.getSIDO_CODE()%>";
	args[2] = "SIGUNGU_CODE=" +  "<%=user.getSIGUNGU_CODE()%>";
	args[3] = "IP_CHECK=" +  "<%=ip_result%>";
		
	ozViewerCreatePop(ozFile,ozOdiname,args);

	fm.scRecvNum.value = recv_num;
	fm.cmd.value = "UseBeforeLogOnly";
	fm.target = "ozLog";
	fm.submit();
}
</script>
</body>
</html>
