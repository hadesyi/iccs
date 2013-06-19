<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="kjf.ops.*" %>
<%@ page import="kjf.util.*" %>
<%@ page import="sp.regmgr.*" %>

<%
	ReportEntity rEntity = KJFUtil.REntPrint( (ReportEntity)request.getAttribute("rEntity") );	// 공사업 양도양수 정보
	
	RegMgrParam pm = (RegMgrParam)request.getAttribute("pm");
	
	// 상단 플래쉬 링크 정보
	String top_pageNum  = "1";
	String top_sub      = "1";
	
	// 좌측 플래쉬 링크 정보
	String left_pageNum = "1";
	String left_sub     = "3";
%>

<html lang="ko">
<head>
<title>공사업 양도양수 페이지입니다.</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="robots" content="noindex,nofollow">
<meta name="author" content="부산광역시">
<meta name="keywords" content="정보통신공사업시스템">
<meta name="description" content="정보통신공사업시스템">
<meta http-equiv="imagetoolbar" content="no">

<!-- 공통 : S -->
<link href="../css/total.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../com/js/topMenu.js" type="text/javascript"></script>
<script language="JavaScript" src="../flash/flash.js" type="text/javascript"></script>
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
					<a href="../"><img src="../images/common/icon_home.gif" alt="HOME" /></a> 원스톱민원센타 | 등록관리 | 공사업양도양수
				</p>
			</div>
			<!-- 현재위치 : E -->
	
			<!-- 서브타이틀 : S -->
			<div id="sub_title">
				<h3 class="cont01"><img src="../01_one/images/titile_01_3.gif" alt="공사업 양도양수"></h1>
			</div>
			<!-- 서브타이틀 : E -->
   
		  	<!-- 컨텐츠 : S -->
		  <div id="contents">
		  
		  	<!--1기본정보 : S -->
				<h4>기본정보</h4>
				<div class="padd15">
					<!--01접수현황 : S -->
					<p class="dot01">접수현황</p>
					<table  class="t2" summary="접수현황를 나타내는 표">
						<caption class="caption">접수현황</caption>
						<colgroup>
							<col style="width: 90px; " />
							<col style="" />
							<col style="width: 90px; text-align: center" />
							<col style="width:230px;" />
						</colgroup>
						<tbody>
							<% if (rEntity.getRowCnt() > 0) { %>
								<tr>
								  <th>접수번호</th>
								  <td class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "RECV_NUM")) %></td>
								  <th>접수일자</th>
								  <td class="letter0"><%=KJFUtil.print(KJFDate.getChangDatePattern(rEntity.getValue(0, "RECV_DT"), "yyyyMMdd", "yyyy/MM/dd"), "&nbsp;") %></td>
								</tr>
								<tr>
								  <th>양도업체</th>
								  <td><%=KJFUtil.print(rEntity.getValue(0, "NAME")) %></td>
								  <th>양수업체</th>
								  <td><%=KJFUtil.print(rEntity.getValue(0, "TRAN_NAME")) %></td>
								</tr>
								<tr>
								  <th>진행상태</th>
								  <td><%=KJFUtil.print(rEntity.getValue(0, "MOT_STE_NM")) %></td>
								  <th>등록일자</th>
								  <td class="letter0"><%=KJFUtil.print(KJFDate.getChangDatePattern(rEntity.getValue(0, "INS_DT"), "yyyyMMdd", "yyyy/MM/dd"), "&nbsp;") %></td>
								</tr>
							<% } else { %>
								<tr>
								  <td align="center" colspan="4">등록된 접수 정보가 없습니다.</td>
								</tr>
							<% } %>
						</tbody>
				 	 </table>
					 <!--01접수현황 : E -->
					  
					 <!--02양도업체정보 : S -->
					 <p class="dot01">양도업체정보</p>
						<table  class="t2" summary="양도업체정보를 나타내는 표">
							<caption class="caption">양도업체정보</caption>
							<colgroup>
								<col style="width: 90px; " />
								<col style="" />
								<col style="width: 90px; text-align: center" />
								<col style="width:230px;" />
							</colgroup>
							<tbody>
								<% if (rEntity.getRowCnt() > 0) { %>
									<tr>
									  <th>등록번호</th>
									  <td colspan="3" class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "COI_WRT_NUM")) %></td>
									  </tr>
									<tr>
									  <th>업체상호</th>
									  <td><%=KJFUtil.print(rEntity.getValue(0, "NAME")) %></td>
									  <th>대표자</th>
									  <td><%=KJFUtil.print(rEntity.getValue(0, "REP_NM_KOR")) %></td>
									</tr>
									<tr>
									  <th>전화번호</th>
									  <td class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "ADDR_TEL_NUM")) %></td>
									  <th>사업자번호</th>
									  <td class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "MANA_NUM")) %></td>
									</tr>
									<tr>
									  <th>현주소</th>
									  <td colspan="3" class="letter0">
									  	(<%=KJFUtil.setNumFormat(KJFUtil.print(rEntity.getValue(0, "ADDR_POST_NUM"))) %>)
									  	<%=KJFUtil.print(rEntity.getValue(0, "ADDR_ADDR")) %>
									  	<%=KJFUtil.print(rEntity.getValue(0, "ADDR_DETAIL_ADDR")) %>
									  </td>
									</tr>
								<% } else { %>
									<tr>
									  <td align="center" colspan="4">등록된 양도업체정보 정보가 없습니다.</td>
									</tr>
								<% } %>
							</tbody>
					  </table>
					  <!--02양도업체정보 : E -->
					  
					  <!--03양수업체정보 : S -->
					  <p class="dot01">양수업체정보</p>
						<table  class="t2" summary="양수업체정보를 나타내는 표">
							<caption class="caption">양수업체정보</caption>
							<colgroup>
								<col style="width: 90px; " />
								<col style="" />
								<col style="width: 90px; text-align: center" />
								<col style="width:230px;" />
							</colgroup>
							<tbody>
								<% if (rEntity.getRowCnt() > 0) { %>
									<tr>
									  <th>등록번호</th>
									  <td colspan="3" class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "TRAN_WRT_NUM")) %></td>
									  </tr>
									<tr>
									  <th>업체상호</th>
									  <td><%=KJFUtil.print(rEntity.getValue(0, "TRAN_NAME")) %></td>
									  <th>대표자</th>
									  <td><%=KJFUtil.print(rEntity.getValue(0, "TRAN_REP")) %></td>
									</tr>
									<tr>
									  <th>전화번호</th>
									  <td class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "TRAN_TELNUM")) %></td>
									  <th>사업자번호</th>
									  <td class="letter0"><%=KJFUtil.print(rEntity.getValue(0, "TRAN_COMNUM")) %></td>
									</tr>
									<tr>
									  <th>현주소</th>
									  <td colspan="3" class="letter0">
										(<%=KJFUtil.setNumFormat(KJFUtil.print(rEntity.getValue(0, "TRAN_POST_NUM"))) %>)
									  	<%=KJFUtil.print(rEntity.getValue(0, "TRAN_ADDR")) %>
									  	<%=KJFUtil.print(rEntity.getValue(0, "TRAN_DETAIL_ADDR")) %>
									  </td>
									</tr>
								<% } else { %>
									<tr>
									  <td align="center" colspan="4">등록된 양도업체정보 정보가 없습니다.</td>
									</tr>
								<% } %>
							</tbody>
					  </table>
					  <!--03양수업체정보 : E -->
	  	    	</div>
		  	  	<!--1기본정보 : E -->			
					
			  
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
