/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author SUPERTRONICA
 */
public class EnvioInternacional extends TarifaEnvio {

    private double arancel;

    public EnvioInternacional() {

    }

    public EnvioInternacional(double arancel) {
        this.arancel = arancel;
    }

    public EnvioInternacional(double arancel, double tarifaBase) {
        super(tarifaBase);
        this.arancel = arancel;
    }

    public double getArancel() {
        return arancel;
    }

    public void setArancel(double arancel) {
        this.arancel = arancel;
    }

    @Override
    public double calcularCosto(double peso, double largo, double ancho, double alto) {
         return (peso * tarifaBase) + arancel;
    }

}
