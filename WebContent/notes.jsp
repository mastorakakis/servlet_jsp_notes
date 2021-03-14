<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- import jar into  web-inf/lib -->

<!-- import class -->
<%@ page import = "classes.User" %>

<!-- declare instance variable -->
<%! private String instanceVariable; %>

<!-- Disable or enable EL for this page -->
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Servlet &amp; JSP Notes</title>
</head>

<body>
	&amp; = space <br>
	
	<!-- Relative to the current directory -->
	<a href="WEB-INF/views/other.jsp">other.jsp</a>	<br>
	<!-- Relative to the wepapps directory -->
	<a href="/servlet_jsp_notes/WEB-INF/views/other.jsp">other.jsp</a> <br>
	
	<a href="myServlet">My Servlet</a> <br>
	<a href="/servlet_jsp_notes/myServlet">My Servlet</a>
	
	<!-- Display exception -->
	Type: ${pageContext.exception["class"]}
	Message: ${pageContext.exception.message}
	
	<!-- JSTL -->
	<c:out value="${user.name}" /> <!-- escapes output -->
	<c:out value="${message }" default="No message" /> <!-- default message -->
	<c:out value="${message }">No message</c:out> <!-- default message -->
	<c:forEach var="cook" items="${cookie}"> <!-- c for each -->
		<c:out value="${cook.value.value}"></c:out>
	</c:forEach>
	<!-- java: productCodes = "8601, pf01, pf02" -->
	<!-- can have multiple delims -> -->
	<c:forTokens var="productCode" items="${productCodes}" delims=",">
		${productCode}
	</c:forTokens>
	<c:if test="${message == null}">
		<p>message null</p>
	</c:if>
	<!-- java: numbers [1 - 30] -->
	<c:forEach var="number" items="${numbers }" begin="0" end="9" step="1" varStatus="status">
		${number } | ${status.first} | #{status.last} | ${status.index} | ${status.count}
	</c:forEach>
	<c:choose>
		<c:when test="${user.age == 30}">
			<p>You are 30</p>
		</c:when>
		<c:when test="${user.age <= 30}">
			<p>You are less than 30</p>
		</c:when>
		<c:otherwise>
			You are older than 30
		</c:otherwise>
	</c:choose>
	<!-- encodes also session id in the url. can be changed in web.xml -->
	<a href="<c:url value='/test?pCode=1' />">Test Servlet</a> <!-- url relative to root-->
	<a href="<c:url value='/test?${pCode}' />">Test Servlet</a> 
	<a href="<c:url value='/test'>
				<c:param name='pCode' value='${product.code}' />
			 </c:url>">
		Test Servlet
	</a>
	<!-- other jstl tags page 289 -->
	
	<!-- Standard jsp tags -->
	<!-- scope: page, request, session, application -->
	<jsp:useBean id="user" scope="request" class="classes.User" /> <!-- get/create object -->
	<jsp:getProperty property="user" name="name"/>
	
	<!-- EL -->
	${user.name}
	${requestScope.user.name} <!--naming conflicts - pageScope, sessionScope, applicationScope -->
	${user["name"]} 	<!-- use of [] -->
	${colors[0]}		<!-- or ${colors["0"]} arrays, lists -->
	${users["1"].name}	<!-- mix of . and [] -->
	${item.product.code} <!-- or ${item["product"].code}nested properties -->
	<!-- email is an attribute and is evaluated as a key to retrieve an element and then the name -->
	${usersMap[email].name} <!-- ${usersMap["email"].name} will return empty string -->
	${userMaps[emails[0]].name} <!-- nested [] -->
	${param.name} <!-- get request parameter name -->
	${paramValues.email[0]} <!-- for multiple params with the same name -->
	${header.accept } <!-- get header -->
	${header["accept-encoding"]} <!-- for two words header -->
	${cookie.emailCookie.value} <!-- get cookie value -->
	${cookie.emailCookie.maxAge} <!-- get max age -->
	${initParam.customerServiceEmail} <!-- get context-param from web.xml -->
	${pageContext.request.method } <!-- = POST -->
	${pageContext.response.contentType } <!-- = text/html -->
	${pageContext.session.id} <!-- 4C1CF3.... -->
	${pageContext.servletContext.contextPath} <!-- /servlets_jsp_notes -->
	
	${3 + 2}	<!-- arithmetic operators -->
	${10 % 2 }	<!-- or ${10 mod 8} = 2 -->
	${1 != 1}	<!-- or ${1 ne 1} = false -->
	${1 > 2}	<!-- or ${1 gt 2} = false, ${1 lt 2} = true -->
	${1 >= 2}	<!-- or ${1 ge 2}, ${1 le 2} = true -->
	${user.name == null} <!-- other words: true, false -->
	${isDirty == true} <!-- false if isDirty is false or null -->
	<!-- == eq / ! not / && and / || or -->
	${empty user.name} <!-- true if name is null or "" -->
	${1 > 2 ? "s1" : "s2"} <!-- returns s1 -->
	
	<!-- includes -->
	<!-- Can import from other apps and web server also - run time-->
	<c:import url="/WEB-INF/views/includes/header.jsp" /> 
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>	<!-- compile time -->
	<jsp:include page="/WEB-INF/views/includes/header.jsp" /> 	<!-- run time -->
	
	<!-- Cookies -->
	<c:forEach var="c" items="${cookie}"><!-- cookie object maps all cookies sent from browser -->
		${c.value.name} <!-- get name -->
		${c.value.value} <!-- get value -->
	</c:forEach>
	${cookie.emailCookie.value } <!-- get value -->
	
	<!-- custom jsp tags. chapter 10 -->
	
</body>
</html>