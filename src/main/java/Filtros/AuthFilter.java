package Filtros;

import Logica.Usuario;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, 
                         FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // URLs públicas que no requieren autenticación
        if (path.startsWith("/Login.jsp") || 
            path.startsWith("/SvLogin") || 
            path.startsWith("/css/") || 
            path.startsWith("/img/") || 
            path.equals("/")) {
            
            chain.doFilter(request, response);
            return;
        }
        
        // Verificar autenticación
        if (session == null || session.getAttribute("usuario") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/Login.jsp");
            return;
        }
        
        // Verificar permisos según rol
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (!hasPermission(usuario, path)) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "No tiene permisos para acceder a este recurso");
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    private boolean hasPermission(Usuario usuario, String path) {
        String rol = usuario.getRol();
        
        // Admin tiene acceso completo
        if ("admin".equals(rol)) {
            return true;
        }
        
        // Editor no puede gestionar usuarios
        if ("editor".equals(rol) && path.contains("Usuario")) {
            return false;
        }
        
        // Visor solo puede ver
        if ("visor".equals(rol) && (path.contains("Agregar") || 
                                   path.contains("Editar") || 
                                   path.contains("Eliminar"))) {
            return false;
        }
        
        return true;
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    
    @Override
    public void destroy() {}
}