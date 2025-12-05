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
        <title>Agregar Producto</title>

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
            .submit-btn:disabled {
                opacity: 0.6;
                cursor: not-allowed;
            }
        </style>

        <script>
            function generarCodigoBarras() {
                fetch('SvAgregarProducto?action=generarCodigo')
                        .then(response => response.text())
                        .then(codigo => {
                            document.getElementById('codigo_barras').value = codigo;
                            // Disparar evento de cambio para validación
                            document.getElementById('codigo_barras').dispatchEvent(new Event('input'));
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
            <!-- INCLUIR NAVBAR -->
            <%@include file="navbar.jsp" %>
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

            <!-- Contenedor para React -->
            <div id="react-validation"></div>

            <form action="SvAgregarProducto" method="POST" class="form-simple" id="productForm">
                <div class="form-group">
                    <label for="nombre_producto" class="form-label">Nombre del producto:</label>
                    <input type="text" name="nombre_producto" id="nombre_producto" class="form-input" required/>
                    <span id="nombre-error" class="validation-error"></span>
                </div>

                <div class="form-group">
                    <label for="precio_producto" class="form-label">Precio:</label>
                    <input type="number" step="0.01" name="precio_producto" id="precio_producto" class="form-input" required/>
                    <span id="precio-error" class="validation-error"></span>
                </div>

                <div class="form-group">
                    <label for="cantidad_producto" class="form-label">Cantidad inicial:</label>
                    <input type="number" name="cantidad_producto" id="cantidad_producto" class="form-input" required/>
                    <span id="cantidad-error" class="validation-error"></span>
                </div>

                <div class="form-group">
                    <label for="codigo_barras" class="form-label">Código de barras:</label>
                    <div class="input-group">
                        <input type="text" name="codigo_barras" id="codigo_barras" class="form-input" readonly required/>
                        <button type="button" onclick="generarCodigoBarras()" class="btn">
                            Generar
                        </button>
                    </div>
                    <span id="codigo-error" class="validation-error"></span>
                </div>

                <div class="form-group">
                    <label for="categoria_id" class="form-label">Categoría ID:</label>
                    <input type="number" name="categoria_id" id="categoria_id" class="form-input" required/>
                    <span id="categoria-error" class="validation-error"></span>
                </div>

                <div class="form-group">
                    <label for="descripcion" class="form-label">Descripción (campo opcional):</label>
                    <textarea name="descripcion" id="descripcion" class="form-textarea"></textarea>
                    <span id="descripcion-error" class="validation-error"></span>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success submit-btn" id="submitBtn">Agregar Producto</button>
                    <a href="Conexion.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>

        <!-- Validación React -->
        <script type="text/babel">
            const {useState, useEffect} = React;

            function ValidacionProducto() {
                const [errores, setErrores] = useState({});
                const [formValido, setFormValido] = useState(false);
                const [intentoEnvio, setIntentoEnvio] = useState(false);

                const validaciones = {
                    nombre_producto: (valor) => {
                        if (!valor.trim())
                            return 'El nombre es obligatorio';
                        if (valor.length < 2)
                            return 'El nombre debe tener al menos 2 caracteres';
                        return '';
                    },
                    precio_producto: (valor) => {
                        if (!valor)
                            return 'El precio es obligatorio';
                        const precio = parseFloat(valor);
                        if (precio <= 0)
                            return 'El precio debe ser mayor a 0';
                        return '';
                    },
                    cantidad_producto: (valor) => {
                        if (!valor)
                            return 'La cantidad es obligatoria';
                        const cantidad = parseInt(valor);
                        if (cantidad < 0)
                            return 'La cantidad no puede ser negativa';
                        return '';
                    },
                    codigo_barras: (valor) => {
                        if (!valor.trim())
                            return 'El código de barras es obligatorio';
                        if (valor.length < 3)
                            return 'El código debe tener al menos 3 caracteres';
                        return '';
                    },
                    categoria_id: (valor) => {
                        if (!valor)
                            return 'La categoría es obligatoria';
                        const categoria = parseInt(valor);
                        if (categoria <= 0)
                            return 'ID de categoría inválido';
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
                    const inputs = document.querySelectorAll('#productForm input[required]');
                    let esValido = true;
                    const nuevosErrores = {};

                    inputs.forEach(input => {
                        const error = validaciones[input.id] ? validaciones[input.id](input.value) : '';
                        if (error) {
                            esValido = false;
                            nuevosErrores[input.id] = error;
                        }
                    });

                    setErrores(nuevosErrores);
                    setFormValido(esValido);
                    return esValido;
                };

                const manejarEnvioFormulario = (e) => {
                    e.preventDefault();
                    console.log('Intento de envío detectado');

                    const esValido = validarFormularioCompleto();
                    setIntentoEnvio(true);

                    if (esValido) {
                        console.log('Formulario válido, enviando...');
                        // ENVIAR FORMULARIO
                        const form = document.getElementById('productForm');
                        form.submit();
                    } else {
                        console.log('Formulario inválido, mostrando errores');
                    }
                };

                useEffect(() => {
                    const form = document.getElementById('productForm');
                    console.log('Form encontrado:', form);

                    if (form) {
                        form.addEventListener('submit', manejarEnvioFormulario);
                    }

                    // Event listeners para validación en tiempo real
                    const inputs = document.querySelectorAll('#productForm input, #productForm textarea');
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
                        ? 'Formulario válido. Haz clic en "Agregar Producto" para enviar.'
                        : (intentoEnvio
                                ? 'Hay errores en el formulario. Corrígelos antes de enviar.'
                                : 'Completa el formulario para agregar un nuevo producto')
                        );
            }

            ReactDOM.render(
                    React.createElement(ValidacionProducto),
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