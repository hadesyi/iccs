<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.io.*" %>
<%@ page import="kjf.ops.*" %>
<%@ page import="kjf.util.*" %>
<%@ page import="sp.uent.*" %>

<%@ taglib uri="/KJFTags" prefix="KTags" %>
<%@ page import="sp.usebefore.UseBeforeParam" %>

<%@ include file="../inc/user_inc.jsp" %>


<%
	// 상단 플래쉬 링크 정보
	String top_pageNum  = "1";
	String top_sub      = "8";
	
	// 좌측 플래쉬 링크 정보
	String left_pageNum = "9";
	String left_sub     = "1";
%>

<%
	// 초기 변수 들 선언
	UseBeforeParam pm = (UseBeforeParam)request.getAttribute("pm");

	//======================================================================
	// 신규인경우에는 초기화가 되지 않으면 error가  나기 때문에 초기화가 필요하다.
	//======================================================================
	
	// 사용전검사관리 조회
	ReportEntity rEntity  = KJFUtil.REntPrint((ReportEntity)request.getAttribute("rEntity"));
	// 사용전검사관리 메모 조회
	ReportEntity mEntity  = KJFUtil.REntPrint((ReportEntity)request.getAttribute("mEntity"));
	
	// 1.구내통신선로설비   2.방송공동수신설비   3.이동통신구내선로설비     
	ReportEntity rEntTable1  = KJFUtil.REntPrint((ReportEntity)request.getAttribute("rEntTable1"));
	ReportEntity rEntTable2  = KJFUtil.REntPrint((ReportEntity)request.getAttribute("rEntTable2"));
	ReportEntity rEntTable3  = KJFUtil.REntPrint((ReportEntity)request.getAttribute("rEntTable3"));
	
	//======================================================================
		
  String mode 			= KJFUtil.print(request.getParameter("mode"));
	

	// 페이징 관련(필수)
	String nowPage          = KJFUtil.print(pm.getNowPage());
	String rowPerPage       = KJFUtil.print(pm.getRowPerPage());
	String totalCount      	= KJFUtil.print(pm.getTotalCount());
  
	// 사용전검사 관리
	String CIV_RECV_NUM				= rEntity.getValue(0,"CIV_RECV_NUM"); // 접수번호
	String OPE_NAME						= rEntity.getValue(0,"OPE_NAME"); // 시공자 상호
	String APPLPER_NM					= rEntity.getValue(0,"APPLPER_NM"); // 건축주
	String PROC_STE						= rEntity.getValue(0,"PROC_STE"); // 처리상태
	String DEFI_YN						= rEntity.getValue(0,"DEFI_YN"); // 사용전검사 관리 FLAG 값
	String INSP_SPOT_NM				= rEntity.getValue(0,"INSP_SPOT_NM"); // 현장명칭
	String CODE_NAME					= rEntity.getValue(0,"CODE_NAME"); // 건축물용도
	String AREA								= rEntity.getValue(0,"AREA"); // 면적
	String NUM_FL							= rEntity.getValue(0,"NUM_FL"); // 층수
	String USEBEFINSP_DELINUM = rEntity.getValue(0,"USEBEFINSP_DELINUM"); //필증교부번호
	String CER_DELI_YN				= rEntity.getValue(0,"CER_DELI_YN");	//필증교부
	String DELI_DT						= rEntity.getValue(0,"DELI_DT"); //필증발급일
	
	if (DELI_DT.length() == 8){
		DELI_DT = DELI_DT.substring(0,4)+"-"+DELI_DT.substring(4,6)+"-"+DELI_DT.substring(6,8);
	} else {DELI_DT ="";}
	
	String NAPPL_CAUSE				= rEntity.getValue(0,"NAPPL_CAUSE"); //부적합시 부적합 사유
	String WORK_ITEM					=	KJFUtil.print(rEntity.getValue(0,"WORK_ITEM"),"0"); // 구내통신선로설비공사/텔레비전공동시청안테나설비공사 /이동통신구내선로설비공사
	String WRKI001						= "";
	String WRKI002						= "";
	String WRKI003						= "";
	 
	if (!"".equals(DEFI_YN)){
		if (!"0".equals(WORK_ITEM)){
			String strlist_work_etc[]= null;
			strlist_work_etc = WORK_ITEM.split("/");		
			for (int m = 0; m < strlist_work_etc.length; m++){			
				if ("구내통신선로설비공사".equals(strlist_work_etc[m].trim())){	WRKI001 = "Y";} else { WRKI001 = "N"; } 
				if ("텔레비전공동시청안테나설비공사".equals(strlist_work_etc[m].trim())){	WRKI002 = "Y";} else{	WRKI002 = "N";}
				if ("이동통신구내선로설비공사".equals(strlist_work_etc[m].trim())){	WRKI003 = "Y"; } else {	WRKI003 = "N";}
			}
		}
	}
	
	String WORK_ITEM_ETC			=	rEntity.getValue(0,"WORK_ITEM_ETC"); // 방송공동수신설비 (지상파TV,위성방송,FM라디오방송,종합유선방송)
	String work_etc						= WORK_ITEM_ETC;
	String WRK001							= ""; // 지상파TV  		WORK_ITEM_ETC 분할처리
	String WRK002							= ""; // 위성방송			WORK_ITEM_ETC 분할처리
	String WRK003							= ""; // FM라디오방송	WORK_ITEM_ETC 분할처리
	String WRK004							= ""; // 종합유선방송	WORK_ITEM_ETC 분할처리
	String NAPPL_YN						= rEntity.getValue(0,"NAPPL_YN"); // 검사결과최종의견 (1:적합 2:비적합)
	
	if ( work_etc.indexOf("(") >=0 ){
		String strwork_etc = work_etc.substring(work_etc.indexOf("("),work_etc.indexOf(")"));
		strwork_etc = strwork_etc.replace("(","").replace(")","");
		String strlist_etc[]= null;
		strlist_etc = strwork_etc.split(",");
		
		for (int m = 0; m < strlist_etc.length; m++){
			if ("지상파 TV".equals(strlist_etc[m])){
				WRK001 = "Y";
			} else if ( "위성방송".equals(strlist_etc[m])){
				WRK002 = "Y";
			} else if ( "FM라디오방송".equals(strlist_etc[m])){
				WRK003 = "Y";
			} else if ( "종합유선방송".equals(strlist_etc[m])){
				WRK004 = "Y";
			}
		}
	}
