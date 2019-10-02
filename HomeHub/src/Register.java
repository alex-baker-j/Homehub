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
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * Returns a list of the current households
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("in Register doGet()...");
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// connect to database
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false");
			st = conn.createStatement();
			// query database for events of specified user
			String sql = "SELECT table_name FROM information_schema.tables WHERE table_schema='HomeHub';";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			String households = "";
			while (rs.next()) {
				String name = rs.getString("table_name");
				if (!name.equals("Users") && !name.equals("Tasks")) {
					households += name + ",";
				}
			}
			response.setHeader("households", households);
			System.out.println("Register GET successful!");
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
	 * Recieves a housename and type of post request (create or join)
	 *  - if create, also need to supply length of households
	 *  - if join, need to specific email of user joining household
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("in Register doPost()...");
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// extract info from headers
		String temp = request.getHeader("name");
		String type = request.getHeader("type");
		if (temp == null || type == null) {
			System.out.println("Something went wrong...");
			return;
		}
		String name = temp.replace(" ", "_");
		try {
			// connect to database
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false");
			st = conn.createStatement();
			// query database for events of specified user
			String sql = "";
			if (type.equals("create")) {
				sql = "CREATE TABLE " + name + " (" + 
						"email VARCHAR(50) PRIMARY KEY," + 
						"currTask VARCHAR(100)," + 
						"nextTask VARCHAR(100));";
			} else if (type.equals("join")) {
				String email = request.getHeader("email");
				if (email == null) {
					System.out.println("email header not found...");
					return;
				}
				sql = "INSERT INTO " + name + " (email) VALUES ('" + email + "');";
			}
			System.out.println(sql);
			st.executeUpdate(sql);
			System.out.println("Register POST successful!");
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
