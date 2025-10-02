package poo.prueba.servlets;

import Logica.Producto;
import Logica.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvMostrarProductos", urlPatterns = {"/SvMostrarProductos"})
public class SvMostrarProductos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductoDAO dao = new ProductoDAO();
        List<Producto> lista_productos = dao.obtenerProductos();
        
        request.setAttribute("lista_productos", lista_productos);
        
        request.getRequestDispatcher("MostrarProductos.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

}

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
