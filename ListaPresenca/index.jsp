<%@ page contentType="text/html; charset=utf-8"%>
<%
if(session.getAttribute("isAuth") != null){
    response.sendRedirect("list.jsp");
}else{
	response.sendRedirect("login.jsp");
}
%>