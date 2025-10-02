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
import Logica.Producto;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SvEliminarProducto", urlPatterns = {"/SvEliminarProducto"})
public class SvEliminarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            ProductoDAO dao = new ProductoDAO();
            List<Producto> lista_productos = dao.obtenerProductos();
            
            request.setAttribute("lista_productos", lista_productos);
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al cargar productos");
        }
        
        request.getRequestDispatcher("EliminarProducto.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id_producto"));
            
            ProductoDAO dao = new ProductoDAO();
            boolean eliminado = dao.eliminarProducto(id);
            
            if(eliminado){
                request.setAttribute("mensaje", "✅ Producto eliminado correctamente");
            } else {
                request.setAttribute("mensaje", "❌ Error al eliminar el producto");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "❌ Error en los datos");
        }
        
        // Recargar la lista
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
