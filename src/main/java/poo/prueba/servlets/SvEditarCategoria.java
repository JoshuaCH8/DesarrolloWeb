package poo.prueba.servlets;

import Logica.Categoria;
import Logica.CategoriaDAO;
import Logica.ConexionDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvEditarCategoria", urlPatterns = {"/SvEditarCategoria"})
public class SvEditarCategoria extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

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
        
        request.getRequestDispatcher("EditarCategoria.jsp").forward(request, response);
    }
    
    private void mostrarListaCategorias(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            ConexionDB db = new ConexionDB();
            Connection conn = db.getConexion();
        
            CategoriaDAO dao = new CategoriaDAO();
            ArrayList<String> lista_categorias = dao.mostrarCategorias(conn);
        
            request.setAttribute("lista_categorias", lista_categorias);
        
            // Cerrar conexión
            conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    
        request.getRequestDispatcher("EditarCategoriajsp").forward(request, response);
    }
    
    private void cargarFormularioEdicion(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
        
            CategoriaDAO dao = new CategoriaDAO();
            Categoria categoria = dao.obtenerCategoriaPorId(id);
            List<Categoria> categorias = dao.obtenerCategorias();
        
            if (categoria != null) {
                request.setAttribute("categoria", categoria);
                request.setAttribute("categorias", categorias);
                request.getRequestDispatcher("formularioEditarCategoria.jsp").forward(request, response);
            } else {
                request.setAttribute("mensaje", "Categoria no encontrado");
                mostrarListaCategorias(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error al cargar el categoria");
            mostrarListaCategorias(request, response);
        }
    }    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Obtener ID (único campo obligatorio)
            int id = Integer.parseInt(request.getParameter("id_categoria"));
            
            CategoriaDAO dao = new CategoriaDAO();
            
            Categoria categoriaActual = dao.obtenerCategoriaPorId(id);
            
            if(categoriaActual == null) {
                request.setAttribute("mensaje", "Categoria no encontrado con ID: " + id);
                doGet(request, response);
                return;            
            }
            
            // Actualizar SOLO los campos que tienen valor (no vacíos y no cero)
        
            // Nombre
            String nuevoNombre = request.getParameter("nuevo_nombre_categoria");
            if(nuevoNombre != null && !nuevoNombre.trim().isEmpty()) {
                categoriaActual.setNombreCategoria(nuevoNombre.trim());
            }
            
            // Descripción
            String nuevaDescripcion = request.getParameter("nueva_descripcion");
            if (nuevaDescripcion != null && !nuevaDescripcion.trim().isEmpty()) {
                categoriaActual.setDescripcion(nuevaDescripcion.trim());
            }
        
            // Ejecutar actualización
            boolean actualizado = dao.modificarCategoria(categoriaActual);            
        
            if(actualizado){
                request.setAttribute("mensaje", "Categoria modificada correctamente");
            } else {
                request.setAttribute("mensaje", "Error al modificar la categoria");
            }        
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error interno del servidor");
        }
        
        // Volver a cargar la lista
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
