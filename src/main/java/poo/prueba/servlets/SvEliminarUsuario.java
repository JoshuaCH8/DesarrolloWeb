package poo.prueba.servlets;

import Logica.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SvEliminarUsuario")
public class SvEliminarUsuario extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        try {
            boolean eliminado = usuarioDAO.eliminarUsuario(idUsuario);
            if (eliminado) {
                response.sendRedirect("ListaUsuarios.jsp?mensaje=Usuario eliminado");
            } else {
                response.sendRedirect("ListaUsuarios.jsp?error=Error al eliminar");
            }
        } catch (Exception e) {
            response.sendRedirect("ListaUsuarios.jsp?error=" + e.getMessage());
        }
    }
}