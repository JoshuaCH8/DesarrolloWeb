package poo.prueba.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Logica.ProductoDAO;

@WebServlet(name = "SvEditarProducto", urlPatterns = {"/SvEditarProducto"})
public class SvEditarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        ProductoDAO dao = new ProductoDAO();
        request.setAttribute("lista_productos", dao.mostrarProductos(new Logica.ConexionDB().getConexion()));
        request.getRequestDispatcher("EditarProductos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        int id = Integer.parseInt(request.getParameter("id_producto"));
        String nuevoNombre = request.getParameter("nuevo_nombre_producto");
        double nuevoPrecio = Double.parseDouble(request.getParameter("nuevo_precio_producto"));
    
        ProductoDAO dao = new ProductoDAO();
        boolean actualizado = dao.modificarProducto(id, nuevoNombre, nuevoPrecio);
        
        if(actualizado){
            request.setAttribute("mensaje", "Producto modificado correctamente");
        }
        else {
            request.setAttribute("mensaje", "Error al modificar el producto");
        }
        
        request.getRequestDispatcher("Conexion.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
