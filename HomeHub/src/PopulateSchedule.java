
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mypackage.UserObj;
/**
 * Servlet implementation class PopulateSchedule
 */
@WebServlet("/PopulateSchedule")
public class PopulateSchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Get current users email from request
		String originEmail = request.getParameter("email");
		System.out.println("email: " + originEmail);
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs1 = null;				
		//UserObj ThisUser =  null;
		ArrayList<UserObj> allUsers=null;
		try{
			// connect to database
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/HomeHub?user=root&password=password&useSSL=false&UseLegacyDatetimeCode=false&serverTimezone=UTC&useSSL=false");
			String s = "";

			//Get name of household
			String sql = "SELECT houseName FROM Users WHERE email = '" + originEmail + "';";
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			String house = rs.getString("houseName");
			String houseTasks = house + "_tasks";
			rs.close();
			System.out.println("0");

			//Get all users in the household by their emails and arrange them in a vector
			sql = "SELECT email FROM " + house + ";";
			System.out.println("house"+house);

			rs1 = st.executeQuery(sql);
			Vector<String> users = new Vector<String>();
			while(rs1.next()) {
				users.add(rs1.getString("email"));
			}
			System.out.println("size" + users.size());

			
			//Loop through each user and either pass specific object or add to array of objects
			allUsers = new ArrayList<UserObj>(); 
			for(int j=0; j<users.size(); j++) {
				System.out.println(users.get(j));
				//get the user's email and name 
				String email = users.get(j);
				System.out.println("1" +email);

				sql = "SELECT fullName FROM Users WHERE email = '" + email + "';";
				rs = st.executeQuery(sql);
				System.out.println("1");
				rs.next();
				String name = rs.getString("fullName");
				
				//Get the user's current tasks
								System.out.println("2");

				sql = "SELECT currTask FROM " + house + " WHERE email = '" + email + "';";
				rs1 = st.executeQuery(sql);
				rs1.next();
				String[] currTasks = rs1.getString("currTask").split(",");
				int length = currTasks.length;
				if (currTasks[currTasks.length-1].equals(" ")) length--;
				List<String> current = new LinkedList<String>(Arrays.asList(currTasks));
				List<String> completed = new ArrayList<String>();
				rs1.close();
				
				//Check if current tasks are completed
				for(int i=0; i<length; i++) {
					ResultSet rs2 = null;
					System.out.println("3" + length);

					sql = "SELECT completed FROM " + houseTasks + " WHERE taskDesc = '" + currTasks[i].trim() + "';";
					System.out.println(sql);
					System.out.println("3.." + currTasks[i]);

					rs2 = st.executeQuery(sql);
					rs2.next();
						System.out.println("5.." );
	
						if(rs2.getInt("completed") == 1) {
				
							current.remove(currTasks[i]);
							completed.add(currTasks[i]);
						}
					

					rs2.close();
				}
				
				//Get next weeks tasks
								System.out.println("4"+email);
	
				sql = "SELECT nextTask FROM " + house + " WHERE email ='" + email + "';";
				System.out.println("house"+house + email);

				rs1 = st.executeQuery(sql);
				rs1.next();
				String[] nextTasks = rs1.getString("nextTask").split(",");
				List<String> next = Arrays.asList(nextTasks);
				rs1.close();
				
				//Create user object
				UserObj newUser = new UserObj(name, email, next, current, completed);
				//If the user is the original user, pass the object on its own, else put in array of other users
				if(email.equals(originEmail)) {
					s = newUser.toString() + " * " + s;
				}
				else {
					allUsers.add(newUser);
					s += newUser.toString() + " * ";
			}
				
			}
			response.setContentType("text/html;charset=UTF-8");
			response.setCharacterEncoding("UTF-8");

      response.getWriter().write(s);  
      System.out.println(s);			
			
			
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