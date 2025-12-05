<%-- 
    Document   : MostrarCategorias
    Created on : 3 oct. 2025, 13:38:58
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <title>Mostrar Categorias</title>
    </head>
    <body>
        <div class="container">
            <!-- INCLUIR NAVBAR -->
            <%@include file="navbar.jsp" %>
            <h2>Catálogo de Categorías</h2>
            <p class="subtitle">Lista completa de categorías disponibles en el sistema</p>

            <%
                List<Categoria> lista_categorias = (List<Categoria>) request.getAttribute("lista_categorias");
                if (lista_categorias != null && !lista_categorias.isEmpty()) {
            %>

            <!-- CONTENEDOR PARA REACT - AGREGAR ESTA LÍNEA -->
            <div id="filtros-react"></div>

            <!-- Contador simple -->
            <div style="background: #e7f3ff; padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center;">
                <p style="margin: 0; color: #004085;">
                    <strong>Total de categorías: <%= lista_categorias.size()%></strong>
                </p>
            </div>

            <!-- Tabla de categorías - AGREGAR CLASE -->
            <table class="table tabla-categorias">
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
            <!-- Estado sin datos -->
            <div style="text-align: center; padding: 40px; background: #f8f9fa; border-radius: 8px;">
                <p style="color: #6c757d; font-size: 1.2em; margin-bottom: 20px;">
                    No hay categorías disponibles
                </p>
                <p style="color: #6c757d; margin-bottom: 25px;">
                    No se han registrado categorías en el sistema.
                </p>
                <a href="AgregarCategoria.jsp" class="btn btn-success">Agregar Primera Categoría</a>
            </div>
            <% }%>

            <div style="text-align: center; margin-top: 25px;">
                <a href="Conexion.jsp" class="btn">Volver al Inicio</a>
            </div>
        </div>

        <script type="text/babel">
            function FiltrosCategorias() {
                const [filtro, setFiltro] = React.useState('');
                const [orden, setOrden] = React.useState('nombre');

                const aplicarFiltrosYOrden = () => {
                    const filas = Array.from(document.querySelectorAll('.tabla-categorias tbody tr'));
                    let categoriasVisibles = 0;

                    // Primero: aplicar filtro y mostrar/ocultar
                    filas.forEach(fila => {
                        const celdas = fila.querySelectorAll('td');
                        const nombre = celdas[1].textContent.toLowerCase();
                        const descripcion = celdas[2].textContent.toLowerCase();

                        let coincide = true;

                        // Filtro de texto
                        if (filtro && !nombre.includes(filtro.toLowerCase()) && !descripcion.includes(filtro.toLowerCase())) {
                            coincide = false;
                        }

                        if (coincide) {
                            fila.style.display = '';
                            categoriasVisibles++;
                        } else {
                            fila.style.display = 'none';
                        }
                    });

                    // Segundo: ordenar si es necesario
                    if (orden !== 'default') {
                        const tbody = document.querySelector('.tabla-categorias tbody');
                        const filasVisibles = Array.from(tbody.querySelectorAll('tr'))
                                .filter(tr => tr.style.display !== 'none');

                        filasVisibles.sort((a, b) => {
                            const aCeldas = a.querySelectorAll('td');
                            const bCeldas = b.querySelectorAll('td');
                            const aNombre = aCeldas[1].textContent;
                            const bNombre = bCeldas[1].textContent;
                            const aId = parseInt(aCeldas[0].textContent);
                            const bId = parseInt(bCeldas[0].textContent);

                            switch (orden) {
                                case 'nombre':
                                    return aNombre.localeCompare(bNombre);
                                case 'id-asc':
                                    return aId - bId;
                                case 'id-desc':
                                    return bId - aId;
                                default:
                                    return 0;
                            }
                        });

                        // Reordenar en el DOM
                        filasVisibles.forEach(fila => tbody.appendChild(fila));
                    }

                    // Actualizar contador
                    const totalCategorias = filas.length;
                    const contador = document.getElementById('contador-categorias');
                    if (contador) {
                        contador.textContent = `Mostrando: ${categoriasVisibles} de ${totalCategorias} categorías`;
                        contador.style.color = categoriasVisibles === 0 ? '#dc3545' : '#28a745';
                    }
                };

                React.useEffect(() => {
                    aplicarFiltrosYOrden();
                }, [filtro, orden]);

                const limpiarFiltros = () => {
                    setFiltro('');
                    setOrden('default');
                };

                return React.createElement('div', {
                    style: {
                        margin: '20px 0',
                        padding: '20px',
                        border: '1px solid #ddd',
                        backgroundColor: '#f8f9fa',
                        borderRadius: '8px'
                    }
                },
                        React.createElement('h3', {style: {marginTop: 0, color: '#333'}},
                                'Filtros de Categorías'
                                ),
                        // Filtro de texto
                        React.createElement('div', {style: {marginBottom: '15px'}},
                                React.createElement('input', {
                                    type: 'text',
                                    placeholder: 'Buscar por nombre, descripción...',
                                    value: filtro,
                                    onChange: (e) => setFiltro(e.target.value),
                                    style: {
                                        padding: '10px',
                                        width: '100%',
                                        maxWidth: '400px',
                                        border: '1px solid #ccc',
                                        borderRadius: '4px',
                                        fontSize: '14px'
                                    }
                                })
                                ),
                        // Filtros en línea
                        React.createElement('div', {
                            style: {
                                display: 'flex',
                                gap: '15px',
                                flexWrap: 'wrap',
                                marginBottom: '15px'
                            }
                        },
                                // Ordenamiento
                                React.createElement('div', null,
                                        React.createElement('label', {
                                            style: {display: 'block', marginBottom: '5px', fontWeight: 'bold'}
                                        }, 'Ordenar por:'),
                                        React.createElement('select', {
                                            value: orden,
                                            onChange: (e) => setOrden(e.target.value),
                                            style: {
                                                padding: '8px',
                                                border: '1px solid #ccc',
                                                borderRadius: '4px'
                                            }
                                        },
                                                React.createElement('option', {value: 'default'}, 'Por defecto'),
                                                React.createElement('option', {value: 'nombre'}, 'Nombre A-Z'),
                                                React.createElement('option', {value: 'id-asc'}, 'ID (mayor a menor)'),
                                                React.createElement('option', {value: 'id-desc'}, 'ID (meor a mayor)')
                                                )
                                        )
                                ),
                        // Contador y acciones
                        React.createElement('div', {
                            style: {
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center',
                                flexWrap: 'wrap',
                                gap: '10px'
                            }
                        },
                                )
                        );
            }

            // Esperar a que la tabla esté cargada
            setTimeout(() => {
                if (document.querySelector('.tabla-categorias')) {
                    ReactDOM.render(
                            React.createElement(FiltrosCategorias),
                            document.getElementById('filtros-react')
                            );
                }
            }, 100);
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