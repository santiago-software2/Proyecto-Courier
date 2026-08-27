/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.util.Date;

/**
 *
 * @author SUPERTRONICA
 */
public class GuiaEnvio {
    private int idGe;
    private int idRemitente;
    private Integer idRecolector;
    private int idDestinatario;
    private String direccionOrigen;
    private Date fechaDespacho;
    private double costoTotal;
    private String estado;
    private String tiempoEntrega;
    private String tipoEnvio;

    public GuiaEnvio() {
    }

    public GuiaEnvio(int idGe, int idRemitente, Integer idRecolector, int idDestinatario, String direccionOrigen, Date fechaDespacho, double costoTotal, String estado, String tiempoEntrega, String tipoEnvio) {
        this.idGe = idGe;
        this.idRemitente = idRemitente;
        this.idRecolector = idRecolector;
        this.idDestinatario = idDestinatario;
        this.direccionOrigen = direccionOrigen;
        this.fechaDespacho = fechaDespacho;
        this.costoTotal = costoTotal;
        this.estado = estado;
        this.tiempoEntrega = tiempoEntrega;
        this.tipoEnvio = tipoEnvio;
    }

    public int getIdGe() {
        return idGe;
    }

    public int getIdRemitente() {
        return idRemitente;
    }

    public Integer getIdRecolector() {
        return idRecolector;
    }

    public int getIdDestinatario() {
        return idDestinatario;
    }

    public String getDireccionOrigen() {
        return direccionOrigen;
    }

    public Date getFechaDespacho() {
        return fechaDespacho;
    }

    public double getCostoTotal() {
        return costoTotal;
    }

    public String getTiempoEntrega() {
        return tiempoEntrega;
    }

    public String getTipoEnvio() {
        return tipoEnvio;
    }

    public String getEstado() {
        return estado;
    }
    

    public void setIdGe(int idGe) {
        this.idGe = idGe;
    }

    public void setIdRemitente(int idRemitente) {
        this.idRemitente = idRemitente;
    }

    public void setIdRecolector(Integer idRecolector) {
        this.idRecolector = idRecolector;
    }

    public void setIdDestinatario(int idDestinatario) {
        this.idDestinatario = idDestinatario;
    }

    public void setDireccionOrigen(String direccionOrigen) {
        this.direccionOrigen = direccionOrigen;
    }

    public void setFechaDespacho(Date fechaDespacho) {
        this.fechaDespacho = fechaDespacho;
    }

    public void setCostoTotal(double costoTotal) {
        this.costoTotal = costoTotal;
    }

    public void setTiempoEntrega(String tiempoEntrega) {
        this.tiempoEntrega = tiempoEntrega;
    }

    public void setTipoEnvio(String tipoEnvio) {
        this.tipoEnvio = tipoEnvio;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
}
