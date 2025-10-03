package poo.prueba.servlets;

import Logica.Categoria;
import Logica.CategoriaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvAgregarCategoria", urlPatterns = {"/SvAgregarCategoria"})
public class SvAgregarCategoria extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener todos los parametros del formulario
        try {
            String nombre = request.getParameter("nombre_categoria");
            String descripcion = request.getParameter("descripcion");
            
            // Objeto Categoria para obtener parametros
            Categoria categoria = new Categoria();
            categoria.setNombreCategoria(nombre);
            categoria.setDescripcion(descripcion);
            
            // Llamar al dao
            CategoriaDAO cDao = new CategoriaDAO();
            boolean insertado = cDao.insertarCategoria(categoria);
            
            if(insertado) {
                request.setAttribute("mensaje", "Categoria agregada.");
            } else {
                request.setAttribute("mensaje", "Error al agregar categoria");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error interno del servidor");
        }
        
        // Redirifir al mismo JSP
        request.getRequestDispatcher("AgregarCategoria.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
