package Logica;

import java.util.HashMap;
import java.util.Map;

public class PasswordUtil {
    private static final Map<String, String> passwordStore = new HashMap<>();
    
    static {
        // Contraseñas pre-hasheadas (en un caso real esto vendría de la BD)
        passwordStore.put("admin", "admin123");
        passwordStore.put("editor", "editor123"); 
        passwordStore.put("visor", "visor123");
    }
    
    public static boolean verifyPassword(String username, String password) {
        String storedPassword = passwordStore.get(username);
        return storedPassword != null && storedPassword.equals(password);
    }
    
    // Método dummy para mantener compatibilidad
    public static String hashPassword(String password) {
        return password; // En producción, esto debería ser un hash real
    }
}