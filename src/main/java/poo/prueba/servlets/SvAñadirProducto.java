package poo.prueba.servlets;

import Logica.ProductoDAO;
import Logica.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvAñadirProducto", urlPatterns = {"/SvA_adirProducto"})
public class SvAñadirProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre_producto");
        Double precio = Double.parseDouble(request.getParameter("precio_producto"));

        Producto nuevo = new Producto(nombre, precio);
        ProductoDAO dao = new ProductoDAO();
        
        if(dao.insertarProducto(nuevo)){
            request.setAttribute("mensaje", "Producto añadido con éxito");
        }
        else{
            request.setAttribute("mensaje", "Error al añadir producto");
        }
        
        // Redirigir a jsp incial
        //request.setAttribute("mensaje", "Producto añadido con éxito");
        request.getRequestDispatcher("/Conexion.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
