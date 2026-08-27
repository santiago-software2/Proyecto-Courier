/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author SUPERTRONICA
 */
public class Destinatario {
    private int idDestinatario;
    private String nombre;
    private String contacto;
    private String direccion;

    public Destinatario() {
    }

    public Destinatario(int idDestinatario, String nombre, String contacto, String direccion) {
        this.idDestinatario = idDestinatario;
        this.nombre = nombre;
        this.contacto = contacto;
        this.direccion = direccion;
    }

    public int getIdDestinatario() {
        return idDestinatario;
    }

    public String getNombre() {
        return nombre;
    }

    public String getContacto() {
        return contacto;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setIdDestinatario(int idDestinatario) {
        this.idDestinatario = idDestinatario;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setContacto(String contacto) {
        this.contacto = contacto;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    
}
