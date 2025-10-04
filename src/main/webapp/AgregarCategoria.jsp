<%-- 
    Document   : AgregarCategoria
    Created on : 2 oct. 2025, 20:11:40
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />    
        <title>Agregar Categoria</title>
    </head>
    <body>
        <div class="container">
            <h2>Agregar Nueva Categoría</h2>
            <p class="subtitle">Registre una nueva categoría para organizar los productos</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% }%>

            <form action="SvAgregarCategoria" method="POST" class="form-simple">
                <div class="form-group">
                    <label for="nombre_categoria" class="form-label">Nombre de la Categoría:</label>
                    <input type="text" name="nombre_categoria" id="nombre_categoria" class="form-input" required/>
                </div>

                <div class="form-group">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <textarea name="descripcion" id="descripcion" class="form-textarea"></textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">Agregar Categoría</button>
                    <a href="Conexion.jsp" class="btn">Cancelar</a>
                </div>
            </form>
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
