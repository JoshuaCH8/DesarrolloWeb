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
        <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
        <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
        <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>        
        <title>Modificar Categoria</title>

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

            <!-- Contenedor para React -->
            <div id="react-validation"></div>

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

                <form action="SvEditarCategoria" method="POST" class="form-simple" id="editarCategoriaForm" onsubmit="return false;">
                    <div class="form-group">
                        <label for="id_categoria" class="form-label">ID de la Categoría a modificar:</label>
                        <input type="number" name="id_categoria" id="id_categoria" class="form-input" required/>
                        <span id="id_categoria-error" class="validation-error"></span>
                    </div>

                    <div class="form-group">
                        <label for="nuevo_nombre_categoria" class="form-label">Nuevo nombre:</label>
                        <input type="text" name="nuevo_nombre_categoria" id="nuevo_nombre_categoria" class="form-input" placeholder="Ej: Bebidas Azucaradas"/>
                        <span id="nuevo_nombre_categoria-error" class="validation-error"></span>
                        <span class="campo-opcional">Dejar vacío para no cambiar</span>
                    </div>

                    <div class="form-group">
                        <label for="nueva_descripcion" class="form-label">Nueva descripción:</label>
                        <textarea name="nueva_descripcion" id="nueva_descripcion" class="form-textarea" placeholder="Ej: Bebidas altas en azúcares"></textarea>
                        <span id="nueva_descripcion-error" class="validation-error"></span>
                        <span class="campo-opcional">Dejar vacío para no cambiar</span>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-success" id="submitBtn">Modificar Categoría</button>
                        <a href="Conexion.jsp" class="btn">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Validación React -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("editarCategoriaForm");

                const validaciones = {
                    id_categoria: (valor) => {
                        if (!valor)
                            return "El ID de la categoría es obligatorio";
                        const id = parseInt(valor);
                        if (isNaN(id) || id <= 0)
                            return "El ID debe ser un número positivo";
                        return "";
                    },
                    nuevo_nombre_categoria: (valor) => {
                        if (valor && valor.trim() !== "") {
                            if (valor.length < 2)
                                return "El nombre debe tener al menos 2 caracteres";
                            if (valor.length > 100)
                                return "El nombre es demasiado largo";

                            // Solo letras, espacios, paréntesis o guiones
                            if (!/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s\-()]+$/.test(valor)) {
                                return "El nombre solo puede contener letras, espacios, paréntesis o guiones";
                            }
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
                    const errorSpan = document.getElementById(`${campoId}-error`);

                    // Actualiza estilos visuales
                    if (input) {
                        input.classList.remove("valid", "invalid");
                        if (error) {
                            input.classList.add("invalid");
                        } else if (valor && valor.toString().trim() !== "") {
                            input.classList.add("valid");
                        }
                    }

                    // Muestra el mensaje debajo del campo
                    if (errorSpan) {
                        errorSpan.textContent = error;
                        errorSpan.className = error ? "validation-error" : "validation-success";
                    }

                    return error;
                }

                function verificarCamposModificados() {
                    const nombre = document.getElementById("nuevo_nombre_categoria");
                    const descripcion = document.getElementById("nueva_descripcion");
                    return (
                            (nombre && nombre.value.trim() !== "") ||
                            (descripcion && descripcion.value.trim() !== "")
                            );
                }

                // Validar al escribir o salir del campo
                form.querySelectorAll("input, textarea").forEach((campo) => {
                    campo.addEventListener("input", (e) => validarCampo(e.target.id, e.target.value));
                    campo.addEventListener("blur", (e) => validarCampo(e.target.id, e.target.value));
                });

                // Validar al enviar
                form.addEventListener("submit", function (e) {
                    e.preventDefault();

                    let hayErrores = false;
                    const campos = ["id_categoria", "nuevo_nombre_categoria", "nueva_descripcion"];

                    campos.forEach((campoId) => {
                        const input = document.getElementById(campoId);
                        if (input) {
                            const error = validarCampo(campoId, input.value);
                            if (error)
                                hayErrores = true;
                        }
                    });

                    const camposModificados = verificarCamposModificados();
                    const idValido = !validaciones.id_categoria(
                            document.getElementById("id_categoria").value
                            );

                    if (!camposModificados) {
                        alert("Debes modificar al menos un campo además del ID de la categoría.");
                        return;
                    }

                    if (hayErrores) {
                        alert("Hay errores en el formulario. Corrígelos antes de enviar.");
                        return;
                    }

                    if (!idValido) {
                        alert("El ID no es válido.");
                        return;
                    }

                    // Todo correcto -> enviar formulario
                    form.submit();
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