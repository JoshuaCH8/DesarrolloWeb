package Logica;

import java.sql.*;
import java.util.Properties;
import java.io.InputStream;

public class ConexionDB {
    private static Properties props = new Properties();
    
    static {
        try {
            System.out.println("=== INICIALIZANDO CONEXIÓN ===");
            
            // 1. Cargar configuración desde archivo
            InputStream input = ConexionDB.class.getClassLoader()
                .getResourceAsStream("config.properties");
            
            if (input == null) {
                System.err.println("❌ ERROR: No se encontró config.properties");
                System.err.println("❌ Asegúrate de que el archivo esté en: src/main/resources/");
                throw new RuntimeException("Archivo config.properties no encontrado");
            }
            
            props.load(input);
            System.out.println("✅ Configuración cargada correctamente");
            
            // 2. Mostrar info (sin password por seguridad)
            System.out.println("📋 Configuración BD:");
            System.out.println("   URL: " + props.getProperty("db.url"));
            System.out.println("   Usuario: " + props.getProperty("db.username"));
            System.out.println("   Driver: " + props.getProperty("db.driver"));
            
            // 3. Cargar driver
            Class.forName(props.getProperty("db.driver"));
            System.out.println("✅ Driver SQL Server cargado correctamente");
            
        } catch (Exception e) {
            System.err.println("❌ ERROR en inicialización: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Error configurando conexión a BD", e);
        }
    }
    
    public static Connection getConnection() throws SQLException {
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");
        
        System.out.println("🌐 Intentando conectar a Azure SQL...");
        System.out.println("   URL: " + url);
        
        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Conexión exitosa a Azure SQL Database");
            System.out.println("   Base de datos: " + conn.getCatalog());
            return conn;
            
        } catch (SQLException e) {
            System.err.println("❌ Error de conexión SQL: " + e.getMessage());
            System.err.println("   Código SQL: " + e.getErrorCode());
            System.err.println("   Estado SQL: " + e.getSQLState());
            throw e;
        }
    }
    
    // Método para probar la conexión
    public static void testConnection() {
        System.out.println("=== PRUEBA DE CONEXIÓN ===");
        try (Connection conn = getConnection()) {
            System.out.println("✅ Conexión TEST: OK");
        } catch (SQLException e) {
            System.err.println("❌ Conexión TEST: FALLÓ - " + e.getMessage());
        }
    }
}