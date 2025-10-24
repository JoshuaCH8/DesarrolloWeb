<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Inicio</title>
        <link rel="icon" type="image/png" href="img/logo.png" />
        
        <!-- React y Babel -->
        <script type="text/javascript" src="https://unpkg.com/react@18/umd/react.development.js"></script>
        <script type="text/javascript" src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
        <script type="text/javascript" src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
        
        <style type="text/css">
            /* Estilos para el menú desplegable */
            .dropdown-menu {
                position: relative;
                display: inline-block;
            }
            
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: white;
                min-width: 200px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
                border-radius: 5px;
                overflow: hidden;
            }
            
            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                transition: background-color 0.3s;
            }
            
            .dropdown-content a:hover {
                background-color: #f1f1f1;
            }
            
            .dropdown-menu:hover .dropdown-content {
                display: block;
            }
            
            .dropdown-btn {
                background-color: #4CAF50;
                color: white;
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            
            .dropdown-btn:hover {
                background-color: #45a049;
            }
            
            .menu-buttons {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            
            .react-container {
                margin: 20px 0;
            }
            
            .menu-section {
                margin-bottom: 30px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
            }
            
            .fade-in {
                animation: fadeIn 0.5s ease-in;
            }
            
            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            
            .mensaje {
                padding: 15px;
                margin: 20px 0;
                border-radius: 5px;
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            
            .mision-vision {
                display: flex;
                gap: 20px;
                margin: 30px 0;
                flex-wrap: wrap;
            }
            
            .text-box {
                flex: 1;
                min-width: 300px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            
            .header {
                text-align: center;
                margin-bottom: 30px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header fade-in">
                <h1>ABARROTES LA HACIENDA</h1>
            </div>

            <!-- Contenedor para React -->
            <div id="react-root"></div>

            <!-- Misión y Visión -->
            <div class="mision-vision">
                <div class="text-box fade-in">
                    <h3>Misión</h3>
                    <p>Proveer a nuestras familias y comunidad productos de primera necesidad con calidad, frescura y variedad, ofreciendo un servicio cercano, honesto y accesible. Nos comprometemos a ser un negocio de confianza que contribuye al bienestar de nuestros clientes y al desarrollo de la localidad.</p>
                </div>

                <div class="text-box fade-in">
                    <h3>Visión</h3>
                    <p>Ser la tienda de abarrotes preferida en la comunidad, reconocida por nuestra atención personalizada, surtido completo y precios justos. Buscamos innovar en servicios y mantenernos como un espacio cercano donde cada cliente se sienta como en casa.</p>
                </div>
            </div>

            <!-- Mensajes del sistema -->
            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% }%>
        </div>

        <!-- Script de React -->
        <script type="text/babel">
            const { useState, useEffect } = React;
            
            // Componente del menú desplegable
            const DropdownMenu = function({ title, items }) {
                const [isOpen, setIsOpen] = useState(false);
                
                const handleMouseEnter = function() {
                    setIsOpen(true);
                };
                
                const handleMouseLeave = function() {
                    setIsOpen(false);
                };
                
                const handleItemClick = function() {
                    setIsOpen(false);
                };
                
                const menuItems = items.map(function(item, index) {
                    return React.createElement('a', {
                        key: index,
                        href: item.link,
                        onClick: handleItemClick
                    }, item.label);
                });
                
                return React.createElement('div', { 
                    className: 'dropdown-menu',
                    onMouseEnter: handleMouseEnter,
                    onMouseLeave: handleMouseLeave
                },
                    React.createElement('button', {
                        className: 'dropdown-btn pulse',
                        onMouseEnter: handleMouseEnter
                    }, title + ' ▼'),
                    isOpen && React.createElement('div', {
                        className: 'dropdown-content',
                        onMouseEnter: handleMouseEnter,
                        onMouseLeave: handleMouseLeave
                    }, menuItems)
                );
            };
            
            // Componente principal
            const App = function() {
                const [currentTime, setCurrentTime] = useState(new Date());
                
                useEffect(function() {
                    const timer = setInterval(function() {
                        setCurrentTime(new Date());
                    }, 1000);
                    
                    return function() {
                        clearInterval(timer);
                    };
                }, []);
                
                const productosItems = [
                    { label: 'Mostrar Productos', link: 'SvMostrarProductos' },
                    { label: 'Agregar Producto', link: 'AgregarProducto.jsp' },
                    { label: 'Editar Producto', link: 'SvEditarProducto' },
                    { label: 'Eliminar Producto', link: 'SvEliminarProducto' }
                ];
                
                const categoriasItems = [
                    { label: 'Mostrar Categorías', link: 'SvMostrarCategorias' },
                    { label: 'Agregar Categoría', link: 'AgregarCategoria.jsp' },
                    { label: 'Editar Categoría', link: 'SvEditarCategoria' },
                    { label: 'Eliminar Categoría', link: 'SvEliminarCategoria' }
                ];
                
                return React.createElement('div', { className: 'react-container' },
                    React.createElement('div', { className: 'menu-section fade-in' },
                        React.createElement('h2', null, 'Gestión de Productos'),
                        React.createElement('div', { className: 'menu-buttons' },
                            React.createElement(DropdownMenu, {
                                title: 'Productos',
                                items: productosItems
                            })
                        )
                    ),
                    
                    React.createElement('div', { className: 'menu-section fade-in' },
                        React.createElement('h2', null, 'Gestión de Categorías'),
                        React.createElement('div', { className: 'menu-buttons' },
                            React.createElement(DropdownMenu, {
                                title: 'Categorías',
                                items: categoriasItems
                            })
                        )
                    )
                );
            };
            
            // Renderizar la aplicación React
            ReactDOM.render(React.createElement(App), document.getElementById('react-root'));
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