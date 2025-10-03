package poo.prueba.servlets;

import Logica.Categoria;
import Logica.CategoriaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvMostrarCategorias", urlPatterns = {"/SvMostrarCategorias"})
public class SvMostrarCategorias extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoriaDAO cDao = new CategoriaDAO();
        List<Categoria> lista_categorias = cDao.obtenerCategorias();
        
        request.setAttribute("lista_categorias", lista_categorias);
        
        request.getRequestDispatcher("MostrarCategorias.jsp").forward(request, response);        
        
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