%>

<html>
<head>
<title>등록안내 페이지입니다.</title>

<!-- 공통 : S -->
<link href="../css/total.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../com/js/topMenu.js" type="text/javascript"></script>
<script language="javascript" src="../com/js/httpRequest.js" type="text/javascript"></script>
<script language="JavaScript" src="../com/js/com.js" type="text/javascript"></script>
<script language="JavaScript" src="../com/js/ozViewerPop.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
/***************************************************************************
* Title   : 사용전검사  
* Content : 사용전검사 내용을 저장    
****************************************************************************/
function fnSave(){
	var fm = document.fmParam;
	fm.submit();
}

function fn_Memo_save(){
	var fm = document.fmParam;	
	var paramStr = "&mode="+fm.mode.value+"&SEQ="+fm.SEQ.value+"&RECV_NUM="+fm.RECV_NUM.value+"&MEMO_DT="+ fm.MEMO_DT.value +"&WRT_TIME="+fm.WRT_TIME.value+"&MEMO_CONT="+fm.MEMO_CONT.value;
	sendRequest("../usebefore/UseBeforeAction.do", "cmd=UseBeforeMemoCUD"+paramStr, viewDeliMemo, "POST");	
}
function viewDeliMemo() {
	var result = httpRequest.responseText;
	var fm = document.fmParam;
	if (result != "0" || result !="") {
		var sub_memo = document.getElementById("sub_memo");
		sub_memo.innerHTML = result;
		fm.MEMO_DT.value = "";
		fm.WRT_TIME.value = "";
		fm.MEMO_CONT.value = "";			
	} else if(result == "N") {
		alert("이미 등록된 정보 입니다.");
	} else {
		alert("처리중 오류가 발생하였습니다 다시 실행해 주십시오.");
	}
}
//선택 삭제
function fn_Memo_delete() {
	var fm = document.fmParam;
  var chkarray = "";
	if(chkBoxCheck('chk')){ // 선택된 항목이 있는지 체크
		var isOK = confirm('선택한 항목을 삭제하시겠습니까?');
		if(isOK){
			//삭제 처리
			var fm = document.fmParam;
			for(i = 0;i < fm.elements.length;i++){
				if(fm.elements[i].name == "chk" && fm.elements[i].checked){
					 chkarray = fm.elements[i].value + "," + chkarray ;
				}
			}			
			var paramStr = "RECV_NUM="+fm.RECV_NUM.value+"&chk="+ chkarray;
			sendRequest("../usebefore/UseBeforeAction.do", "cmd=UseBeforeMemoCUD&mode=D&"+paramStr, viewDeliMemo, "POST");	
		}
  }
}
//선택 삭제
function fn_Memo_update(str,str2,str3,str4) {
	var fm = document.fmParam;	
	document.getElementById("WRT_TIME").readOnly = true;
	document.getElementById("WRT_TIME").style.backgroundColor = "#eeeeee";
	document.getElementById("MEMO_CONT").readOnly = true;
	document.getElementById("MEMO_CONT").style.backgroundColor = "#eeeeee";
		
	fm.MEMO_DT.value 		= str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6,8);
	fm.WRT_TIME.value		= str2;
	fm.MEMO_CONT.value 	= str3;
	fm.SEQ.value 				= str4;
	
	var tb_clear = document.getElementById("tb_clear");
	var tb_enable = document.getElementById("tb_enable");
	var tb_delete = document.getElementById("tb_delete");

	tb_clear.innerHTML = "<img src='../images/box/btn_insert_off.gif'>";
	tb_enable.innerHTML = "<img src='../images/box/btn_modify_off.gif'>";
	tb_delete.innerHTML = "<img src='../images/box/btn_delet_off.gif'>";
}

