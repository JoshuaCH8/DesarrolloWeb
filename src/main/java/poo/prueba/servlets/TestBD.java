package poo.prueba.servlets;

import Logica.ConexionDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TestBD")
public class TestBD extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        
        try {
            String sql = "SELECT username, password_hash FROM usuarios WHERE username = 'tester'";
            Connection conn = ConexionDB.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            if (rs.next()) {
                out.println("✅ Usuario tester encontrado en BD");
                out.println("Hash: " + rs.getString("password_hash"));
            } else {
                out.println("❌ Usuario tester NO encontrado en BD");
            }
            
        } catch (Exception e) {
            out.println("🚨 Error: " + e.getMessage());
        }
    }
}