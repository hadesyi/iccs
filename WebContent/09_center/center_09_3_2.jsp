<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="kjf.ops.*" %>
<%@ page import="kjf.util.*" %>
<%@ page import="sp.illegality.*" %>
<%
	ReportEntity rEntity = KJFUtil.REntPrint( (ReportEntity)request.getAttribute("rEntity") );
	ReportEntity dEntity = KJFUtil.REntPrint( (ReportEntity)request.getAttribute("dEntity") );
	
	IllegalityParam pm = (IllegalityParam)request.getAttribute("pm");

	// 페이징 관련(필수)
	String nowPage    = KJFUtil.print(pm.getNowPage());
	String rowPerPage = KJFUtil.print(pm.getRowPerPage());
	String totalCount = KJFUtil.print(pm.getTotalCount());
	
	// 상단 플래쉬 링크 정보
	String top_pageNum  = "1";
	String top_sub      = "8";
	
	// 좌측 플래쉬 링크 정보
	String left_pageNum = "7";
	String left_sub     = "3";
%>

<script language="JavaScript" type="text/javascript">

/***************************************************************************
* Title   : 목록 
* Content : 리스트 목록으로 처리한다.
****************************************************************************/
function fn_goList(){
    var fm = document.fmParam;
    fm.action = "../illegality/IllegalityAction.do?cmd=IllRegCancelList";
    fm.method = "post";
    
    fm.submit();
}
</script>

<html lang="ko">
<head>
<title>등록취소 페이지입니다.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="robots" content="noindex,nofollow">
<meta name="author" content="부산광역시">
<meta name="keywords" content="정보통신공사업시스템">
<meta name="description" content="정보통신공사업시스템">
<meta http-equiv="imagetoolbar" content="no">

