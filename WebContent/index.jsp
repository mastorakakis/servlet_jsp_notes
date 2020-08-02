<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Servlet &amp; JSP Notes</title>
</head>

<body>

	<h1>Servlet &amp; JSP Notes</h1>
	
	<a href="<c:url value = '/test' />">Test Servlet with jstl</a>
	
	${user.name }
</body>
</html>