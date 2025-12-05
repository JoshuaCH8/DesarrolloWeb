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

@WebServlet("/SvAgregarUsuario")
public class SvAgregarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nombreCompleto = request.getParameter("nombre_completo");
        String email = request.getParameter("email");
        String rol = request.getParameter("rol");

        UsuarioDAO usuarioDAO = new UsuarioDAO();

        try {
            // Verificar si el usuario ya existe (doble validación)
            if (usuarioDAO.existeUsername(username)) {
                request.setAttribute("mensaje", "Error: El usuario " + username + " ya existe");
                request.getRequestDispatcher("AgregarUsuario.jsp").forward(request, response);
                return;
            }

            // Crear usuario
            // ✅ CORRECTO: Hashear la contraseña que viene del formulario
            String passwordHash = PasswordUtil.hashPassword(password); // ← "password" no "contraseña123"
            Usuario usuario = new Usuario(username, passwordHash, email, nombreCompleto, rol);

            boolean creado = usuarioDAO.crearUsuario(usuario);

            if (creado) {
                request.setAttribute("mensaje", "Usuario creado exitosamente");
            } else {
                request.setAttribute("mensaje", "Error al crear el usuario");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error del sistema: " + e.getMessage());
        }

        request.getRequestDispatcher("AgregarUsuario.jsp").forward(request, response);
    }
}
