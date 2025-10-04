package poo.prueba.servlets;

import Logica.Categoria;
import Logica.CategoriaDAO;
import Logica.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvEliminarCategoria", urlPatterns = {"/SvEliminarCategoria"})
public class SvEliminarCategoria extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            CategoriaDAO cDao = new CategoriaDAO();
            List<Categoria> lista_categorias = cDao.obtenerCategorias();
            
            request.setAttribute("lista_categorias", lista_categorias);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al cargar categorias");
        }
        
        request.getRequestDispatcher("EliminarCategoria.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id_categoria"));
            
            CategoriaDAO cDao = new CategoriaDAO();
            boolean eliminado = cDao.eliminarCategoria(id);
            
            if(eliminado){
                request.setAttribute("mensaje", "Categoria eliminada correctamente");
            } else {
                request.setAttribute("mensaje", "Error al eliminar la categoria");
            }
        
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error en los datos");
        }
        
        // Recargar lista
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