function fn_Memo_clear(){
	//alert(document.location.host);

	var fm = document.fmParam;
	document.getElementById("WRT_TIME").readOnly = false;
	document.getElementById("WRT_TIME").style.backgroundColor = "";
	document.getElementById("MEMO_CONT").readOnly = false;
	document.getElementById("MEMO_CONT").style.backgroundColor = "";
	fm.MEMO_DT.value 		= "";
	fm.WRT_TIME.value		= "";
	fm.MEMO_CONT.value 	= "";
	fm.mode.value = "C";
/*
	var tb_clear = document.getElementById("tb_clear");
	var tb_enable = document.getElementById("tb_enable");
	var tb_delete = document.getElementById("tb_delete");
	
	tb_clear.innerHTML = "<img src='../images/box/btn_insert_off.gif'>";
	tb_enable.innerHTML = "<img src='../images/box/btn_modify_off.gif'>";
	tb_delete.innerHTML = "<img src='../images/box/btn_delet_off.gif'>";
	*/
}

function fn_Memo_cancel(){
	var tb_save = document.getElementById("tb_save");
	var tb_cancel = document.getElementById("tb_cancel");
	tb_save.innerHTML = "<img src='../images/box/btn_save_off.gif'>";
	tb_cancel.innerHTML = "<img src='../images/box/btn_cancel_off.gif'>";	

	var tb_clear = document.getElementById("tb_clear");
	var tb_enable = document.getElementById("tb_enable");
	var tb_delete = document.getElementById("tb_delete");
	tb_clear.innerHTML = "<img src='../images/box/btn_insert.gif'>";
	tb_enable.innerHTML = "<img src='../images/box/btn_modify.gif'>";
	tb_delete.innerHTML = "<img src='../images/box/btn_delet.gif'>";
}

function fn_Memo_enable(){
	var fm = document.fmParam;
	document.getElementById("WRT_TIME").readOnly = false;
	document.getElementById("WRT_TIME").style.backgroundColor = "";
	document.getElementById("MEMO_CONT").readOnly = false;
	document.getElementById("MEMO_CONT").style.backgroundColor = "";
	fm.mode.value = "U";
}
/***************************************************************************
* Title   : 탭 처리  
* Content : 탭 처리를 한다.    
****************************************************************************/
function go_tab(value){
	if (value == 1) {
		document.all['tab1'].style.display="block";
		document.all['tab2'].style.display="none";
	} else if(value == 2) {
		document.all['tab1'].style.display="none";
		document.all['tab2'].style.display="block";
	} 
}

