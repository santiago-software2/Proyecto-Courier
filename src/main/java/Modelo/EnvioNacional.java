/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author SUPERTRONICA
 */
public class EnvioNacional extends TarifaEnvio {

    public EnvioNacional() {

    }

    @Override
    public double calcularCosto(double peso, double largo, double ancho, double alto) {
        return peso * tarifaBase;
    }
    
}
