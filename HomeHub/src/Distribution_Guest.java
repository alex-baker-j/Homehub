import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Distribution
 */
@WebServlet("/Distribution_Guest")
public class Distribution_Guest extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Distribution_Guest() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String [] tasks = request.getParameterValues("tasks");
		for(int i = 0; i < tasks.length; i++){
			String underscore = tasks[i];
			String spaces = underscore.replace("_", " ");
			tasks[i] = spaces;
			System.out.println(tasks[i]);
		}
		
		String numberOfUsers = request.getParameter("numberOfUsers");
		System.out.println(numberOfUsers);
		
		Vector<Vector<String>> assigned = new Vector();
		int cnt = 0;
		for(int i = 0; i < Integer.valueOf(numberOfUsers); i++){
			Vector<String> pair = new Vector();
			assigned.add(pair);
		}
		while(cnt < tasks.length){
			for(int i=0; i < Integer.valueOf(numberOfUsers); i++){
				if(cnt < tasks.length){
					assigned.elementAt(i).add(tasks[cnt]);
				}
				else{
					break;
				}
				
				cnt += 1;
			}
		}
		
		for(int i = 0; i < assigned.size(); i++){
			for(int j = 0; j < assigned.elementAt(i).size(); j++){
				System.out.println(i + 1);
				System.out.println(assigned.elementAt(i).elementAt(j));
			}
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("assigned_vector", assigned);
		
		response.sendRedirect(request.getContextPath() + "/Guest_Result.jsp");
		
	}

}
