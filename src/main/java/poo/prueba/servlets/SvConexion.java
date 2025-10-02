
package poo.prueba.servlets;

import Logica.ConexionDB;
import java.io.IOException;
import java.sql.Connection;
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
        
        // Objeto que accede a metodo de clase java
        ConexionDB db = new ConexionDB();
        // Acceso a la conexion
        Connection conexion = db.getConexion();
        // Crear mensaje para JSP
        String mensaje;
        if (conexion != null) {
            mensaje = "Conexion exitosa.";
        } else {
            mensaje = "Error en la conexion.";
        }
    
        // Pasando los datos al JSP
        request.setAttribute("resultadoConexion", mensaje);
        //request.setAttribute("usuarioIngresado", usuario); // Para mantener el usuario en el formulario

        RequestDispatcher dispatcher = request.getRequestDispatcher("Conexion.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
