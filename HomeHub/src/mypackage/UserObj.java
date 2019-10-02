package mypackage;
import java.util.List;
public class UserObj {
    public String name;
    public String email;
    
    public List<String> NextWeek;
    public List<String> ThisWeek;
    public List<String> Completed;
    public UserObj(String name, String email, List<String> NextWeek, List<String> ThisWeek, List<String> Completed)
    {
        
        this.name = name;
        this.email = email;
        this.NextWeek = NextWeek;
        this.ThisWeek = ThisWeek;
        this.Completed = Completed;
    }
    
    public String toString()
    {
        return name + "/" + email + "/" + NextWeek.toString() + "/" +  ThisWeek.toString() + "/" + Completed.toString();
    }
    
    
}