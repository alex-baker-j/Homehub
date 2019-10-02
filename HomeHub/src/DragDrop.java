import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.List;
//import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DragDrop
 */
@WebServlet("/DragDrop")
public class DragDrop extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DragDrop() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("CALLLLL");
		
		// TODO Auto-generated method stub
		String task = request.getParameter("task");
		String email = request.getParameter("email");
		//Access SQL database for relevant info
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		try {
			// connect to database
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false&UseLegacyDatetimeCode=false&serverTimezone=UTC&useSSL=false");
			
			//Get name of household
			String sql = "SELECT houseName FROM Users WHERE email = '" + email + "';";
			System.out.println(sql);

			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			System.out.println(sql);

			String house = rs.getString("houseName");
			String houseTasks = house + "_tasks";
			rs.close();

			System.out.println("1"+house+ houseTasks);
					if (task == "No Task!") return;
					sql = "SELECT completed FROM " + houseTasks + " WHERE taskDesc = '" + task + "';";
					System.out.print(sql);
					rs1 = st.executeQuery(sql);
					if (rs1.next()) {
					System.out.println("2"+task);
					response.setContentType("text/html;charset=UTF-8");
					response.setCharacterEncoding("UTF-8");
					if(rs1.getInt("completed") == 1) {
						ps = conn.prepareStatement("UPDATE " + houseTasks + " SET COMPLETED = 0 WHERE taskDesc = '" + task + "';");
						response.getWriter().write("uncompleted");
					}
					else
					{
						ps = conn.prepareStatement("UPDATE " + houseTasks + " SET COMPLETED = 1 WHERE taskDesc = '" + task + "';");
						response.getWriter().write("completed");
					}
					ps.executeUpdate();
					}
			
		} catch (SQLException sqle) {
			System.out.println("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("ClassNotFoundException: " + cnfe.getMessage());
		} 
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
