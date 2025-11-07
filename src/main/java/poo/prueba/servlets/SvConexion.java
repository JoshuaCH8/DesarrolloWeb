package poo.prueba.servlets;

import Logica.ConexionDB;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvConexion", urlPatterns = {"/SvConexion"})
public class SvConexion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Mostrar el formulario vacío cuando se accede por GET
        RequestDispatcher dispatcher = request.getRequestDispatcher("Conexion.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mensaje;
        Connection conexion = null;

        try {
            // CAMBIO: Usar el método static getConnection()
            conexion = ConexionDB.getConnection();

            if (conexion != null && !conexion.isClosed()) {
                mensaje = "Conexión exitosa a la base de datos.";
            } else {
                mensaje = "Error: No se pudo establecer la conexión.";
            }

        } catch (SQLException e) {
            mensaje = "Error en la conexión: " + e.getMessage();
            e.printStackTrace();
        } finally {
            // Cerrar la conexión si se abrió
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Pasando los datos al JSP
        request.setAttribute("resultadoConexion", mensaje);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Conexion.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
