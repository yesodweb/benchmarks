package test;

import java.io.*;

import javax.servlet.http.*;
import javax.servlet.*;

public class Pong extends HttpServlet {
  public void doGet (HttpServletRequest req,
                     HttpServletResponse res)
    throws ServletException, IOException
  {
    PrintWriter out = res.getWriter();

    out.println("PONG");
    out.close();
  }
}
