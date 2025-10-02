<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Inicio</title>
    </head>
<body>
    
        <!-- Contenedor de menú -->
    <nav class="menu-botones">
        <!-- Botón con formulario (POST) -->
        
        <!-- Mostrar Productos -->
        <a href="SvMostrarProductos" class="btn-boton">Mostrar Productos</a>

        <!-- Enlace (GET) -->
        <a href="AgregarProducto.jsp" class="btn-boton">Agregar Producto</a>

        <!-- Otro enlace (GET) -->
        <a href="SvEditarProducto" class="btn-boton">Editar Producto</a>

        <!-- Otro botón con POST ES UN HREF-->
        <a href="SvEliminarProducto" class="btn-boton">Elminar Producto</a>
    </nav>
    
    <br/>
    <br/>
    
    <h1>ABARROTES LA HACIENDA</h1>
    <h3>Mision.</h3><br />
    <P>Proveer a nuestras familias y comunidad productos de primera necesidad con calidad, frescura y variedad, ofreciendo un servicio cercano, honesto y accesible. Nos comprometemos a ser un negocio de confianza que contribuye al bienestar de nuestros clientes y al desarrollo de la localidad.</P><br />
    <h3>Vision.</h3>
    <p>Ser la tienda de abarrotes preferida en la comunidad, reconocida por nuestra atención personalizada, surtido completo y precios justos. Buscamos innovar en servicios y mantenernos como un espacio cercano donde cada cliente se sienta como en casa.</p><br />

    <%
    // YA NO SE NECESITA: Mostrar el resultado de la conexión (Exito o Error en la conecion.)
    String resultadoConexion = (String) request.getAttribute("resultadoConexion");
    if (resultadoConexion != null && !resultadoConexion.isEmpty()) {
    %>
        <p><%= resultadoConexion %></p>
    <%
        }
    %>
    
    <% 
    // Mostrar mensaje del resultado
    String mensaje = (String) request.getAttribute("mensaje"); %>
    <% if (mensaje != null) { %>
    <p style="color:blue;"><%= mensaje %></p>
    <% } %>

    <style>
        .menu-botones {
            display: flex;
            justify-content: right; /* Derechado horizontal */
            gap: 5px; /* Espacio entre botones */
            margin: 20px 0;
}

        .btn-boton,
        button.btn-boton {
            display: inline-block;
            padding: 10px 20px;
            background: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            text-align: center;
            font-family: inherit;
        }

        .btn-boton:hover,
        button.btn-boton:hover {
            background: #c82333;
        }

    </style>
</body>
</html>
