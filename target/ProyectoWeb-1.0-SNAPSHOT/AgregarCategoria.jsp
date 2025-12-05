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
        <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
        <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
        <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>        
        <title>Agregar Categoria</title>

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
        </style>
    </head>
    <body>
        <div class="container">
            <!-- INCLUIR NAVBAR -->
            <%@include file="navbar.jsp" %>
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

            <!-- Contenedor para React -->
            <div id="react-validation"></div>

            <form action="SvAgregarCategoria" method="POST" class="form-simple" id="categoriaForm">
                <div class="form-group">
                    <label for="nombre_categoria" class="form-label">Nombre de la Categoría:</label>
                    <input type="text" name="nombre_categoria" id="nombre_categoria" class="form-input" required/>
                    <span id="nombre_categoria-error" class="validation-error"></span>
                </div>

                <div class="form-group">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <textarea name="descripcion" id="descripcion" class="form-textarea"></textarea>
                    <span id="descripcion-error" class="validation-error"></span>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success" id="submitBtn">Agregar Categoría</button>
                    <a href="Conexion.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>

        <!-- Validación React -->
        <script type="text/babel">
            const {useState, useEffect} = React;

            function ValidacionEditarCategoria() {
                const [errores, setErrores] = useState({});
                const [formValido, setFormValido] = useState(false);
                const [intentoEnvio, setIntentoEnvio] = useState(false);

                const validaciones = {
                    id_categoria: (valor) => {
                        if (!valor)
                            return 'El ID de la categoría es obligatorio';
                        const id = parseInt(valor);
                        if (id <= 0)
                            return 'El ID debe ser un número positivo';
                        return '';
                    },
                    nuevo_nombre_categoria: (valor) => {
                        // Solo validar si el usuario escribió algo
                        if (valor && valor.trim() !== '') {
                            if (valor.length < 2)
                                return 'El nombre debe tener al menos 2 caracteres';
                            if (valor.length > 100)
                                return 'El nombre es demasiado largo';

                            // VALIDACIÓN DE FORMATO
                            if (!/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s0-9\-_&.,()]+$/.test(valor)) {
                                return 'El nombre solo puede contener letras, números, espacios y los caracteres: -_&.,()';
                            }

                            if (!/[a-zA-ZáéíóúÁÉÍÓÚñÑ]/.test(valor)) {
                                return 'El nombre debe contener al menos una letra';
                            }
                        }
                        return '';
                    },
                    nueva_descripcion: (valor) => {
                        // Solo validar si hay contenido
                        if (valor && valor.length > 500)
                            return 'La descripción es demasiado larga (max. 500 caracteres)';
                        return '';
                    }
                };

                const validarCampo = (campoId, valor) => {
                    const error = validaciones[campoId] ? validaciones[campoId](valor) : '';

                    setErrores(prev => ({...prev, [campoId]: error}));

                    const input = document.getElementById(campoId);
                    const errorSpan = document.getElementById(`${campoId}-error`);

                    if (input) {
                        input.classList.remove('valid', 'invalid');
                        if (error) {
                            input.classList.add('invalid');
                        } else if (valor && valor.toString().trim() !== '') {
                            input.classList.add('valid');
                        }
                    }

                    if (errorSpan) {
                        errorSpan.textContent = error;
                        errorSpan.className = error ? 'validation-error' : 'validation-success';
                    }
                };

                const validarFormularioCompleto = () => {
                    const idInput = document.getElementById('id_categoria');
                    const idValido = idInput && !validaciones.id_categoria(idInput.value);

                    // Verificar que al menos un campo opcional esté modificado
                    const nombreInput = document.getElementById('nuevo_nombre_categoria');
                    const descInput = document.getElementById('nueva_descripcion');
                    const camposModificados = (nombreInput && nombreInput.value.trim() !== '') ||
                            (descInput && descInput.value.trim() !== '');

                    const sinErrores = Object.values(errores).every(error => error === '');

                    const esValido = idValido && camposModificados && sinErrores;
                    setFormValido(esValido);
                    return esValido;
                };

                const manejarEnvioFormulario = (e) => {
                    e.preventDefault();

                    const esValido = validarFormularioCompleto();
                    setIntentoEnvio(true);

                    if (esValido) {
                        const form = document.getElementById('editarCategoriaForm');
                        form.submit();
                    }
                };

                useEffect(() => {
                    const form = document.getElementById('editarCategoriaForm');

                    if (form) {
                        form.addEventListener('submit', manejarEnvioFormulario);
                    }

                    // Event listeners para validación en tiempo real
                    const inputs = document.querySelectorAll('#editarCategoriaForm input, #editarCategoriaForm textarea');
                    const handleInputChange = (e) => {
                        validarCampo(e.target.id, e.target.value);
                        validarFormularioCompleto();
                    };

                    inputs.forEach(input => {
                        input.addEventListener('input', handleInputChange);
                        input.addEventListener('blur', handleInputChange);
                    });

                    return () => {
                        if (form) {
                            form.removeEventListener('submit', manejarEnvioFormulario);
                        }
                        inputs.forEach(input => {
                            input.removeEventListener('input', handleInputChange);
                            input.removeEventListener('blur', handleInputChange);
                        });
                    };
                }, []);

                return React.createElement('div', {
                    style: {
                        marginBottom: '20px',
                        padding: '15px',
                        backgroundColor: formValido ? '#d4edda' : (intentoEnvio ? '#f8d7da' : '#fff3cd'),
                        border: `1px solid ${formValido ? '#c3e6cb' : (intentoEnvio ? '#f5c6cb' : '#ffeaa7')}`,
                        borderRadius: '5px',
                        color: formValido ? '#155724' : (intentoEnvio ? '#721c24' : '#856404')
                    }
                },
                        formValido
                        ? 'Formulario válido. Haz clic en "Modificar Categoría" para enviar.'
                        : (intentoEnvio
                                ? 'Hay errores en el formulario. Corrígelos antes de enviar.'
                                : 'Completa el formulario para modificar una categoría. Recuerda modificar al menos un campo.')
                        );
            }

            ReactDOM.render(
                    React.createElement(ValidacionEditarCategoria),
                    document.getElementById('react-validation')
                    );
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