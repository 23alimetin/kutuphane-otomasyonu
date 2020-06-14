

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DB {

    private Connection conn = null;
    private Statement st = null;
    private String url = "jdbc:mysql://localhost/";
    private String dbName = "kutuphane?useUnicode=true&characterEncoding=UTF8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    private String userName = "root";
    private String pw = "1234567890";
    private String driver = "com.mysql.jdbc.Driver";
    
    public Statement baglan (){
        
        try {
            
            Class.forName(driver);
            conn = DriverManager.getConnection(url + dbName, userName, pw);
            st = conn.createStatement();
            
        } catch (Exception e) {
            
            System.err.println("Bağlanma Hatası: " + e);
            
        }
        
        return st;
        
    }
    
    public static void main(String[] args) {
        DB db = new DB();
        db.baglan();
    }
    

}
