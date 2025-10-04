<%-- 
    Document   : EditarCategoria
    Created on : 3 oct. 2025, 12:52:33
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.ConexionDB"%>
<%@page import = "java.sql.*" %>
<%@page import = "java.util.List" %>
<%@page import = "java.util.ArrayList" %>
<%@ page import="Logica.Categoria" %>
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
        <title>Modificar Categoria</title>
    </head>
    <body>
        <div class="container">
            <h2>Modificar Categorías</h2>
            <p class="subtitle">Actualice la información de las categorías existentes</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% } %>     

            <!-- Lista de categorías para referencia -->
            <div style="margin-bottom: 30px;">
                <h3 style="color: #2c5530; margin-bottom: 15px;">Categorías Disponibles (Referencia)</h3>
                <%
                    List<Categoria> lista_categorias = (List<Categoria>) request.getAttribute("lista_categorias");
                    if (lista_categorias != null && !lista_categorias.isEmpty()) {
                %> 
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Categoria categoria : lista_categorias) {
                        %>
                        <tr>
                            <td><%= categoria.getIdCategoria()%></td>
                            <td><strong><%= categoria.getNombreCategoria()%></strong></td>
                            <td><%= categoria.getDescripcion()%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <p class="no-data">No hay categorías disponibles</p>
                <% }%>  
            </div>

            <!-- Formulario de edición -->
            <div style="background: #f8f9fa; padding: 25px; border-radius: 8px; border: 1px solid #dee2e6;">
                <h3 style="color: #2c5530; margin-bottom: 20px; text-align: center;">Formulario de Modificación</h3>

                <form action="SvEditarCategoria" method="POST" class="form-simple">
                    <div class="form-group">
                        <label for="id_categoria" class="form-label">ID de la Categoría a modificar:</label>
                        <input type="number" name="id_categoria" id="id_categoria" class="form-input" required/>
                    </div>

                    <div class="form-group">
                        <label for="nuevo_nombre_categoria" class="form-label">Nuevo nombre (dejar vacío para no cambiar):</label>
                        <input type="text" name="nuevo_nombre_categoria" id="nuevo_nombre_categoria" class="form-input" placeholder="Ej: Bebidas Azucaradas"/>
                    </div>

                    <div class="form-group">
                        <label for="nueva_descripcion" class="form-label">Nueva descripción (dejar vacío para no cambiar):</label>
                        <textarea name="nueva_descripcion" id="nueva_descripcion" class="form-textarea" placeholder="Ej: Bebidas altas en azúcares"></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-success">Modificar Categoría</button>
                        <a href="Conexion.jsp" class="btn">Cancelar</a>
                    </div>
                </form>
            </div>
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
