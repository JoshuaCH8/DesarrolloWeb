package poo.prueba.servlets;

import Logica.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Logica.ConexionDB;
import java.util.ArrayList;

@WebServlet(name = "SvEliminarProducto", urlPatterns = {"/SvEliminarProducto"})
public class SvEliminarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ConexionDB db = new ConexionDB();
            Connection conexion = db.getConexion();

            ProductoDAO dao = new ProductoDAO();
            ArrayList<String> lista_productos = dao.mostrarProductos(conexion);

            request.setAttribute("lista_productos", lista_productos);

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("EliminarProducto.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id_producto"));
        ProductoDAO dao = new ProductoDAO();
        
        if(dao.eliminarProducto(id)){
            request.setAttribute("mensaje", "Producto eliminado correctamente");
        } 
        else{
            request.setAttribute("mensaje", "Error al eliminar el producto");
        }
        
        // Redirigir de vuelta a inicio
        request.getRequestDispatcher("Conexion.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
