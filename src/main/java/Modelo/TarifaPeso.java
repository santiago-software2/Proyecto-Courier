/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author SUPERTRONICA
 */
public class TarifaPeso {
    private int idTarifa;
    private double pesoMin;
    private double pesoMax;
    private double precioKg;

    public TarifaPeso() {
    }

    public TarifaPeso(int idTarifa, double pesoMin, double pesoMax, double precioKg) {
        this.idTarifa = idTarifa;
        this.pesoMin = pesoMin;
        this.pesoMax = pesoMax;
        this.precioKg = precioKg;
    }

    public int getIdTarifa() {
        return idTarifa;
    }

    public double getPesoMin() {
        return pesoMin;
    }

    public double getPesoMax() {
        return pesoMax;
    }

    public double getPrecioKg() {
        return precioKg;
    }

    public void setIdTarifa(int idTarifa) {
        this.idTarifa = idTarifa;
    }

    public void setPesoMin(double pesoMin) {
        this.pesoMin = pesoMin;
    }

    public void setPesoMax(double pesoMax) {
        this.pesoMax = pesoMax;
    }

    public void setPrecioKg(double precioKg) {
        this.precioKg = precioKg;
    }
    
    @Override
    public String toString() {
        return pesoMin + "kg - " + pesoMax + "kg";
    }
}
