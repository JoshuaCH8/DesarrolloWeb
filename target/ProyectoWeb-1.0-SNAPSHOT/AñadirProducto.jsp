<%-- 
    Document   : AñadirProducto
    Created on : 23 sep. 2025, 19:09:13
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <head>
        <meta http-equiv="C
              ontent-Type" content="text/html; charset=UTF-8" />
        <title>Añadir Producto</title>
    </head>
    <body>
        <h1>Añadir Producto.</h1>
        <form action="SvA_adirProducto" method="POST">
            <p>
                <label>Nombre Del Producto</label>
                <input type="text" name="nombre_producto"/>
            </p>
            <p>
                <label>Precio Del Producto</label>
                <input type="text" name="precio_producto"/>
            </p>
            <button type="submit">Añadir</button>
        </form>
    </body>
</html>
