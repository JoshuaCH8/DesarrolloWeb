package Logica;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    
    // Método para generar código de barras automático
    public String generarNuevoCodigoBarras() {
        String codigo = "";
        try (Connection conn = new ConexionDB().getConexion()) {
            // Obtener el próximo ID disponible
            String sql = "SELECT COALESCE(MAX(id_producto), 0) + 1 as proximo_id FROM productos";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            int proximoId = 1;
            if (rs.next()) {
                proximoId = rs.getInt("proximo_id");
            }
            
            // Generar código con formato PROD000001
            codigo = String.format("PROD%06d", proximoId);
            
            // Verificar que no exista
            if (existeCodigoBarras(codigo)) {
                // Si existe, intentar con el siguiente
                codigo = String.format("PROD%06d", proximoId + 1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            // En caso de error, generar código con timestamp
            codigo = "PROD" + System.currentTimeMillis();
        }
        return codigo;
    }
    
    private boolean existeCodigoBarras(String codigo) throws SQLException {
        String sql = "SELECT COUNT(*) as count FROM productos WHERE codigo_barras = ?";
        try (Connection conn = new ConexionDB().getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, codigo);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            return false;
        }
    }
    
    // INSERTAR producto con todos los campos
    public boolean insertarProducto(Producto producto) {
        boolean insertado = false;
        String sql = "INSERT INTO productos (nombre_producto, precio_producto, cantidad_producto, " +
                    "codigo_barras, categoria_id, descripcion, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new ConexionDB().getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, producto.getNombreProducto());
            ps.setBigDecimal(2, producto.getPrecioProducto());
            ps.setInt(3, producto.getCantidadProducto());
            ps.setString(4, producto.getCodigoBarras());
            ps.setInt(5, producto.getCategoriaId());
            ps.setString(6, producto.getDescripcion());
            ps.setInt(7, producto.getEstado());
            
            int rows = ps.executeUpdate();
            insertado = rows > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return insertado;
    }
    
    // ELIMINAR producto (eliminación lógica)
    public boolean eliminarProducto(int idProducto) {
        String sql = "UPDATE productos SET estado = 0 WHERE id_producto = ?";
        
        try (Connection conn = new ConexionDB().getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idProducto);
            int filas = ps.executeUpdate();
            return filas > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean modificarProducto(Producto producto) {
        String sql = "UPDATE productos SET nombre_producto = ?, precio_producto = ?, " +
                "cantidad_producto = ?, categoria_id = ?, descripcion = ? " +
                "WHERE id_producto = ?";
    
        try (Connection conn = new ConexionDB().getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        
            ps.setString(1, producto.getNombreProducto());
            ps.setBigDecimal(2, producto.getPrecioProducto());
            ps.setInt(3, producto.getCantidadProducto());
            ps.setInt(4, producto.getCategoriaId());
            ps.setString(5, producto.getDescripcion());
            ps.setInt(6, producto.getIdProducto());
        
            int filas = ps.executeUpdate();
            return filas > 0;
        
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // OBTENER todos los productos activos
    public List<Producto> obtenerProductos() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE estado = 1 ORDER BY id_producto";
        
        try (Connection conn = new ConexionDB().getConexion();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setNombreProducto(rs.getString("nombre_producto"));
                producto.setPrecioProducto(rs.getBigDecimal("precio_producto"));
                producto.setCantidadProducto(rs.getInt("cantidad_producto"));
                producto.setCodigoBarras(rs.getString("codigo_barras"));
                producto.setCategoriaId(rs.getInt("categoria_id"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setFechaCreacion(rs.getString("fecha_creacion"));
                producto.setFechaActualizacion(rs.getString("fecha_actualizacion"));
                producto.setEstado(rs.getInt("estado"));
                
                productos.add(producto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productos;
    }
    
    // OBTENER producto por ID
    public Producto obtenerProductoPorId(int idProducto) {
        Producto producto = null;
        String sql = "SELECT * FROM productos WHERE id_producto = ? AND estado = 1";
    
        try (Connection conn = new ConexionDB().getConexion();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
            ps.setInt(1, idProducto);
            ResultSet rs = ps.executeQuery();
        
            if (rs.next()) {
                producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setNombreProducto(rs.getString("nombre_producto"));
                producto.setPrecioProducto(rs.getBigDecimal("precio_producto"));
                producto.setCantidadProducto(rs.getInt("cantidad_producto"));
                producto.setCodigoBarras(rs.getString("codigo_barras"));
                producto.setCategoriaId(rs.getInt("categoria_id"));
                producto.setDescripcion(rs.getString("descripcion"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return producto;
    }
    
    // OBTENER categorías (necesario para el formulario)
    public List<Categoria> obtenerCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM categorias WHERE estado = 1 ORDER BY nombre_categoria";
        
        try (Connection conn = new ConexionDB().getConexion();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria"));
                categoria.setNombreCategoria(rs.getString("nombre_categoria"));
                categoria.setDescripcion(rs.getString("descripcion"));
                categoria.setEstado(rs.getInt("estado"));
                
                categorias.add(categoria);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categorias;
    }
    
    // MÉTODO COMPATIBILIDAD (para no romper tu código existente)
    public ArrayList<String> mostrarProductos(Connection conexion) {
        ArrayList<String> lista_productos = new ArrayList<>();
        int listado = 1;
        try {
            Statement st = conexion.createStatement();
            ResultSet rs = st.executeQuery("SELECT id_producto, nombre_producto, precio_producto FROM productos WHERE estado = 1");

            while (rs.next()) {
                String producto = listado + ".- " + rs.getInt("id_producto") + 
                        " - " + rs.getString("nombre_producto") + 
                        " - $" + rs.getBigDecimal("precio_producto");
                lista_productos.add(producto);
                listado++;
            } 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista_productos;
    }
}