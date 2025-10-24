<%-- 
    Document   : MostrarProductos
    Created on : 2 oct. 2025, 14:15:59
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
        <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
        <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
        <title>Mostrar Productos</title>
    </head>
    <body>
        <div class="container">
            <h2>Inventario de Productos</h2>
            <p class="subtitle">Catálogo completo de productos disponibles en la tienda</p>

            <%
                List<Producto> lista_productos = (List<Producto>) request.getAttribute("lista_productos");
                if (lista_productos != null && !lista_productos.isEmpty()) {

                    // Calcular estadísticas
                    int totalProductos = lista_productos.size();
                    int totalStock = 0;
                    double valorTotal = 0.0;

                    for (Producto producto : lista_productos) {
                        totalStock += producto.getCantidadProducto();
                        valorTotal += producto.getPrecioProducto().doubleValue() * producto.getCantidadProducto();
                    }
            %>

            <!-- Estadísticas simplificadas -->
            <div class="mensaje" style="text-align: center; margin-bottom: 20px;">
                <p>
                    <strong>Total Productos: <%= totalProductos%> | 
                        En Stock: <%= totalStock%></strong>
                </p>
            </div>

            <!-- SECCIÓN NUEVA CON REACT - COLOCAR ANTES DE LA TABLA -->
            <div id="filtros-react"></div>
            <!-- Tabla de productos - AGREGAR CLASE para que React la encuentre -->
            <table class="table tabla-productos">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Código Barras</th>
                        <th>Categoría</th>
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
                        <td>
                            <%
                                int stock = producto.getCantidadProducto();
                                String estiloStock = "";
                                if (stock > 10) {
                                    estiloStock = "color: green;";
                                } else if (stock > 0) {
                                    estiloStock = "color: orange;";
                                } else {
                                    estiloStock = "color: red;";
                                }
                            %>
                            <span style="<%= estiloStock%> font-weight: bold;">
                                <%= stock%>
                            </span>
                        </td>
                        <td><%= producto.getCodigoBarras()%></td>
                        <td>#<%= producto.getCategoriaId()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%
            } else {
            %>
            <!-- Estado sin datos -->
            <div class="mensaje" style="text-align: center;">
                <p><strong>No hay productos disponibles</strong></p>
                <p>El inventario de productos está vacío.</p>
                <a href="AgregarProducto.jsp" class="btn btn-success">Agregar Primer Producto</a>
            </div>
            <% }%>

            <!-- Botón de regreso -->
            <div style="text-align: center; margin-top: 20px;">
                <a href="Conexion.jsp" class="btn">Volver al Inicio</a>
            </div>
        </div>


        <script type="text/babel">
            function FiltrosProductos() {
                const [filtro, setFiltro] = React.useState('');
                const [filtroStock, setFiltroStock] = React.useState('todos');

                // Función para filtrar la tabla
                const aplicarFiltros = () => {
                    const filas = document.querySelectorAll('.tabla-productos tbody tr');
                    let productosVisibles = 0;

                    filas.forEach(fila => {
                        const celdas = fila.querySelectorAll('td');
                        const nombre = celdas[1].textContent.toLowerCase();
                        const precio = celdas[2].textContent;
                        const stock = parseInt(celdas[3].querySelector('span').textContent);

                        let coincide = true;

                        // Filtro de texto
                        if (filtro && !nombre.includes(filtro.toLowerCase())) {
                            coincide = false;
                        }

                        // Filtro de stock
                        if (coincide && filtroStock !== 'todos') {
                            if (filtroStock === 'disponible' && stock <= 0)
                                coincide = false;
                            if (filtroStock === 'bajo' && (stock > 5 || stock === 0))
                                coincide = false;
                            if (filtroStock === 'agotado' && stock > 0)
                                coincide = false;
                        }

                        if (coincide) {
                            fila.style.display = '';
                            productosVisibles++;
                        } else {
                            fila.style.display = 'none';
                        }
                    });

                    // Actualizar contador
                    const contador = document.getElementById('contador-productos');
                    if (contador) {
                        contador.textContent = `Mostrando: ${productosVisibles} de ${filas.length} productos`;
                    }
                };

                // Aplicar filtros cuando cambien los estados
                React.useEffect(() => {
                    aplicarFiltros();
                }, [filtro, filtroStock]);

                return React.createElement('div', {
                    style: {
                        margin: '20px 0',
                        padding: '20px',
                        border: '1px solid #ddd',
                        backgroundColor: '#f8f9fa',
                        borderRadius: '8px'
                    }
                },
                        React.createElement('h3', {style: {marginTop: 0}}, 'Filtro'),
                        // Filtro de texto
                        React.createElement('div', {style: {marginBottom: '15px'}},
                                React.createElement('input', {
                                    type: 'text',
                                    placeholder: 'Buscar por nombre...',
                                    value: filtro,
                                    onChange: (e) => setFiltro(e.target.value),
                                    style: {
                                        padding: '10px',
                                        width: '100%',
                                        maxWidth: '400px',
                                        border: '1px solid #ccc',
                                        borderRadius: '4px'
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
                                // Filtro de stock
                                React.createElement('div', null,
                                        React.createElement('label', {
                                            style: {display: 'block', marginBottom: '5px', fontWeight: 'bold'}
                                        }, 'Estado Stock:'),
                                        React.createElement('select', {
                                            value: filtroStock,
                                            onChange: (e) => setFiltroStock(e.target.value),
                                            style: {
                                                padding: '8px',
                                                border: '1px solid #ccc',
                                                borderRadius: '4px'
                                            }
                                        },
                                                React.createElement('option', {value: 'todos'}, 'Todos'),
                                                React.createElement('option', {value: 'disponible'}, 'Disponible'),
                                                React.createElement('option', {value: 'bajo'}, 'Stock Bajo (entre 1-5)'),
                                                React.createElement('option', {value: 'agotado'}, 'Agotado')
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

            // Esperar a que la tabla esté cargada antes de montar React
            setTimeout(() => {
                if (document.querySelector('.tabla-productos')) {
                    ReactDOM.render(
                            React.createElement(FiltrosProductos),
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