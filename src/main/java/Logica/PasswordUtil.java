package Logica;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    private static final Map<String, String> usuariosHardcodeados = new HashMap<>();

    static {
        usuariosHardcodeados.put("admin", "admin123");
        usuariosHardcodeados.put("editor", "editor123");
        usuariosHardcodeados.put("visor", "visor123");
    }

    public static boolean verifyPassword(String username, String password) {
        System.out.println("Verificando: " + username);

        // 1. BUSCAR EN BD REAL
        String hashBD = getHashFromRealDatabase(username);

        if (hashBD != null) {
            System.out.println("DEBUG: Hash completo de BD: " + hashBD);
            System.out.println("DEBUG: Longitud hash: " + hashBD.length());

            // 🔥 TEMPORAL: Si el hash NO es Bcrypt válido, aceptar login
            if (!isBCryptHash(hashBD)) {
                System.out.println("DEBUG: Hash NO es Bcrypt válido");
                System.out.println("DEBUG: Los hashes en BD parecen corruptos");
                System.out.println("DEBUG: Aceptando login temporalmente para arreglar BD");

                // TEMPORALMENTE: Verificar contra usuarios hardcodeados
                String passHardcodeado = usuariosHardcodeados.get(username);
                if (passHardcodeado != null && passHardcodeado.equals(password)) {
                    System.out.println("DEBUG: Password correcto (hardcodeado)");
                    return true;
                } else {
                    System.out.println("DEBUG: Password NO coincide con hardcodeado");
                    return false;
                }
            }

            // Si llegamos aquí, el hash SÍ es Bcrypt válido
            System.out.println("Encontrado en BD. Hash: " + hashBD.substring(0, 20) + "...");

            if (isBCryptHash(hashBD)) {
                boolean resultado = BCrypt.checkpw(password, hashBD);
                System.out.println("Resultado BCrypt: " + resultado);
                return resultado;
            } else {
                boolean resultado = hashBD.equals(password);
                System.out.println("Resultado texto plano: " + resultado);
                return resultado;
            }
        }

        // 2. BUSCAR EN HARCODEADOS (fallback)
        String hashHardcodeado = usuariosHardcodeados.get(username);
        if (hashHardcodeado != null) {
            System.out.println("Usando hardcodeado para: " + username);
            boolean resultado = hashHardcodeado.equals(password);
            System.out.println("Resultado hardcodeado: " + resultado);
            return resultado;
        }

        System.out.println("Usuario no encontrado en ningún lugar: " + username);
        return false;
    }

    private static String getHashFromRealDatabase(String username) {
        String sql = "SELECT password_hash FROM usuarios WHERE username = ?";

        try ( Connection conn = ConexionDB.getConnection();  PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            System.out.println("Buscando en BD: " + username);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String hash = rs.getString("password_hash");
                System.out.println("ENCONTRADO en BD: " + username);
                return hash;
            } else {
                System.out.println("NO encontrado en BD: " + username);
                return null;
            }

        } catch (SQLException e) {
            System.err.println("ERROR BD con usuario " + username + ": " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    private static boolean isBCryptHash(String hash) {
        if (hash == null) {
            return false;
        }
        boolean result = hash.startsWith("$2a$") || hash.startsWith("$2b$") || hash.startsWith("$2y$");
        System.out.println("¿Es BCrypt? " + result);
        return result;
    }

    public static void resetAllPasswords() {
        System.out.println("Reseteando TODAS las contraseñas...");

        String[][] usuarios = {
            {"admin", "admin123"},
            {"editor", "editor123"},
            {"visor", "visor123"}
        };

        try ( Connection conn = ConexionDB.getConnection()) {
            for (String[] usuario : usuarios) {
                String username = usuario[0];
                String password = usuario[1];
                String newHash = hashPassword(password);

                PreparedStatement pstmt = conn.prepareStatement(
                        "UPDATE usuarios SET password_hash = ? WHERE username = ?");
                pstmt.setString(1, newHash);
                pstmt.setString(2, username);
                pstmt.executeUpdate();

                System.out.println(username + " resetado con: " + password);
            }
            System.out.println("TODAS las contraseñas reseteadas correctamente");

        } catch (SQLException e) {
            System.err.println("Error resetando contraseñas: " + e.getMessage());
        }
    }
}
