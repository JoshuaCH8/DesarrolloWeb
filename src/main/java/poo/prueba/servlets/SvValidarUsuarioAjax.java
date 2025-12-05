package poo.prueba.servlets;

import Logica.Producto;
import Logica.ProductoDAO;
import Logica.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SvValidarUsuarioAjax")
public class SvValidarUsuarioAjax extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");

        System.out.println("=== VALIDACIÓN USUARIO AJAX ===");
        System.out.println("Validando usuario: " + username);

        if (username == null || username.trim().isEmpty()) {
            response.getWriter().write("{\"valido\": false, \"mensaje\": \"Usuario requerido\"}");
            return;
        }

        UsuarioDAO usuarioDAO = new UsuarioDAO();

        try {
            boolean existe = usuarioDAO.existeUsername(username.trim());

            String json;
            if (existe) {
                json = "{\"valido\": false, \"mensaje\": \"Usuario ya existe\", \"clase\": \"error\"}";
                System.out.println("Usuario EXISTE: " + username);
            } else {
                json = "{\"valido\": true, \"mensaje\": \"Usuario disponible\", \"clase\": \"success\"}";
                System.out.println("Usuario DISPONIBLE: " + username);
            }

            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"valido\": false, \"mensaje\": \"Error del sistema\", \"clase\": \"error\"}");
        }
    }
}
