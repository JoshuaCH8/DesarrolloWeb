package poo.prueba.servlets;

import Logica.ConexionDB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Logica.ProductoDAO;
import java.sql.Connection;
import java.util.ArrayList;
import Logica.Producto;
import Logica.Categoria;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "SvEditarProducto", urlPatterns = {"/SvEditarProducto"})
public class SvEditarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    try{
        ProductoDAO dao = new ProductoDAO();
        List<Producto> lista_productos = dao.obtenerProductos();
        
        request.setAttribute("lista_productos", lista_productos);
    } catch(Exception e){
        e.printStackTrace();
        request.setAttribute("mensaje", "Error al cargar productos");
    }
    
    request.getRequestDispatcher("EditarProducto.jsp").forward(request, response);
}
    
    private void mostrarListaProductos(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            Connection conexion = ConexionDB.getConnection();
        
            ProductoDAO dao = new ProductoDAO();
            ArrayList<String> lista_productos = dao.mostrarProductos(conexion);
        
            request.setAttribute("lista_productos", lista_productos);
        
            // Cerrar conexión
            conexion.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    
        request.getRequestDispatcher("EditarProducto.jsp").forward(request, response);
    }
    
    private void cargarFormularioEdicion(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        
        ProductoDAO dao = new ProductoDAO();
        Producto producto = dao.obtenerProductoPorId(id);
        List<Categoria> categorias = dao.obtenerCategorias();
        
        if (producto != null) {
            request.setAttribute("producto", producto);
            request.setAttribute("categorias", categorias);
            request.getRequestDispatcher("formularioEditarProducto.jsp").forward(request, response);
        } else {
            request.setAttribute("mensaje", "Producto no encontrado");
            mostrarListaProductos(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("mensaje", "Error al cargar el producto");
        mostrarListaProductos(request, response);
    }
}

protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    try {
        // Obtener ID (único campo obligatorio)
        int id = Integer.parseInt(request.getParameter("id_producto"));
        
        ProductoDAO dao = new ProductoDAO();
        
        // Obtener producto actual de la base de datos
        Producto productoActual = dao.obtenerProductoPorId(id);
        
        if (productoActual == null) {
            request.setAttribute("mensaje", "Producto no encontrado con ID: " + id);
            doGet(request, response);
            return;
        }
        
        // Actualizar SOLO los campos que tienen valor (no vacíos y no cero)
        
        // Nombre
        String nuevoNombre = request.getParameter("nuevo_nombre_producto");
        if (nuevoNombre != null && !nuevoNombre.trim().isEmpty()) {
            productoActual.setNombreProducto(nuevoNombre.trim());
        }
        
        // Precio
        String precioStr = request.getParameter("nuevo_precio_producto");
        if (precioStr != null && !precioStr.trim().isEmpty()) {
            BigDecimal nuevoPrecio = new BigDecimal(precioStr);
            if (nuevoPrecio.compareTo(BigDecimal.ZERO) > 0) {
                productoActual.setPrecioProducto(nuevoPrecio);
            }
        }
        
        // Cantidad
        String cantidadStr = request.getParameter("nueva_cantidad_producto");
        if (cantidadStr != null && !cantidadStr.trim().isEmpty()) {
            int nuevaCantidad = Integer.parseInt(cantidadStr);
            if (nuevaCantidad > 0) {
                productoActual.setCantidadProducto(nuevaCantidad);
            }
        }
        
        // Categoría
        String categoriaStr = request.getParameter("nueva_categoria_id");
        if (categoriaStr != null && !categoriaStr.trim().isEmpty()) {
            int nuevaCategoriaId = Integer.parseInt(categoriaStr);
            if (nuevaCategoriaId > 0) {
                productoActual.setCategoriaId(nuevaCategoriaId);
            }
        }
        
        // Descripción
        String nuevaDescripcion = request.getParameter("nueva_descripcion");
        if (nuevaDescripcion != null && !nuevaDescripcion.trim().isEmpty()) {
            productoActual.setDescripcion(nuevaDescripcion.trim());
        }
        
        // Ejecutar actualización
        boolean actualizado = dao.modificarProducto(productoActual);
        
        if(actualizado){
            request.setAttribute("mensaje", "Producto modificado correctamente");
        } else {
            request.setAttribute("mensaje", "Error al modificar el producto");
        }
        
    } catch (NumberFormatException e) {
        e.printStackTrace();
        request.setAttribute("mensaje", "Error en el formato de los números");
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
