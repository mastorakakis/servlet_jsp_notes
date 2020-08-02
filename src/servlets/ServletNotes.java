package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/* 		Annotation mapping 		*/
//@WebServlet("/otherServlet")
//@WebServlet(urlPatterns = {"/other", "/otherServlet"})
//@WebServlet(name = "OtherServlet", urlPatterns = {"/otherServlet"})
//@WebServlet(urlPatterns = {"/otherServlet"}, 
				//initParams = {@InitParam(name = "age", value = "20")})
public class ServletNotes extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = "Panos";
		
		/* Request */
		String theName = request.getParameter("name"); // get parameters
		String[] names = request.getParameterValues("names");

		System.out.println(request.getContextPath()); // get context path

		request.setAttribute("name", name); // set-get attribute
		String attribute = (String) request.getAttribute("name");
		
		/* 		HttpSession 	*/
		HttpSession session = request.getSession(); // get session
		session.setAttribute("product", "productObject"); // set attribute
		String product = (String) session.getAttribute("product"); // get attribute
		session.removeAttribute("product");	// remove attribute
		Enumeration theNames = session.getAttributeNames(); // get names of all attributes
		while (theNames.hasMoreElements()) { 
			System.out.println((String) theNames.nextElement());
		}
		String id = session.getId(); // get session id
		session.setMaxInactiveInterval(60 * 60 * 24); // set interval for one day
		session.setMaxInactiveInterval(-1); // until browser is closed
		session.invalidate(); // delete session
		final Object lock = session.getId().intern(); // sync session
		synchronized (lock) {
			session.setAttribute("name", "theName");
		}

		/* ServletContext */
		ServletContext sc = getServletContext(); // get servlet context
		String path = sc.getRealPath("/index.jsp"); // get real path
		RequestDispatcher rd = sc.getRequestDispatcher("/other.jsp"); // get request dispatcher
		rd.forward(request, response); // forward
		String country = sc.getInitParameter("country");

		/* ServletConfig */
		ServletConfig scn = getServletConfig();
		String color = scn.getInitParameter("color");

		/* Response */
		// send redirect
		response.sendRedirect("/servlet_jsp_notes/other.jsp");	// relative to servlet engine
		response.sendRedirect("other.jsp");		// relative to current directory
		response.sendRedirect("http://www.sport24.gr");
		
		PrintWriter out = response. getWriter();	// PrintWriter
		try {
			out.println("My servlet");	
		} finally {
			out.close();
		}
		
		/* 		Cookies  	*/
		Cookie c = new Cookie("userCookie", "userId");
		// set age 2 years, -1 for per-session cookie, 0 delete
		c.setMaxAge(60 * 60 * 24 * 365 * 2);
		c.setPath("/");		// access by entire app
		c.setPath("/servlets");
		c.setDomain(".servlets_jsp_notes");
		c.setSecure(true);		// true send only over secure encrypted connection
		response.addCookie(c);
		Cookie[] cookies = request.getCookies();	// get cookies
		for (Cookie cookie : cookies) {
			String cookieValue;
			if (cookie.getName().equals("userCookie"))
				cookieValue = cookie.getValue();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}
