package Logica;

import java.math.BigDecimal;

public class Producto {
    private int idProducto;
    private String nombreProducto;
    private BigDecimal precioProducto;
    private int cantidadProducto;
    private String codigoBarras;
    private int categoriaId;
    private String descripcion;
    private String fechaCreacion;
    private String fechaActualizacion;
    private int estado;
    
    // Constructores
    public Producto() {
        this.estado = 1; // Por defecto activo
    }
    
    public Producto(String nombreProducto, BigDecimal precioProducto, int cantidadProducto) {
        this();
        this.nombreProducto = nombreProducto;
        this.precioProducto = precioProducto;
        this.cantidadProducto = cantidadProducto;
    }
    
    public Producto(String nombreProducto, BigDecimal precioProducto, int cantidadProducto, 
                   String codigoBarras, int categoriaId, String descripcion) {
        this();
        this.nombreProducto = nombreProducto;
        this.precioProducto = precioProducto;
        this.cantidadProducto = cantidadProducto;
        this.codigoBarras = codigoBarras;
        this.categoriaId = categoriaId;
        this.descripcion = descripcion;
    }
    
    // Constructor completo
    public Producto(int idProducto, String nombreProducto, BigDecimal precioProducto, 
                   int cantidadProducto, String codigoBarras, int categoriaId, 
                   String descripcion, String fechaCreacion, String fechaActualizacion, int estado) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.precioProducto = precioProducto;
        this.cantidadProducto = cantidadProducto;
        this.codigoBarras = codigoBarras;
        this.categoriaId = categoriaId;
        this.descripcion = descripcion;
        this.fechaCreacion = fechaCreacion;
        this.fechaActualizacion = fechaActualizacion;
        this.estado = estado;
    }
    
    // Getters y Setters
    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }
    
    public String getNombreProducto() { return nombreProducto; }
    public void setNombreProducto(String nombreProducto) { this.nombreProducto = nombreProducto; }
    
    public BigDecimal getPrecioProducto() { return precioProducto; }
    public void setPrecioProducto(BigDecimal precioProducto) { this.precioProducto = precioProducto; }
    
    public int getCantidadProducto() { return cantidadProducto; }
    public void setCantidadProducto(int cantidadProducto) { this.cantidadProducto = cantidadProducto; }
    
    public String getCodigoBarras() { return codigoBarras; }
    public void setCodigoBarras(String codigoBarras) { this.codigoBarras = codigoBarras; }
    
    public int getCategoriaId() { return categoriaId; }
    public void setCategoriaId(int categoriaId) { this.categoriaId = categoriaId; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public String getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(String fechaCreacion) { this.fechaCreacion = fechaCreacion; }
    
    public String getFechaActualizacion() { return fechaActualizacion; }
    public void setFechaActualizacion(String fechaActualizacion) { this.fechaActualizacion = fechaActualizacion; }
    
    public int getEstado() { return estado; }
    public void setEstado(int estado) { this.estado = estado; }
    
    // Métodos auxiliares para compatibilidad
    public void setPrecioProducto(double precio) {
        this.precioProducto = BigDecimal.valueOf(precio);
    }
    
    @Override
    public String toString() {
        return "Producto{" + 
               "idProducto=" + idProducto + 
               ", nombreProducto='" + nombreProducto + '\'' + 
               ", precioProducto=" + precioProducto + 
               ", cantidadProducto=" + cantidadProducto + 
               ", codigoBarras='" + codigoBarras + '\'' + 
               ", categoriaId=" + categoriaId + 
               ", descripcion='" + descripcion + '\'' + 
               ", estado=" + estado + 
               '}';
    }
}