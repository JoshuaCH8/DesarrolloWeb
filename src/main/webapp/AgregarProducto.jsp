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
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
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
        <div class="container">
            <h2>Agregar Nuevo Producto</h2>
            <p class="subtitle">Complete todos los campos para registrar un nuevo producto</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% }%>

            <form action="SvAgregarProducto" method="POST" class="form-simple">
                <div class="form-group">
                    <label for="nombre_producto" class="form-label">Nombre del producto:</label>
                    <input type="text" name="nombre_producto" id="nombre_producto" class="form-input" required/>
                </div>

                <div class="form-group">
                    <label for="precio_producto" class="form-label">Precio:</label>
                    <input type="number" step="0.01" name="precio_producto" id="precio_producto" class="form-input" required/>
                </div>

                <div class="form-group">
                    <label for="cantidad_producto" class="form-label">Cantidad inicial:</label>
                    <input type="number" name="cantidad_producto" id="cantidad_producto" class="form-input" required/>
                </div>

                <div class="form-group">
                    <label for="codigo_barras" class="form-label">Código de barras:</label>
                    <div class="input-group">
                        <input type="text" name="codigo_barras" id="codigo_barras" class="form-input" readonly required/>
                        <button type="button" onclick="generarCodigoBarras()" class="btn">
                            Generar
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <label for="categoria_id" class="form-label">Categoría ID:</label>
                    <input type="number" name="categoria_id" id="categoria_id" class="form-input" required/>
                </div>

                <div class="form-group">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <textarea name="descripcion" id="descripcion" class="form-textarea"></textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">Agregar Producto</button>
                    <a href="Conexion.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>
