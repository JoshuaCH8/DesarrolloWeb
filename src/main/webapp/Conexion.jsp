<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/estilos-tienda.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Inicio</title>
    </head>
<body>
    
        <!-- Contenedor de menu PRODUCTOS-->
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
        <!<!-- Contenedor de menu CATEGORIAS -->
    <nav class="menu-botones-2">
        <!-- Botón con formulario (POST) -->
        
        <!-- Mostrar Productos -->
        <a href="SvMostrarCategorias" class="btn-boton">Mostrar Categorias</a>

        <!-- Enlace (GET) -->
        <a href="AgregarCategoria.jsp" class="btn-boton">Agregar Categoria</a>

        <!-- Otro enlace (GET) -->
        <a href="SvEditarCategoria" class="btn-boton">Editar Categoria</a>

        <!-- Otro botón con POST ES UN HREF-->
        <a href="SvEliminarCategoria" class="btn-boton">Elminar Categoria</a>
    </nav>
        
    <br/>
    <br/>
    
    <div class="mision-vision">
        <div class="texto-cuadro">
            <h3>Misión</h3>
            <p>Proveer a nuestras familias y comunidad productos de primera necesidad con calidad, frescura y variedad, ofreciendo un servicio cercano, honesto y accesible. Nos comprometemos a ser un negocio de confianza que contribuye al bienestar de nuestros clientes y al desarrollo de la localidad.</p>
        </div>
    
        <div class="texto-cuadro">
            <h3>Visión</h3>
            <p>Ser la tienda de abarrotes preferida en la comunidad, reconocida por nuestra atención personalizada, surtido completo y precios justos. Buscamos innovar en servicios y mantenernos como un espacio cercano donde cada cliente se sienta como en casa.</p>
        </div>
    </div>

    
    <% 
    // Mostrar mensaje del resultado
    String mensaje = (String) request.getAttribute("mensaje"); %>
    <% if (mensaje != null) { %>
    <p style="color:blue;"><%= mensaje %></p>
    <% } %>
   
</body>
</html>
