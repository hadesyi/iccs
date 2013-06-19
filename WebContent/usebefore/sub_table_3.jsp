<%@ page contentType="text/html;charset=utf-8"%>

<!-- scrollbar-face-color: yellow;/*스크롤바 표면 색상*/
scrollbar-highlight-color: FFFFFF;/*표면 왼쪽 부분 겉색상*/
scrollbar-shadow-color: 000000;/*표면 오른쪽 부분 그림자 겉색상*/
scrollbar-3dlight-color: orange;/*표면 왼쪽 부분 입체감 색상*/
scrollbar-arrow-color: 000000;/*스크롤바 조그만 삼각형 색상*/
scrollbar-track-color: FFCC00;/*스크롤바 밑에 레일 트렉 색상*/
scrollbar-darkshadow-color: FFFFFF/*표면 밑 부분 그림자 색상*/
-->
<table id="subtable_3"  width="100%"  border="0" cellspacing="0" cellpadding="3" class="inputta"  >
	<tr>
		<td width="75%">
		
			<DIV style="PADDING-RIGHT: 0px; OVERFLOW-Y: scroll; 
			PADDING-LEFT: 0px; SCROLLBAR-FACE-COLOR: #cccccc; FONT-SIZE: 9pt; 
			PADDING-BOTTOM: 0px; SCROLLBAR-HIGHLIGHT-COLOR: #000000; BORDER-LEFT: medium none; 
			WIDTH: 100%; SCROLLBAR-SHADOW-COLOR: #000000; SCROLLBAR-3DLIGHT-COLOR: #ffffff; 
			SCROLLBAR-ARROW-COLOR: #ffffff; PADDING-TOP: 0px; SCROLLBAR-TRACK-COLOR: #ffffff; 
			BORDER-BOTTOM: medium none; SCROLLBAR-DARKSHADOW-COLOR: #ffffff; HEIGHT: 400px">


			<table  width="100%"  border="0" cellspacing="0" cellpadding="3" class="inputta"  >
				<tr>
					<th class="line" width="70%" colspan="2">검사항목</th>
					<th class="line" width="10%">검사결과</th>
					<th class="line" width="20%">상세내용</th>
				</tr>
				<%
				
					// 1.구내통신선로설비
					String SEQ_3 				= "";
					String CLASS_NAME_3	= ""; 
					String CLASS_NAME_SUB_3	= ""; 
					String ITEM_OUT_3		= "";
					String CONT_3				= "";
					String DETAIL_CONT_3	=	"";
					String BAS_3				= "";
					
					
					String CLASS_NAME_TEMP_3 ="";
					String CLASS_NAME_CNT_3 = "";
					Integer swCNT_3 = 0;
			
					for(int i=0; i<rEntTable3.getRowCnt(); i++){
						SEQ_3 						= rEntTable3.getValue(i,"SEQ");
						CLASS_NAME_3 			= rEntTable3.getValue(i,"CLASS_NAME1");
						CLASS_NAME_SUB_3 			= KJFUtil.print(rEntTable3.getValue(i,"CLASS_NAME2"),"&nbsp;");
						CONT_3						= rEntTable3.getValue(i,"CONT");
						ITEM_OUT_3				= KJFUtil.print(rEntTable3.getValue(i,"ITEM_OUT"),"");
						
						if ("Y".equals(WRKI003)){
							ITEM_OUT_3 ="적합";
						} else if ("N".equals(WRKI003)) {
							ITEM_OUT_3 ="해당없음";
						} else {
							ITEM_OUT_3				= rEntTable3.getValue(i,"ITEM_OUT");
						}
						
						DETAIL_CONT_3			= KJFUtil.print(rEntTable3.getValue(i,"DETAIL_CONT"),"");
						CONT_3						= KJFUtil.print(rEntTable3.getValue(i,"CONT"),"");
						BAS_3 						= rEntTable3.getValue(i,"BAS");
						
						for (int j=0; j < rEntTableCnt3.getRowCnt(); j++){
							CLASS_NAME_TEMP_3	 	= rEntTableCnt3.getValue(j,"CLASS_NAME1");
							CLASS_NAME_CNT_3	 	= rEntTableCnt3.getValue(j,"CNT");
				
							if (CLASS_NAME_3.equals(CLASS_NAME_TEMP_3)){	
								 if ( "1".equals(CLASS_NAME_CNT_3) ){
									  swCNT_3 = 0;
								 } else {
										swCNT_3 = swCNT_3 + 1;
								 }
								break;
							} else {
								CLASS_NAME_CNT_3 = "1";	
							}
						}
				%>
					<input type="hidden" name="SEQ_3" value="<%=SEQ_3%>" />
					<tr>		
					<% if ("1".equals(CLASS_NAME_CNT_3)){ swCNT_3 = 0; // 문항이 한개 일 경우 %>
						<td class="line" ><a href="javascript:fn_Notice_Info('3','<%=CONT_3%>','<%=BAS_3%>')"><%=CLASS_NAME_3 %></a></td>
						<td class="line" ><a href="javascript:fn_Notice_Info('3','<%=CONT_3%>','<%=BAS_3%>')"><%=CLASS_NAME_SUB_3 %></a></td>
					<%	} else { // 문항이 두개이상일 경우 중복 갯수 비교 하여 행 분할
								if ( swCNT_3 == 1 ){
					%>
							<td class="line" rowspan="<%=CLASS_NAME_CNT_3%>"><a href="javascript:fn_Notice_Info('1','<%=CONT_3%>','<%=BAS_3%>')"><%=CLASS_NAME_3 %></a></td>
							<td class="line" ><a href="javascript:fn_Notice_Info('3','<%=CONT_3%>','<%=BAS_3%>')"><%=CLASS_NAME_SUB_3 %></a></td>
					<%		} else {  %>
						<td class="line" ><a href="javascript:fn_Notice_Info('3','<%=CONT_3%>','<%=BAS_3%>')"><%=CLASS_NAME_SUB_3 %></a></td>
					<%		
									if (Integer.toString(swCNT_3).equals(CLASS_NAME_CNT_3)){
										swCNT_3 = 0; // 다음 문항의 행이 두개 이상일 경우  초기화 처리
									} 
								}
							}
					%>
						
						<td class="line" >
		            <KTags:KJFSelect item='<%=(Vector)request.getAttribute("v_scITEM_OUT")%>'
								 name='ITEM_OUT_3'
								 value='<%=KJFUtil.print(ITEM_OUT_3) %>'
								 script="class='input_bbs' "/>       
						</td>
						<td class="line" >
						<input type="text" name ="DETAIL_CONT_3" value="<%=DETAIL_CONT_3%>" size="13" />
						</td>
					</tr>
				<%		
					}
				%>
			</table>
			</DIV>
			
		</td>
		<td width="25%" >
			<table width="100%">
				<tr><th class="line" >검사기준 및 근거</th></tr>
				<tr><td><textarea name ="Notice_3" ROWS="28" COLS="20" readonly></textarea></td></tr>
			</table>
		</td>
	</tr>
</table>