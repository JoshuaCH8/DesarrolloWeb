<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Inicio</title>
        <link rel="icon" type="image/png" href="img/logo.png" />
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>ABARROTES LA HACIENDA</h1>
            </div>

            <!-- Menú de Productos -->
            <div class="menu-section">
                <h2>Gestión de Productos</h2>
                <div class="menu-buttons">
                    <a href="SvMostrarProductos" class="btn">Mostrar Productos</a>
                    <a href="AgregarProducto.jsp" class="btn">Agregar Producto</a>
                    <a href="SvEditarProducto" class="btn">Editar Producto</a>
                    <a href="SvEliminarProducto" class="btn btn-danger">Eliminar Producto</a>
                </div>
            </div>

            <!-- Menú de Categorías -->
            <div class="menu-section">
                <h2>Gestión de Categorías</h2>
                <div class="menu-buttons">
                    <a href="SvMostrarCategorias" class="btn">Mostrar Categorías</a>
                    <a href="AgregarCategoria.jsp" class="btn">Agregar Categoría</a>
                    <a href="SvEditarCategoria" class="btn">Editar Categoría</a>
                    <a href="SvEliminarCategoria" class="btn btn-danger">Eliminar Categoría</a>
                </div>
            </div>

            <!-- Misión y Visión -->
            <div class="mision-vision">
                <div class="text-box">
                    <h3>Misión</h3>
                    <p>Proveer a nuestras familias y comunidad productos de primera necesidad con calidad, frescura y variedad, ofreciendo un servicio cercano, honesto y accesible. Nos comprometemos a ser un negocio de confianza que contribuye al bienestar de nuestros clientes y al desarrollo de la localidad.</p>
                </div>

                <div class="text-box">
                    <h3>Visión</h3>
                    <p>Ser la tienda de abarrotes preferida en la comunidad, reconocida por nuestra atención personalizada, surtido completo y precios justos. Buscamos innovar en servicios y mantenernos como un espacio cercano donde cada cliente se sienta como en casa.</p>
                </div>
            </div>

            <!-- Mensajes del sistema -->
            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% }%>
        </div>

        <p>
            <a href="https://validator.w3.org/check?uri=referer"><img
                    src="https://www.w3.org/Icons/valid-xhtml11-blue" alt="Valid XHTML 1.1" height="31" width="88" /></a>
        </p>
        <p>
            <a href="https://jigsaw.w3.org/css-validator/check/referer">
                <img style="border:0;width:88px;height:31px"
                     src="https://jigsaw.w3.org/css-validator/images/vcss-blue"
                     alt="Valid CSS!" />
            </a>
        </p>

    </body>
</html>