/***************************************************************************
* Title   : 탭 처리  
* Content : 탭 처리를 한다.    
****************************************************************************/
function go_tab_sub(value){
	if (value == 1) {
		document.all['tabsub1'].style.display="block";
		document.all['tabsub2'].style.display="none";
		document.all['tabsub3'].style.display="none";
	} else if(value == 2) {
		document.all['tabsub1'].style.display="none";
		document.all['tabsub2'].style.display="block";
		document.all['tabsub3'].style.display="none";
	} else if(value == 3) {
		document.all['tabsub1'].style.display="none";
		document.all['tabsub2'].style.display="none";
		document.all['tabsub3'].style.display="block";
	}
}
// 달력
function click_where() {
        MM_showHideLayers('div_start','','hide');
        MM_showHideLayers('div_end','','hide');
}

function fn_List(){
	var fm = document.fmParam;
	fm.cmd.value = "UseBeforeMgr";
	fm.submit();
}


<% // 필증발급 %>
function cerDeli_Pro(){
	var fm = document.fmParam;
	var rDeliNum = "<%=USEBEFINSP_DELINUM%>";
	if(fm.CER_DELI_YN.checked){
		 if(fm.USEBEFINSP_DELINUM.value == "" || rDeliNum == "" ){			
				sendRequest("../usebefore/UseBeforeAction.do", "cmd=DeliNumMgr&DELI_ITEM=U", viewDeliRs, "POST");
			}
	}else{
		alert('이미 필증발급되었습니다.');
		fm.CER_DELI_YN.checked=true;
		fm.CER_DELI_YN.value="1";
	}
}
<% // 필증발급결과 %>
function viewDeliRs() {
	var result = httpRequest.responseText;
	var fm = document.fmParam;
	if (result != "0" || result !="") {
		fm.USEBEFINSP_DELINUM.value = result;
	} else if(result == "N") {
		alert("이미 등록된 정보 입니다.");
	} else {
		alert("처리중 오류가 발생하였습니다 다시 실행해 주십시오.");
	}
}

function fn_GroupWare(obj)
{
	var fm = document.fmParam;
	if(!confirm('전자 결제로 전송 하시겠습니까?')) return;

	var rDeliNum = "<%=USEBEFINSP_DELINUM%>";
	if(fm.USEBEFINSP_DELINUM.value != "" || rDeliNum != "" ){
		sendRequest("../usebefore/UseBeforeAction.do", "cmd=UBIConfirmMgr&scOFFI_ID"+<%=user.getUSER_ID()%>, viewDeliRs, "POST");
	} else {
		alert("필증발급을 해 주십시오");
	}

	
/*	var sArgs = "scOFFI_ID=" + quote(global.g_User_ID);
	var sTid = "CONFIRM";
	var sUrl = "ICCS::ub/UbAction.do?cmd=UBIConfirmMgr";
	var sInDs = "";
	var sOutDs = "dsGroupWare=output";
	var sCallBack = "fn_CallBack";
	*/
//	Transaction(sTid, sUrl, sInDs, sOutDs, sArgs, sCallBack);
}

//-->
</SCRIPT>
<%	
out.print("<script language=\"JavaScript\" src=\"../flash/flash_pub.js\" type=\"text/javascript\"></script><noscript><p>JavaScript</p></noscript>");
%>
<!-- 공통 : E -->

