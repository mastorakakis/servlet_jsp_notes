<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Servlet &amp; JSP Notes</title>
</head>

<body>
	<h1>Type: ${pageContext.exception["class"]}</h1>
	<h2>Message: ${pageContext.exception.message}</h2>
</body>
</html>