<!-- 공통 : S -->
<link href="../css/total.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../com/js/topMenu.js" type="text/javascript"></script>
<script language="JavaScript" src="../flash/flash_pub.js" type="text/javascript"></script>
<!-- 공통 : E -->

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
					<a href="../"><img src="../images/common/icon_home.gif" alt="HOME"></a>공무원센터 | 행정처분 | 등록취소
				</p>
			</div>
			<!-- 현재위치 : E -->
	
			<!-- 서브타이틀 : S -->
			<div id="sub_title">
				<h3 class="cont01"><img src="../09_center/images/titile_09_3_2.gif" alt="등록취소"></h1>
			</div>
			<!-- 서브타이틀 : E -->
   
		  	<!-- 컨텐츠 : S -->
			<div id="contents">

				<form name=fmParam method="post" action="../illegality/IllegalityAction.do" >
				<input type="hidden" name="cmd"        value="IllRegCancelView">		
				<input type="hidden" name="nowPage"    value="<%=nowPage%>">
				<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">

				<!-- 청문실시통지 : S -->
				<h4>청문실시통지</h4>
				<table class="t2" summary="">
				    <caption></caption>
				    <colgroup>
				    <col style="width: 120px; text-align: center; " />
				    <col style="width: 215px; " />
				    <col style="width: 120px; text-align: center; " />
				    <col style="width: 215px; " />
				    </colgroup>
				    <tbody>
						<% if (rEntity.getRowCnt() > 0) { %>
				        <tr>
				            <th scope="row">청문제목</th>
				            <td colspan="3"><strong><%=KJFUtil.print(rEntity.getValue(0, "AUDI_SUBJ"), "&nbsp;") %></strong></td>
			            </tr>
				    	<tr>
				            <th scope="row">청문당사자</th>
				            <td colspan="3"><%=KJFUtil.print(rEntity.getValue(0, "AUDI_PER_NM"), "&nbsp;") %></td>
			            </tr>
				        <tr>
				            <th scope="row">당사자주소</th>
				            <td colspan="3" class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "AUDI_PER_ADDR"), "&nbsp;") %></td>
			            </tr>
				        <tr>
				            <th scope="row">처분사유</th>
				            <td colspan="3"><%=KJFUtil.print(rEntity.getValue(0, "ADMI_DISPO_CAUSE"), "&nbsp;") %></td>
			            </tr>
				        <tr>
				            <th scope="row">법적근거</th>
				            <td colspan="3"><%=KJFUtil.print(rEntity.getValue(0, "LEG_BAS"), "&nbsp;") %></td>
			            </tr>
				    	<tr>
				            <th scope="row">실시기관</th>
				            <td><%=KJFUtil.print(rEntity.getValue(0, "AUDI_EXEC_ORG"), "&nbsp;") %></td>
				            <th scope="row">실시부서</th>
				            <td><%=KJFUtil.print(rEntity.getValue(0, "AUDI_EXEC_PART"), "&nbsp;") %></td>
				    	</tr>
				        <tr>
				            <th scope="row">청문장소</th>
				            <td><%=KJFUtil.print(rEntity.getValue(0, "AUDI_EXEC_ADDR"), "&nbsp;") %>&nbsp;
				            	<%=KJFUtil.print(rEntity.getValue(0, "AUDI_EXEC_DETAILADDR"), "&nbsp;") %>
							</td>
				            <th scope="row">청문일시</th>
				            <td class="letter0">
								<%=KJFUtil.print(KJFDate.getChangDatePattern(rEntity.getValue(0, "AUDI_EXEC_DT"), "yyyyMMdd", "yyyy/MM/dd"), "&nbsp;") %>
				            	<%=KJFDate.getTimeFormat(KJFUtil.print(rEntity.getValue(0, "AUDI_EXEC_TIME"))) %>
							</td>
				        </tr>
				    	<tr>
				            <th scope="row">주재자성명</th>
				            <td><%=KJFUtil.print(rEntity.getValue(0, "AUDI_SUPINT_NM"), "&nbsp;") %></td>
				            <th scope="row">주재자직위</th>
				            <td><%=KJFUtil.print(rEntity.getValue(0, "AUDI_SUPINT_POS"), "&nbsp;") %></td>
				    	</tr>
				        <tr>
				            <th scope="row">주재자소속</th>
				            <td colspan="3"><%=KJFUtil.print(rEntity.getValue(0, "AUDI_SUPINT_PART"), "&nbsp;") %></td>
				        </tr>
						<% } else { %>
							<tr>
				            	<td colspan="4"  align="center">등록정보가  없습니다.</td>
				        	</tr>
						<% } %>
				    </tbody>
				</table>
				<!-- 청문실시통지 : E -->
				
				<!-- 청문조서관리 : S -->
				<h4>청문조서관리</h4>

				<% if (dEntity.getRowCnt() > 0) { %>
				<div class="padd10">
					<!-- 청문주재자 및 참석자 : S -->
					<p class="dot01">청문주재자 및 참석자</p>
					<table class="t2" summary="">
					    <caption></caption>
					    <colgroup>
					    	<col style="width: 70px; text-align: center;" />
					    	<col style="width: 40px; text-align: center;" />
					    	<col style="" />
					    	<col style="width: 40px; text-align: center;" />
					    	<col style="" />
					    	<col style="width: 40px; text-align: center;" />
					    	<col style="" />
					    </colgroup>
					    <tbody>
							
					        <tr>
					            <th scope="col">주재자</th>
					            <th class="f9">성명</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_SUPINT_NM"), "&nbsp;") %></td>
					            <th class="f9">직위</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_SUPINT_POS"), "&nbsp;") %></td>
					            <th class="f9">소속</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_SUPINT_PART"), "&nbsp;") %></td>
					        </tr>
							<tr>
						        <th scope="col">참석자</th>
					            <th class="f9">성명</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_ATTEND_PERSON_NM"), "&nbsp;") %></td>
					            <th class="f9">직위</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_ATTEND_PERSON_POS"), "&nbsp;") %></td>
					            <th class="f9">소속</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_ATTEND_PERSON_PART"), "&nbsp;") %></td>
							</tr>							
					    </tbody>
					</table>						
					<!-- 청문주재자 및 참석자 : E -->
					
					<!-- 청문대상자 : S -->
					<p class="dot01">청문대상자</p>
					<table class="t2" summary="">
					    <caption></caption>
					    <colgroup>
					    	<col style="width: 120px; text-align: center" />
					    </colgroup>
					    <tbody>
					        <tr>
					            <th scope="row">출석여부</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_PER_ATTE_YN")).equals("Y")?"출석":"미출석" %></td>
				            </tr>
							
							<% if (KJFUtil.print(dEntity.getValue(0, "AUDI_PER_ATTE_YN")).equals("N") ) { %>
							<tr>
					            <th scope="row">불출석사유</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_PER_NATTE_CAUSE"), "&nbsp;") %></td>
				            </tr>
							<% } %>
				            <tr>
					            <th scope="row">공개여부</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_OPN_YN")).equals("Y")?"공개":"비공개"  %></td>
				            </tr>
							
							<% if (KJFUtil.print(dEntity.getValue(0, "AUDI_PER_ATTE_YN")).equals("N") ) { %>
				            <tr>
					            <th scope="row">비공개사유</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_NOPN_CAUSE"), "&nbsp;") %></td>
				            </tr>
							<% } %>
					    </tbody>
					</table>
					<!-- 청문대상자 : E -->
					
					<!-- 청문일시 및 장소 : S -->
					<p class="dot01">청문일시 및 장소</p>
					<table class="t2" summary="">
					    <caption></caption>
					    <colgroup>
					    	<col style="width: 120px; text-align: center" />
					    	<col style="" />
					    	<col style="width: 120px; text-align: center" />
					    </colgroup>
					    <tbody>
					        <tr>
					            <th scope="row">청문일시</th>
					            <td>
									<%=KJFUtil.print(KJFDate.getChangDatePattern(dEntity.getValue(0, "AUDI_EXEC_DT"), "yyyyMMdd", "yyyy/MM/dd"), "&nbsp;") %>
					            	<%=KJFDate.getTimeFormat(KJFUtil.print(dEntity.getValue(0, "AUDI_EXEC_TIME"))) %>
								</td>
					            <th scope="row">청문장소</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "AUDI_EXEC_LOC"), "&nbsp;") %></td>
				            </tr>
							<tr>
					            
				            </tr>
					    </tbody>
					</table>
					<!-- 청문일시 및 장소 : E -->
					
					<!-- 당사자 진술내용 : S -->
					<p class="dot01">당사자 진술내용</p>
					<table class="t2" summary="">
					    <caption></caption>
					    <colgroup>
					    	<col style="width: 120px; text-align: center" />
					    </colgroup>
					    <tbody>
					        <tr>
					            <th scope="row">진술내용</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "PER_STAT_CONT"), "&nbsp;") %></td>
				            </tr>
							<tr>
					            <th scope="row">제출증거</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "PER_PRES_EVID"), "&nbsp;") %></td>
				            </tr>
					    </tbody>
					</table>
					<!-- 당사자 진술내용 : E -->
					
					<!-- 증거조사 : S -->
					<p class="dot01">증거조사</p>
					<table class="t2" summary="">
					    <caption></caption>
					    <colgroup>
					    	<col style="width: 120px; text-align: center" />
					    </colgroup>
					    <tbody>
					        <tr>
					            <th scope="row">진술내용</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "EVID_INV_POIN"), "&nbsp;") %></td>
				            </tr>
							<tr>
					            <th scope="row">제출증거</th>
					            <td><%=KJFUtil.print(dEntity.getValue(0, "EVID_INV_EVID"), "&nbsp;") %></td>
				            </tr>
					    </tbody>
					</table>
					<!-- 증거조사 : E -->
					</div>
					
					<!-- 청문조서관리 : E -->
					<% } else { %>
					<table class="t2" summary="">
					    <caption></caption>
					    <colgroup>
					    	<col style="width: 120px; text-align: center" />
					    </colgroup>
					    <tbody>
							<tr>
				            	<td colspan="6" align="center">등록정보가  없습니다.</td>
				        	</tr>
						 </tbody>
					</table>
					<% } %>

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

</body>
</html>
