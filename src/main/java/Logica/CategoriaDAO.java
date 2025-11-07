package Logica;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class CategoriaDAO {

    // INSERTAR categoria 
    public boolean insertarCategoria(Categoria categoria) throws SQLException {
        boolean insertado = false;
        String sql = "INSERT INTO categorias (nombre_categoria, descripcion) VALUES (?, ?)";

        // CAMBIO: Usar ConexionDB.getConnection() en lugar de new ConexionDB().getConexion()
        try ( Connection conn = ConexionDB.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, categoria.getNombreCategoria());
            ps.setString(2, categoria.getDescripcion());

            int rows = ps.executeUpdate();
            insertado = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return insertado;
    }

    // ELIMINAR categoria
    public boolean eliminarCategoria(int idCategoria) {
        String sql = "UPDATE categorias SET estado = 0 WHERE id_categoria = ?";

        // CAMBIO: Usar ConexionDB.getConnection()
        try ( Connection conn = ConexionDB.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCategoria);
            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // MODIFICAR categoria
    public boolean modificarCategoria(Categoria categoria) {
        String sql = "UPDATE categorias SET nombre_categoria = ?, descripcion = ? WHERE id_categoria = ?";

        // CAMBIO: Usar ConexionDB.getConnection()
        try ( Connection conn = ConexionDB.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, categoria.getNombreCategoria());
            ps.setString(2, categoria.getDescripcion());
            ps.setInt(3, categoria.getIdCategoria());

            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // OBTENER todas las categorias
    public List<Categoria> obtenerCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM categorias WHERE estado = 1 ORDER BY id_categoria";

        // CAMBIO: Usar ConexionDB.getConnection()
        try ( Connection conn = ConexionDB.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery(sql)) {

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

    // OBTENER categoria por ID
    public Categoria obtenerCategoriaPorId(int idCategoria) {
        Categoria categoria = null;
        String sql = "SELECT * FROM categorias WHERE id_categoria = ? AND estado = 1";

        // CAMBIO: Usar ConexionDB.getConnection()
        try ( Connection conn = ConexionDB.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCategoria);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria"));
                categoria.setNombreCategoria(rs.getString("nombre_categoria"));
                categoria.setDescripcion(rs.getString("descripcion"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoria;
    }

    // MÉTODO usado para SvEditar - CORREGIDO
    public ArrayList<String> mostrarCategorias() { // QUITAR el parámetro Connection
        ArrayList<String> lista_categorias = new ArrayList<>();
        int listado = 1;

        // CAMBIO: Usar ConexionDB.getConnection() y quitar el parámetro
        try ( Connection conexion = ConexionDB.getConnection();  Statement st = conexion.createStatement();  ResultSet rs = st.executeQuery("SELECT id_categoria, nombre_categoria, descripcion FROM categorias WHERE estado = 1")) {

            while (rs.next()) {
                // CORRECCIÓN: descripcion es String, no BigDecimal
                String categoria = listado + ".- " + rs.getInt("id_categoria")
                        + " - " + rs.getString("nombre_categoria")
                        + " - " + rs.getString("descripcion"); // CAMBIADO: getString en lugar de getBigDecimal
                lista_categorias.add(categoria);
                listado++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista_categorias;
    }
}
