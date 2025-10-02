package poo.prueba.servlets;

import Logica.ProductoDAO;
import Logica.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvAgregarProducto", urlPatterns = {"/SvAgregarProducto"})
public class SvAgregarProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
    
        if ("generarCodigo".equals(action)) {
            try {
                ProductoDAO dao = new ProductoDAO();
                String nuevoCodigo = dao.generarNuevoCodigoBarras();
            
                response.setContentType("text/plain");
                response.getWriter().write(nuevoCodigo);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(500, "Error al generar código");
            }
        return;
    }
    
    request.getRequestDispatcher("AgregarProducto.jsp").forward(request, response);
        
    }

protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    try {
        // PISTA: Obtener todos los parámetros del formulario
        String nombre = request.getParameter("nombre_producto");
        // PISTA: Para precio usar BigDecimal
        BigDecimal nuevoPrecio = new BigDecimal(request.getParameter("precio_producto"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad_producto"));
        String codigoBarras = request.getParameter("codigo_barras");
        int categoriaId = Integer.parseInt(request.getParameter("categoria_id"));
        String descripcion = request.getParameter("descripcion");
        
        // PISTA: Crear objeto Producto con todos los datos
        Producto producto = new Producto();
        producto.setNombreProducto(nombre);
        producto.setPrecioProducto(nuevoPrecio);
        producto.setCantidadProducto(cantidad);
        producto.setCodigoBarras(codigoBarras);
        producto.setCategoriaId(categoriaId);
        producto.setDescripcion(descripcion);
        // PISTA: El estado por defecto es 1 (activo)
        
        // PISTA: Llamar al DAO para insertar
        ProductoDAO dao = new ProductoDAO();
        boolean insertado = dao.insertarProducto(producto);
        
        if(insertado){
            request.setAttribute("mensaje", "✅ Producto agregado correctamente");
        } else {
            request.setAttribute("mensaje", "❌ Error al agregar el producto");
        }
        
    } catch (NumberFormatException e) {
        e.printStackTrace();
        request.setAttribute("mensaje", "❌ Error en el formato de los números");
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("mensaje", "❌ Error interno del servidor");
    }
    
    // PISTA: Redirigir al mismo JSP
    request.getRequestDispatcher("AgregarProducto.jsp").forward(request, response);
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
