package poo.prueba.servlets;

import Logica.Usuario;
import Logica.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SvEditarUsuario")
public class SvEditarUsuario extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String nombreCompleto = request.getParameter("nombreCompleto");
        String rol = request.getParameter("rol");
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        try {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(idUsuario);
            usuario.setUsername(username);
            usuario.setEmail(email);
            usuario.setNombreCompleto(nombreCompleto);
            usuario.setRol(rol);
            
            boolean actualizado = usuarioDAO.actualizarUsuario(usuario);
            if (actualizado) {
                response.sendRedirect("ListarUsuarios.jsp?mensaje=Usuario actualizado");
            } else {
                response.sendRedirect("ListarUsuarios.jsp?error=Error al actualizar");
            }
        } catch (Exception e) {
            response.sendRedirect("ListarUsuarios.jsp?error=" + e.getMessage());
        }
    }
}