<%@ page language="java" import="java.io.*,java.util.*,crosscert.*" %>
<%@ page contentType = "text/html; charset=euc-kr" %>
<%  
	/*-------------------------시작----------------------------*/ 
	response.setDateHeader("Expires",0); 
	response.setHeader("Prama","no-cache"); 

	if(request.getProtocol().equals("HTTP/1.1")) 
	{ 
		response.setHeader("Cache-Control","no-cache"); 
	} 
	/*------------------------- 끝----------------------------*/ 
	
	int nPrilen=0, nCertlen=0, nRet;
	InputStream inPri=null;
	InputStream inCert=null;
	
	//OutputStream out=null;
	byte[] Prifilebuf;
	byte[] Certfilebuf;
	
	
	Properties props = System.getProperties(); // get list of properties
	String file_separator = (String)(props.get("file.separator"));
	String current_dir = "";
	String CertPath = "";
	String Full_path = request.getRealPath(request.getServletPath());
	if (file_separator.equals("\\"))	
	{
		current_dir = Full_path.substring(0,Full_path.lastIndexOf("\\")+1);
		CertPath = current_dir + "\\Cert\\"; 
	}
	else								
	{
		current_dir = Full_path.substring(0,Full_path.lastIndexOf("/")+1);
		CertPath = current_dir + "/Cert/"; 
	}
	//current_dir = request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);
	String SignedData = "";  //전자서명값
	
	String sInput = "01:506-81-32479+02:(주)스마코+03:제조,도소매+04:경북 포항시 남구 연일읍 오천리 634-4번지+05:506-81-00017+06:포항종합제철(주)+07:제조,서비스,도소매,부동산+08:경북 포항시 남구 괴동동 1번지+10:10,790,420+11:1,079,042+12:2001-07-02+13:Cutting Fluid/Oil K MSDS DONG HO DAICOOL,200 L외+14:+15:+16:2001-07-02+30:";
	
	out.println("원문길이 : " + sInput.length()  + "<br>");
	
	try 
	{
		inPri =  new FileInputStream(new File(CertPath + "signPri.key"));
	}
	catch (FileNotFoundException e) 
	{
		out.println(e);
		return;
	}
	catch (IOException e) 
	{
		out.println(e);
		return;
	}
	
	try 
	{
		nPrilen=inPri.available();
		Prifilebuf=new byte[nPrilen];
		
		nRet=inPri.read(Prifilebuf);

		// 전자서명
		Signer signer = new Signer();

		/*
			GetSignedDataP1(byte[] 개인키,  // signPri.key 파일 자체를 담은 바이트배열
							int    개인키길이, 
							String 비밀번호, 
							byte[] 원문, 
							int    원문길이)
		*/
		
		nRet=signer.GetSignedDataP1(Prifilebuf, nPrilen, "88888888", sInput.getBytes(), sInput.getBytes().length);
		if (nRet != 0)
		{
			out.print("에러메시지 : " + signer.errmessage + "<br>");
			return;
		}

		out.println("전자서명 성공(PKCS#1)<br>");
		out.println("전자서명(바이너리) 길이 : " + signer.signedlen + "<br>");


		// 바이너리 테이타 base64인코딩

		Base64 CBase64 = new Base64();
							  //바이트 배열     //바이트 배열길이
		nRet = CBase64.Encode(signer.signedbuf, signer.signedlen);
		if(nRet==0) 
		{
			out.println("서명값 Base64 Encode 결과 : 성공<br>") ;
			SignedData = new String(CBase64.contentbuf);
			out.println("서명값 Base64 Decode 값 : " + SignedData + "<br>") ;
		}
		else
		{
			out.println("서명값 Base64 Decode 결과 : 실패<br>") ;
			out.println("에러내용 : " + signer.errmessage + "<br>");
			out.println("에러코드 : " + CBase64.errcode + "<br>");
		}
		
	}
	catch(IOException e1) 
	{
		out.println(e1); 
	}

%>

<script language="javascript" src="../cc.js"></script>

<pre>
<font color = red>

