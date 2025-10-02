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

    System.out.println("🚀 doGet de SvEditarProducto ejecutándose");
    
    try{
        ProductoDAO dao = new ProductoDAO();
        List<Producto> lista_productos = dao.obtenerProductos();
        
        System.out.println("📦 Productos obtenidos: " + (lista_productos != null ? lista_productos.size() : "NULL"));
        
        if(lista_productos != null) {
            for(Producto p : lista_productos) {
                System.out.println("Producto: " + p.getIdProducto() + " - " + p.getNombreProducto());
            }
        }
        
        request.setAttribute("lista_productos", lista_productos);
    } catch(Exception e){
        System.out.println("❌ Error en doGet: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("mensaje", "Error al cargar productos");
    }
    
    request.getRequestDispatcher("EditarProducto.jsp").forward(request, response);
    System.out.println("✅ Redirigiendo a EditarProducto.jsp");
}
    
    private void mostrarListaProductos(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            ConexionDB db = new ConexionDB();
            Connection conn = db.getConexion();
        
            ProductoDAO dao = new ProductoDAO();
            ArrayList<String> lista_productos = dao.mostrarProductos(conn);
        
            request.setAttribute("lista_productos", lista_productos);
        
            // Cerrar conexión
            conn.close();
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
        // 1. Obtener ID (único campo obligatorio)
        int id = Integer.parseInt(request.getParameter("id_producto"));
        
        ProductoDAO dao = new ProductoDAO();
        
        // 2. Obtener producto actual de la base de datos
        Producto productoActual = dao.obtenerProductoPorId(id);
        
        if (productoActual == null) {
            request.setAttribute("mensaje", "❌ Producto no encontrado con ID: " + id);
            doGet(request, response);
            return;
        }
        
        System.out.println("📝 Editando producto ID: " + id);
        System.out.println("Valores actuales: " + productoActual.getNombreProducto() + " - $" + productoActual.getPrecioProducto());
        
        // 3. Actualizar SOLO los campos que tienen valor (no vacíos y no cero)
        
        // Nombre
        String nuevoNombre = request.getParameter("nuevo_nombre_producto");
        if (nuevoNombre != null && !nuevoNombre.trim().isEmpty()) {
            System.out.println("🔄 Cambiando nombre a: " + nuevoNombre);
            productoActual.setNombreProducto(nuevoNombre.trim());
        }
        
        // Precio
        String precioStr = request.getParameter("nuevo_precio_producto");
        if (precioStr != null && !precioStr.trim().isEmpty()) {
            BigDecimal nuevoPrecio = new BigDecimal(precioStr);
            if (nuevoPrecio.compareTo(BigDecimal.ZERO) > 0) {
                System.out.println("🔄 Cambiando precio a: " + nuevoPrecio);
                productoActual.setPrecioProducto(nuevoPrecio);
            }
        }
        
        // Cantidad
        String cantidadStr = request.getParameter("nueva_cantidad_producto");
        if (cantidadStr != null && !cantidadStr.trim().isEmpty()) {
            int nuevaCantidad = Integer.parseInt(cantidadStr);
            if (nuevaCantidad > 0) {
                System.out.println("🔄 Cambiando cantidad a: " + nuevaCantidad);
                productoActual.setCantidadProducto(nuevaCantidad);
            }
        }
        
        // Categoría
        String categoriaStr = request.getParameter("nueva_categoria_id");
        if (categoriaStr != null && !categoriaStr.trim().isEmpty()) {
            int nuevaCategoriaId = Integer.parseInt(categoriaStr);
            if (nuevaCategoriaId > 0) {
                System.out.println("🔄 Cambiando categoría a: " + nuevaCategoriaId);
                productoActual.setCategoriaId(nuevaCategoriaId);
            }
        }
        
        // Descripción
        String nuevaDescripcion = request.getParameter("nueva_descripcion");
        if (nuevaDescripcion != null && !nuevaDescripcion.trim().isEmpty()) {
            System.out.println("🔄 Cambiando descripción");
            productoActual.setDescripcion(nuevaDescripcion.trim());
        }
        
        // 4. Ejecutar actualización
        boolean actualizado = dao.modificarProducto(productoActual);
        
        if(actualizado){
            request.setAttribute("mensaje", "✅ Producto modificado correctamente");
            System.out.println("✅ Producto actualizado en BD");
        } else {
            request.setAttribute("mensaje", "❌ Error al modificar el producto");
            System.out.println("❌ Error al actualizar producto");
        }
        
    } catch (NumberFormatException e) {
        e.printStackTrace();
        request.setAttribute("mensaje", "❌ Error en el formato de los números");
        System.out.println("❌ NumberFormatException: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("mensaje", "❌ Error interno del servidor");
        System.out.println("❌ Exception: " + e.getMessage());
    }
    
    // 5. Volver a cargar la lista
    doGet(request, response);
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
