
package Logica;

import com.sun.tools.javac.util.ArrayUtils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ConexionDB {
    private static final String URL = "jdbc:mysql://localhost:3306/tiendaDB";
    private static final String usuario = "root";
    private static final String password = "Bj8mysql8.";

    public Connection getConexion() {
        Connection conexion = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, usuario, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conexion;
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