=====================================================================================
 ** 소스 **
=====================================================================================

< % @ page language="java" import="java.io.*,java.util.*,<b><font size = 4>crosscert.*</font></b>" % >
< % @ page contentType = "text/html; charset=euc-kr" % >
< %  
	/*-------------------------시작----------------------------*/ 
	response.setDateHeader("Expires",0); 
	response.setHeader("Prama","no-cache"); 

	if(request.getProtocol().equals("HTTP/1.1")) 
	{ 
		response.setHeader("Cache-Control","no-cache"); 
	} 
	/*------------------------- 끝----------------------------*/ 
	
	int nPrilen=0, nCertlen=0, nRet;
	InputStream inPri=null;
	InputStream inCert=null;
	
	//OutputStream out=null;
	byte[] Prifilebuf;
	byte[] Certfilebuf;
	
	
	Properties props = System.getProperties(); // get list of properties
	String file_separator = (String)(props.get("file.separator"));
	String current_dir = "";
	String CertPath = "";
	String Full_path = request.getRealPath(request.getServletPath());
	if (file_separator.equals("\\"))	
	{
		current_dir = Full_path.substring(0,Full_path.lastIndexOf("\\")+1);
		CertPath = current_dir + "\\Cert\\"; 
	}
	else								
	{
		current_dir = Full_path.substring(0,Full_path.lastIndexOf("/")+1);
		CertPath = current_dir + "/Cert/"; 
	}
	//current_dir = request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);
	String SignedData = "";  //전자서명값
	
	String sInput = "01:506-81-32479+02:(주)스마코+03:제조,도소매+04:경북 포항시 남구 연일읍 오천리 634-4번지+05:506-81-00017+06:포항종합제철(주)+07:제조,서비스,도소매,부동산+08:경북 포항시 남구 괴동동 1번지+10:10,790,420+11:1,079,042+12:2001-07-02+13:Cutting Fluid/Oil K MSDS DONG HO DAICOOL,200 L외+14:+15:+16:2001-07-02+30:";
	
	out.println("원문길이 : " + sInput.length()  + "< br>");
	
	try 
	{
		inPri =  new FileInputStream(new File(CertPath + "signPri.key"));
	}
	catch (FileNotFoundException e) 
	{
		out.println(e);
		return;
	}
	catch (IOException e) 
	{
		out.println(e);
		return;
	}
	
	try 
	{
		nPrilen=inPri.available();
		Prifilebuf=new byte[nPrilen];
		
		nRet=inPri.read(Prifilebuf);

		// 전자서명
		Signer signer = new Signer();

		/*
			GetSignedDataP1(byte[] 개인키,  // signPri.key 파일 자체를 담은 바이트배열
							int    개인키길이, 
							String 비밀번호, 
							byte[] 원문, 
							int    원문길이)
		*/
		
		nRet=signer.GetSignedDataP1(Prifilebuf, nPrilen, "88888888", sInput.getBytes(), sInput.getBytes().length);
		if (nRet != 0)
		{
			out.print("에러메시지 : " + signer.errmessage + "< br>");
			return;
		}

		out.println("전자서명 성공(PKCS#1)< br>");
		out.println("전자서명(바이너리) 길이 : " + signer.signedlen + "< br>");


		// 바이너리 테이타 base64인코딩

		Base64 CBase64 = new Base64();
							  //바이트 배열     //바이트 배열길이
		nRet = CBase64.Encode(signer.signedbuf, signer.signedlen);
		if(nRet==0) 
		{
			out.println("서명값 Base64 Encode 결과 : 성공< br>") ;
			SignedData = new String(CBase64.contentbuf);
			out.println("서명값 Base64 Decode 값 : " + SignedData + "< br>") ;
		}
		else
		{
			out.println("서명값 Base64 Decode 결과 : 실패< br>") ;
			out.println("에러내용 : " + signer.errmessage + "< br>");
			out.println("에러코드 : " + CBase64.errcode + "< br>");
		}
		
	}
	catch(IOException e1) 
	{
		out.println(e1); 
	}

% >

</font>
</pre>