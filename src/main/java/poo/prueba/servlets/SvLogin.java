package poo.prueba.servlets;

import Logica.Usuario;
import Logica.UsuarioDAO;
import Logica.PasswordUtil;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SvLogin")
public class SvLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("=== INTENTO DE LOGIN ===");
        System.out.println("Usuario: " + username);
        System.out.println("Password: " + password);
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        try {
            Usuario usuario = usuarioDAO.obtenerPorUsername(username);
            System.out.println("Usuario encontrado en BD: " + (usuario != null));
            
            if (usuario != null && PasswordUtil.verifyPassword(username, password)) {
                // Login exitoso
                System.out.println("✅ LOGIN EXITOSO para: " + username);
                
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                session.setMaxInactiveInterval(30 * 60); // 30 minutos
                
                // Redirigir según rol
                switch (usuario.getRol()) {
                    case "admin":
                        response.sendRedirect("Conexion.jsp");
                        break;
                    case "editor":
                        response.sendRedirect("Conexion.jsp?mensaje=Bienvenido Editor");
                        break;
                    default:
                        response.sendRedirect("SvMostrarProductos");
                }
                
            } else {
                // Credenciales incorrectas
                System.out.println("❌ LOGIN FALLIDO para: " + username);
                
                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            System.err.println("❌ ERROR SQL en login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error del sistema: " + e.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cerrar sesión
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("Login.jsp");
    }
}