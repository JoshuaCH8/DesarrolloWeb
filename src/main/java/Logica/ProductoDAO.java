package Logica;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Logica.Producto;

public class ProductoDAO {
    
    public boolean insertarProducto(Producto producto) {
        boolean insertado = false;
        String sql = "INSERT INTO productos_prueba (nombre_producto_prueba, precio_producto_prueba) VALUES (?, ?)";

        try (Connection conn = new ConexionDB().getConexion();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, producto.getNombre());
            ps.setDouble(2, producto.getPrecio());
            
            int rows = ps.executeUpdate();
            insertado = rows > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return insertado;
    }
    
    public boolean eliminarProducto(int id_producto){
        boolean eliminado = false;
        String sql = "DELETE FROM productos_prueba WHERE id_producto_prueba = ?";
        
        try(Connection conn = new ConexionDB().getConexion();
            PreparedStatement ps = conn.prepareStatement(sql)){
            
            ps.setInt(1, id_producto);
            
            int filas = ps.executeUpdate();
            //System.out.println("Filas eliminadas: " + filas);
            
            //eliminado = (filas > 0);
            return filas > 0;
        } catch(Exception e) {
            e.printStackTrace();
            
            return false;
            
        }
    }
    
    public boolean modificarProducto(int id_producto, String nuevoNombre, double nuevoPrecio){
        String sql = "UPDATE productos_prueba SET nombre_producto_prueba = ?, precio_producto_prueba = ? WHERE id_producto_prueba = ?";
        
        try(Connection conn = new ConexionDB().getConexion();
                PreparedStatement ps = conn.prepareStatement(sql)){
            
            ps.setString(1, nuevoNombre);
            ps.setDouble(2, nuevoPrecio);
            ps.setInt(3, id_producto);
            
            int filas = ps.executeUpdate();
            return filas > 0; // Devuelve verdadero si se modifico al menos 1 fila
            
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
    
        public ArrayList<String> mostrarProductos(Connection conexion){
        ArrayList<String> lista_productos = new ArrayList<>();

        try{
            Statement st = conexion.createStatement();
            ResultSet rs = st.executeQuery("SELECT id_producto_prueba, nombre_producto_prueba, precio_producto_prueba FROM productos_prueba");
            
            while(rs.next()){
                String producto_prueba = rs.getInt("id_producto_prueba") + 
                        " - " + rs.getString("nombre_producto_prueba") + 
                        " - $" + rs.getDouble("precio_producto_prueba");
                lista_productos.add(producto_prueba);
            } 
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return lista_productos;
    }
}
