<%-- 
    Document   : AñadirProducto
    Created on : 23 sep. 2025, 19:09:13
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Agregar Producto</title>
        <script>
            function generarCodigoBarras() {
                fetch('SvAgregarProducto?action=generarCodigo')
                    .then(response => response.text())
                    .then(codigo => {
                        document.getElementById('codigo_barras').value = codigo;
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Error al generar código de barras');
                    });
            }
        </script>
    </head>
    <body>
        <h2>Agregar Nuevo Producto</h2>
    
        <%
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
        %>
            <div style="color: <%= mensaje.contains("✅") ? "green" : "red" %>; margin: 10px 0;">
                <%= mensaje %>
            </div>
        <% } %>
    
        <form action="SvAgregarProducto" method="POST">
            <label for="nombre_producto">Nombre del producto:</label>
            <input type="text" name="nombre_producto" id="nombre_producto" required/>
            <br />
        
            <label for="precio_producto">Precio:</label>
            <input type="number" step="0.01" name="precio_producto" id="precio_producto" required/>
            <br />
        
            <label for="cantidad_producto">Cantidad inicial:</label>
            <input type="number" name="cantidad_producto" id="cantidad_producto" required/>
            <br />
        
            <label for="codigo_barras">Código de barras:</label>
            <div style="display: flex; gap: 10px;">
                <input type="text" name="codigo_barras" id="codigo_barras" readonly 
                   style="flex: 1; background: #f0f0f0;" required/>
                <button type="button" onclick="generarCodigoBarras()" 
                    style="background: #007bff; color: white; border: none; padding: 5px 10px; cursor: pointer;">
                Generar
                </button>
            </div>
            <br />
        
            <label for="categoria_id">Categoría ID:</label>
            <input type="number" name="categoria_id" id="categoria_id" required/>
            <br />
        
            <label for="descripcion">Descripción:</label>
            <textarea name="descripcion" id="descripcion"></textarea>
            <br />
        
            <button type="submit">Agregar Producto</button>
        </form>
    
        <br />
        
    </body>
</html>
