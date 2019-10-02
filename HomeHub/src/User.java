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
	 * Servlet implementation class Password
	 */
	@WebServlet("/User")
	public class User extends HttpServlet {
		private static final long serialVersionUID = 1L;

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("in User doGet()...");
			Connection conn = null;
			Statement st = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			// extract info from headers
			String email = request.getParameter("email");
			try {
				// connect to database
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false");
				st = conn.createStatement();
				if (email == null) {
					System.out.println("Something went wrong...");
					return;
				}
				// get all rows that have matching email (should be at most one bc emails are unique)
                String sql = "SELECT * FROM Users WHERE email='" + email + "';";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                String registered = "false";
                String houseName = "null";
                // if there is a valid row, means user is already registered
                if (rs.next()) {
                    registered = "true";
                    houseName = rs.getString("houseName");
                }
                response.setHeader("registered", registered);
       response.setContentType("text/html;charset=UTF-8");

       response.getWriter().print(registered + "-" + houseName);

				System.out.println("User GET successful!");
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
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("in User doPost()...");
			Connection conn = null;
			Statement st = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			// extract info from headers
			String email = request.getHeader("email");
			String profilePic = request.getHeader("profilePic");
			String fullName = request.getHeader("fullName");
			String temp = request.getHeader("houseName");
			if (email == null || profilePic == null || fullName == null || temp == null) {
				System.out.println("Something went wrong...");
				return;
			}
			// remove spaces from house name because can't have table names with spaces
			String houseName = temp.replace(" ", "_");
			try {
				// connect to database
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false");
				st = conn.createStatement();
				// insert user information into database
				String sql = "INSERT INTO Users (email, profilePic, fullName, houseName) VALUES ('" 
						+ email + "', '" + profilePic + "', '" + fullName + "', '" + houseName + "');";
				st.executeUpdate(sql);
				System.out.println("User POST successful!");
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