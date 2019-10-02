
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Tasks
 */
@WebServlet("/Tasks")
public class Tasks extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Tasks() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("in Tasks doGet()...");
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// connect to database
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager
					.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false");
			st = conn.createStatement();
			String sql = "SELECT taskDesc FROM Tasks;";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			String tasks = "";
			while (rs.next()) {
				tasks += rs.getString("taskDesc") + ",";
			}
			response.setHeader("tasks", tasks);
			System.out.println("Task GET successful!");
		} catch (SQLException sqle) {
			System.out.println("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("ClassNotFoundException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("in Tasks doPost()...");
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// extract info from headers
		String tasks = request.getHeader("tasks");
		String temp = request.getHeader("household");
		if (tasks == null || temp == null) {
			System.out.println("Something went wrong...");
			return;
		}
		String name = temp.replace(" ", "_");
		String[] taskList = tasks.split(",");
		for (int i = 0; i < taskList.length; i++) {
			System.out.println(taskList[i]);
		}
		
		try {
			// connect to database
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false");
			st = conn.createStatement();
			// query database for events of specified user
			String table = "CREATE TABLE " + name + "_tasks (taskDesc VARCHAR(50), completed BIT);";
			String tasksql = "INSERT INTO " + name + "_tasks (taskDesc, completed) VALUES ";
			for (int i = 0; i < taskList.length; i++) {
				tasksql += "('" + taskList[i] + "', 0), ";
			}
			tasksql = tasksql.substring(0, tasksql.length()-2);  // -2 cuts of trailing ,
			tasksql += ";";
			System.out.println(table);
			System.out.println(tasksql);
			st.executeUpdate(table);
			st.executeUpdate(tasksql);
			System.out.println("Tasks POST successful!");
		} catch (SQLException sqle) {
			System.out.println("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("ClassNotFoundException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}

}
