package poo.prueba.servlets;

import Logica.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SvValidarUsuario")
public class SvValidarUsuario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (username == null || username.trim().isEmpty()) {
            response.getWriter().write("{\"disponible\": false, \"mensaje\": \"Usuario requerido\"}");
            return;
        }
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        try {
            boolean existe = usuarioDAO.existeUsername(username);
            
            if (!existe) {
                response.getWriter().write("{\"disponible\": true, \"mensaje\": \"Usuario disponible\"}");
            } else {
                response.getWriter().write("{\"disponible\": false, \"mensaje\": \"Usuario ya existe\"}");
            }
            
        } catch (SQLException e) {
            response.getWriter().write("{\"disponible\": false, \"mensaje\": \"Error del sistema\"}");
            e.printStackTrace();
        }
    }
}