</head>
<body>

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
  		<div id="top_navi"><%@ include file="../inc/main_top.jsp" %></div>	
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
					<a href="../"><img src="../images/common/icon_home.gif" alt="HOME"></a> 공무원센터    |  공사업등록업체조회     |  정보통신공사업자검색
				</p>
			</div>
			<!-- 현재위치 : E -->
	
			<!-- 서브타이틀 : S -->
			<div id="sub_title">
				<h3 class="cont01"><img src="../images/box/titile_09_1.gif" alt="사용전검사관리"></h3>
			</div>
			<!-- 서브타이틀 : E -->
   
		  	<!-- 컨텐츠 : S -->
			<div id="contents" >
				<form name=fmParam method="post" action="../usebefore/UseBeforeAction.do" >
					<input type="hidden" name="RECV_NUM" value="<%=pm.getRecv_num()%>" />
					<input type="hidden" name="cmd" value="UseBeforeMgrCUD" />
					<input type="hidden" name="mode" value="C" />
					<input type="hidden" name="SEQ" value="" />
					
					<!-- ======================== =================  ========================== -->
					<!-- ======================== 본문 디자인 부분 START ========================== -->
					<!-- ======================== ================= =========================== -->			
									
					<!-- ======================== TAB 디자인 부분 START ========================== -->
					<table width="100%" border="0"  cellspacing="0" cellpadding="0">
						<tr>
							<td align="right">
								<img src="../images/box/btn_save.gif" onclick="fnSave();">
								<img src="../images/box/btn_list.gif" onclick="fn_List();">
							</td>
						</tr>
						<tr>
					     	<td align="left">
						        <!-- tab 시작  -->
						        <%
								String Tabcolum[] ={
													"현장검사관리|go_tab(1)|sel-80",
													"메모|go_tab(2)|80"
													};
								KJFTab tab = new KJFTab(Tabcolum);
								
								String TabcolumSub[] ={
										"1.구내통신선로설비|go_tab_sub(1)|sel-130",
										"2.방송공동수신설비|go_tab_sub(2)|130",
										"3.이동통신구내선로설비|go_tab_sub(3)|150"
										};
								KJFTabSub tabsub = new KJFTabSub(TabcolumSub);
								%>
						        <%=tab.toScript() %>
					        <!-- tab 끝  -->
					      	</td>
						</tr>
					</table>
					<!-- ======================== TAB 디자인 부분 END ============================ -->
					
					<!-- ======================== [TAB1] 기본설정 START ========================= -->
					<table width="100%"  border="0" cellspacing="0" cellpadding="3" class="inputta" id="tab1">
						<tr>
							<th class="line" width="9%">접수번호</th>
							<td class="line" width="20%"><%=CIV_RECV_NUM%><input name="OPE_NAME" type="hidden" size="17" id="CIV_RECV_NUM" value="<%=CIV_RECV_NUM%>"></td>
							<th class="line" width="11%">시공자상호</th>
							<td class="line" width="20%"><%=OPE_NAME%><input name="OPE_NAME" type="hidden" size="15" id="OPE_NAME" value="<%=OPE_NAME%>"></td>
							<th class="line" width="8%">건축주</th>
							<td class="line" width="8%"><%=APPLPER_NM%><input name="APPLPER_NM" type="hidden" size="8" id="APPLPER_NM" value="<%=APPLPER_NM%>"></td>
							<th class="line" width="9%">처리상태</th>
							<td class="line" width="10%">
							   <KTags:KJFSelect item='<%=(Vector)request.getAttribute("v_scPROC_STE")%>'
							 		name='PROC_STE'
							 		value='<%=KJFUtil.print(PROC_STE) %>'
							 		script="class='input_bbs' "/> 
							</td>
						</tr>
						<tr>
							<th class="line" width="9%">현장명칭</th>
							<td class="line" width="20%"><%=INSP_SPOT_NM%><input name="INSP_SPOT_NM" type="hidden" size="17" id="INSP_SPOT_NM" value="<%=INSP_SPOT_NM%>"></td>
							<th class="line" width="11%">건축물용도</th>
							<td class="line" width="20%"><%=CODE_NAME%><input name="CODE_NAME" type="hidden" size="15" id="CODE_NAME" value="<%=CODE_NAME%>"></td>
							<th class="line" width="8%">면적</th>
							<td class="line" width="8%"><%=AREA%><input name="AREA" type="hidden" size="5" id="AREA" value="<%=AREA%>"></td>
							<th class="line" width="9%">층수</th>
							<td class="line" width="10%"><%=NUM_FL%><input name="NUM_FL" type="hidden" size="5" id="NUM_FL" value="<%=NUM_FL%>"></td>
						</tr>	
						<tr>
							<td colspan="8" class="inputTable_td">&nbsp;&nbsp;<%=tabsub.toScript() %></td>
						</tr>					
						<tr>
							<td colspan="8" class="inputTable_td" >
								<!-- ======================== [TABSUB1] 기본설정 START ========================= -->
								<table width="100%"  border="0" cellspacing="0" cellpadding="3"  id="tabsub1">
									<tr>
										<td>					
												<%@ include file="../usebefore/sub_table_1.jsp" %>
										</td>
									</tr>
								</table>
								<!-- ======================== [TABSUB1] 기본설정 END =========================== -->
								<!-- ======================== [TABSUB2] 추가속성 START ========================= -->
								<table width="100%"  border="0" cellspacing="0" cellpadding="3" class="inputta" id="tabsub2" style="display:none;">
									<tr>
								  	<td>
												<%@ include file="../usebefore/sub_table_2.jsp" %>
					      	 </td>
							  	</tr>
				  				<tr height="1px"><td colspan="8">&nbsp;</td></tr>						  	
								  <tr> 	
								  	<th class="line" style="border-top:1px solid #448fd0;">
								  		<input name="WRK001" type=checkbox value="지상파 TV"  <%="Y".equals(WRK001)?"checked":""%>>지상파TV
								  		<input name="WRK002" type=checkbox value="위성방송"  <%="Y".equals(WRK002)?"checked":""%>>위성방송
											<input name="WRK003" type=checkbox value="FM라디오방송"  <%="Y".equals(WRK003)?"checked":""%>>FM라디오방송
											<input name="WRK004" type=checkbox value="종합유선방송"  <%="Y".equals(WRK004)?"checked":""%>>종합유선방송
										</th>	
									</tr>							  		
								</table>
								<!-- ======================== [TABSUB2] 추가속성 END =========================== -->
								<!-- ======================== [TABSUB2] 추가속성 START ========================= -->
								<table width="100%"  border="0" cellspacing="0" cellpadding="3" class="inputTable" id="tabsub3" style="display:none;">
									<tr>
								  	<td>
											<%@ include file="../usebefore/sub_table_3.jsp" %>
										</td>
									</tr>
								</table>
		      	 </td>
				  	</tr>
						<tr>
							<td colspan="8">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="inputTable" >
									<tr>
										<th class="line" width="20%" style="border-top:1px solid #448fd0;">검사결과 최종의견</th>
										<td class="line" style="border-top:1px solid #448fd0;">
											<input type="radio" name="NAPPL_YN" value="1" <%="1".equals(NAPPL_YN)?"checked":""%> />적합
							     		<input type="radio" name="NAPPL_YN" value="2" <%="2".equals(NAPPL_YN)?"checked":""%> />비적합
										</td>
										<th class="line" width="20%" style="border-top:1px solid #448fd0;">필증교부번호 </th>
										<td class="line" style="border-top:1px solid #448fd0;">
											<input name="USEBEFINSP_DELINUM" type="text" size="20" id="USEBEFINSP_DELINUM" value="<%=USEBEFINSP_DELINUM%>" readonly> 
										</td>
										<th class="line" rowspan="3" style="border-top:1px solid #448fd0;border-left:1px solid #448fd0;"><img src="../images/box/approval.gif" onClick="fn_GroupWare();" align="absmiddle" style="cursor:hand" ></td>										
									</tr>
									<tr>
										<th class="line" width="20%">필증교부유무</th>
										<td class="line"><input name="CER_DELI_YN" type=checkbox onClick="cerDeli_Pro()" value="1" <%="1".equals(CER_DELI_YN)?"checked":""%>>필증교부</td>					
										<th class="line" width="20%">필증발급일 </th>
										<td class="line" >                                  
										<!-- 달력  -->
											<input name="DELI_DT" type=text id="scStartDate" value="<%=DELI_DT %>" size="10" readonly>
												<div id="div_start" style="position:absolute;  width:167px; height:187px; z-index:1; visibility: hidden; " >
													<iframe src='../com/calander.jsp?frm=fmParam&fName=DELI_DT' scrolling="no" frameborder="0" width="160" height="190"></iframe>
												</div>
												<img src="../images/box/cal.gif" onClick="MM_showHideLayers('div_start','','show')" align="absmiddle" style="cursor:hand" >
										</td>
									</tr>
									<tr>
										<th class="line" width="20%">부적합시 부적합 사유</th>
										<td class="line" colspan="3"><input name="NAPPL_CAUSE" type="text" size="45" id="NAPPL_CAUSE" value="<%=NAPPL_CAUSE%>"></td>									
									</tr>
								</table>
							</td>
						</tr>	
						<tr height="135px"><td colspan="8">&nbsp;</td></tr>
					</table>
					<!-- ======================== [TAB1] 기본설정 END =========================== -->
					
					<!-- ======================== [TAB2] 추가속성 START ========================= -->
					<table width="100%"  border="0" cellspacing="0" cellpadding="3" class="inputTable" id="tab2" style="display:none;">
						<tr>
					      	<td >
										<%@ include file="../usebefore/sub_memo.jsp" %>					      	
					      	</td>
					  </tr>  
					</table>
					<!-- ======================== [TAB2] 추가속성 END =========================== -->
					
					<!-- ========================  =================  ========================== -->
					<!-- ========================  본문 디자인 부분 END   ========================== -->
					<!-- ========================  =================  ========================== -->				
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