<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Pagina Inicial</title>
</head>
<body>
    <h1>ABARROTES LA HACIENDA</h1>
    <h3>Mision.</h3><br />
    <P>Proveer a nuestras familias y comunidad productos de primera necesidad con calidad, frescura y variedad, ofreciendo un servicio cercano, honesto y accesible. Nos comprometemos a ser un negocio de confianza que contribuye al bienestar de nuestros clientes y al desarrollo de la localidad.</P><br />
    <h3>Vision.</h3>
    <p>Ser la tienda de abarrotes preferida en la comunidad, reconocida por nuestra atención personalizada, surtido completo y precios justos. Buscamos innovar en servicios y mantenernos como un espacio cercano donde cada cliente se sienta como en casa.</p><br />
    <h1>Prueba de conexión con MySQL</h1>
    <form action="SvConexion" method="POST">
        <button type="submit">Conectar</button>
    </form>
    
    <%
    // Mostrar el resultado de la conexión (Exito o Error en la conecion.)
    String resultadoConexion = (String) request.getAttribute("resultadoConexion");
    if (resultadoConexion != null && !resultadoConexion.isEmpty()) {
    %>
        <p><%= resultadoConexion %></p>
    <%
        }
    %>
    
    <h4>Nuevo Producto</h4>
    <a href="AñadirProducto.jsp">
        <button type="button">Abrir</button>
    </a>
    
    <% 
    // Mostrar mensaje del resultado
    String mensaje = (String) request.getAttribute("mensaje"); %>
    <% if (mensaje != null) { %>
    <p style="color:blue;"><%= mensaje %></p>
    <% } %>

    
    <h4>Eliminar Producto</h4>
    <a href="SvEliminarProducto">
        <button type="button">Abrir</button>
    </a>
    
    
    <h4>Editar Producto</h4>
    <a href="EditarProducto.jsp">
        <button type="button">Abrir</button>
    </a>

</body>
</html>
