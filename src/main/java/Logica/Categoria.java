package Logica;

public class Categoria {
    private int idCategoria;
    private String nombreCategoria;
    private String descripcion;
    private int estado;
    
    public Categoria() {}
    
    public Categoria(int idCategoria, String nombreCategoria) {
        this.idCategoria = idCategoria;
        this.nombreCategoria = nombreCategoria;
    }
    
    // Getters y Setters
    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }
    
    public String getNombreCategoria() { return nombreCategoria; }
    public void setNombreCategoria(String nombreCategoria) { this.nombreCategoria = nombreCategoria; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public int getEstado() { return estado; }
    public void setEstado(int estado) { this.estado = estado; }
}