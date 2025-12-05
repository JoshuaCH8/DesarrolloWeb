<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.ConexionDB"%>
<%@page import = "java.sql.*" %>
<%@page import = "java.util.List" %>
<%@page import = "java.util.ArrayList" %>
<%@ page import="Logica.Producto" %>
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
        <title>Modificar Producto</title>

        <!-- React CDN -->
        <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
        <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
        <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

        <style>
            .validation-error {
                color: #dc3545;
                font-size: 12px;
                margin-top: 5px;
                display: block;
            }
            .validation-success {
                color: #28a745;
                font-size: 12px;
                margin-top: 5px;
                display: block;
            }
            .form-input.invalid {
                border-color: #dc3545;
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
            }
            .form-input.valid {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            }
            .form-textarea.invalid {
                border-color: #dc3545;
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
            }
            .form-textarea.valid {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            }
            .campo-opcional {
                font-size: 12px;
                color: #6c757d;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- INCLUIR NAVBAR -->
            <%@include file="navbar.jsp" %>
            <h2>Modificar Productos</h2>
            <p class="subtitle">Actualice la información de los productos existentes</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% } %>

            <!-- Contenedor para React -->
            <div id="react-validation"></div>

            <!-- Lista de productos para referencia -->
            <div style="margin-bottom: 30px;">
                <h3 style="color: #2c5530; margin-bottom: 15px;">Productos Disponibles (Referencia)</h3>
                <%
                    List<Producto> lista_productos = (List<Producto>) request.getAttribute("lista_productos");
                    if (lista_productos != null && !lista_productos.isEmpty()) {
                %>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>Código Barras</th>
                            <th>Categoría ID</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Producto producto : lista_productos) {
                        %>
                        <tr>
                            <td><%= producto.getIdProducto()%></td>
                            <td><strong><%= producto.getNombreProducto()%></strong></td>
                            <td>$<%= producto.getPrecioProducto()%></td>
                            <td><%= producto.getCantidadProducto()%></td>
                            <td><%= producto.getCodigoBarras()%></td>
                            <td><%= producto.getCategoriaId()%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <p class="no-data">No hay productos disponibles</p>
                <% }%>
            </div>

            <!-- Formulario de edición -->
            <div style="background: #f8f9fa; padding: 25px; border-radius: 8px; border: 1px solid #dee2e6;">
                <h3 style="color: #2c5530; margin-bottom: 20px; text-align: center;">Formulario de Modificación</h3>
                <form action="SvEditarProducto" method="POST" class="form-simple" id="editarProductoForm">

                    <div class="form-group">
                        <label for="id_producto" class="form-label">ID del producto a modificar:</label>
                        <input type="number" name="id_producto" id="id_producto" class="form-input" required />
                        <span id="id_producto-error" class="validation-error"></span>
                    </div>

                    <div class="form-group">
                        <label for="nuevo_nombre_producto" class="form-label">Nuevo nombre:</label>
                        <input type="text" name="nuevo_nombre_producto" id="nuevo_nombre_producto" class="form-input" placeholder="Ej: Coca Cola 2L"/>
                        <span id="nuevo_nombre_producto-error" class="validation-error"></span>
                        <span class="campo-opcional">Dejar vacío para no cambiar</span>
                    </div>

                    <div class="form-group">
                        <label for="nuevo_precio_producto" class="form-label">Nuevo precio:</label>
                        <input type="number" step="0.01" name="nuevo_precio_producto" id="nuevo_precio_producto" class="form-input" value="0"/>
                        <span id="nuevo_precio_producto-error" class="validation-error"></span>
                        <span class="campo-opcional">Dejar 0 para no cambiar</span>
                    </div>

                    <div class="form-group">
                        <label for="nueva_cantidad_producto" class="form-label">Nueva cantidad:</label>
                        <input type="number" name="nueva_cantidad_producto" id="nueva_cantidad_producto" class="form-input" value="0"/>
                        <span id="nueva_cantidad_producto-error" class="validation-error"></span>
                        <span class="campo-opcional">Dejar 0 para no cambiar</span>
                    </div>

                    <div class="form-group">
                        <label for="nueva_categoria_id" class="form-label">Nueva categoría ID:</label>
                        <input type="number" name="nueva_categoria_id" id="nueva_categoria_id" class="form-input" value="0"/>
                        <span id="nueva_categoria_id-error" class="validation-error"></span>
                        <span class="campo-opcional">Dejar 0 para no cambiar</span>
                    </div>

                    <div class="form-group">
                        <label for="nueva_descripcion" class="form-label">Nueva descripción:</label>
                        <textarea name="nueva_descripcion" id="nueva_descripcion" class="form-textarea" placeholder="Ej: Refresco de cola"></textarea>
                        <span id="nueva_descripcion-error" class="validation-error"></span>
                        <span class="campo-opcional">Dejar vacío para no cambiar</span>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-success" id="submitBtn">Modificar Producto</button>
                        <a href="Conexion.jsp" class="btn">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Validación React -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("editarProductoForm");

                const validaciones = {
                    id_producto: (valor) => {
                        if (!valor)
                            return "El ID del producto es obligatorio";
                        const id = parseInt(valor);
                        if (isNaN(id) || id <= 0)
                            return "El ID debe ser un número positivo";
                        return "";
                    },
                    nuevo_nombre_producto: (valor) => {
                        if (valor && valor.trim() !== "") {
                            if (valor.length < 2)
                                return "El nombre debe tener al menos 2 caracteres";
                            if (valor.length > 100)
                                return "El nombre es demasiado largo";
                            // ✅ Solo letras, espacios, paréntesis o guiones
                            if (!/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s\-()]+$/.test(valor)) {
                                return "El nombre solo puede contener letras, espacios, paréntesis o guiones";
                            }
                        }
                        return "";
                    },
                    nuevo_precio_producto: (valor) => {
                        const precio = parseFloat(valor);
                        if (precio !== 0) {
                            if (isNaN(precio))
                                return "El precio debe ser un número válido";
                            if (precio < 0)
                                return "El precio no puede ser negativo";
                            if (precio > 999999.99)
                                return "El precio es demasiado alto";
                        }
                        return "";
                    },
                    nueva_cantidad_producto: (valor) => {
                        const cantidad = parseInt(valor);
                        if (cantidad !== 0) {
                            if (isNaN(cantidad))
                                return "La cantidad debe ser un número válido";
                            if (cantidad < 0)
                                return "La cantidad no puede ser negativa";
                            if (cantidad > 99999)
                                return "La cantidad es demasiado alta";
                        }
                        return "";
                    },
                    nueva_categoria_id: (valor) => {
                        const categoria = parseInt(valor);
                        if (categoria !== 0) {
                            if (isNaN(categoria))
                                return "La categoría ID debe ser un número válido";
                            if (categoria <= 0)
                                return "La categoría ID debe ser positiva";
                        }
                        return "";
                    },
                    nueva_descripcion: (valor) => {
                        if (valor && valor.length > 500)
                            return "La descripción es demasiado larga (máx. 500 caracteres)";
                        return "";
                    }
                };

                function validarCampo(campoId, valor) {
                    const error = validaciones[campoId] ? validaciones[campoId](valor) : "";
                    const input = document.getElementById(campoId);

                    if (input) {
                        input.classList.remove("valid", "invalid");
                        if (error)
                            input.classList.add("invalid");
                        else if (valor && valor.toString().trim() !== "")
                            input.classList.add("valid");
                    }

                    return error;
                }

                function verificarCamposModificados() {
                    const campos = [
                        "nuevo_nombre_producto",
                        "nuevo_precio_producto",
                        "nueva_cantidad_producto",
                        "nueva_categoria_id",
                        "nueva_descripcion"
                    ];
                    return campos.some((id) => {
                        const campo = document.getElementById(id);
                        if (!campo)
                            return false;
                        const valor = campo.value.trim();
                        return valor !== "" && valor !== "0";
                    });
                }

                form.querySelectorAll("input, textarea").forEach((campo) => {
                    campo.addEventListener("input", (e) => validarCampo(e.target.id, e.target.value));
                    campo.addEventListener("blur", (e) => validarCampo(e.target.id, e.target.value));
                });

                form.addEventListener("submit", function (e) {
                    e.preventDefault();

                    let hayErrores = false;
                    const campos = [
                        "id_producto",
                        "nuevo_nombre_producto",
                        "nuevo_precio_producto",
                        "nueva_cantidad_producto",
                        "nueva_categoria_id",
                        "nueva_descripcion"
                    ];

                    for (const campoId of campos) {
                        const valor = document.getElementById(campoId).value;
                        const error = validarCampo(campoId, valor);
                        if (error) {
                            alert(error);
                            hayErrores = true;
                            return; // detener en el primer error
                        }
                    }
                    /*
                     if (!verificarCamposModificados()) {
                     alert("Debes modificar al menos un campo además del ID del producto.");
                     return;
                     }*/

                    if (!hayErrores) {
                        form.submit();
                    }
                });
            });
        </script>


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