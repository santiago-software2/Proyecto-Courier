/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Destinatario;
import Modelo.Exportable;
import Modelo.GuiaEnvio;
import Modelo.PDFGuiaEnvio;
import Modelo.TarifaPeso;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author SUPERTRONICA
 */
public class GuiaEnvioControlador {
    //  EX CONTRALADOR 
    //INSTANCIAR LA CONEXIÓN A LA BASE DE DATOS

    ConexionBDD conectar = new ConexionBDD();
    //CLASE QUE ME PERMITA CONECTARME DIRECTAMENTE A MYSQL
    Connection conectado = (Connection) conectar.conectar();
    //CLASE QUE ME PERMITE EJECUTAR MI SENTENCIA SQL
    PreparedStatement ejecutar;
    //OBTENER RESULTADOS DE LA CONSULTA
    ResultSet resultado;

    public ArrayList<Destinatario> listarDestinatarios() {
        ArrayList<Destinatario> lista = new ArrayList<>();
        String sentenciaSQL = "{call sp_mostrar_destinatarios()}";

        // USO DE TRY-WITH-RESOURCES:
        // El CallableStatement se cerrará automáticamente al finalizar la ejecución.
        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {

            // 1. Ejecutar el Stored Procedure y obtener resultado
            ResultSet resultado = ejecutar.executeQuery();

            // 2. Recorrer cada destinatario y agregarlo a la lista
            while (resultado.next()) {
                Destinatario d = new Destinatario();
                d.setIdDestinatario(resultado.getInt("id_Destinatario"));
                d.setNombre(resultado.getString("nombre"));
                d.setContacto(resultado.getString("contacto"));
                d.setDireccion(resultado.getString("direccion"));

                lista.add(d);
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }

        return lista;
    }

    public ArrayList<TarifaPeso> listarTarifasPeso() {
        ArrayList<TarifaPeso> lista = new ArrayList<>();
        String sentenciaSQL = "{call sp_mostrar_tarifas_peso()}";

        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {
            ResultSet resultado = ejecutar.executeQuery();

            while (resultado.next()) {
                TarifaPeso t = new TarifaPeso();
                t.setIdTarifa(resultado.getInt("id_tarifa"));
                t.setPesoMin(resultado.getDouble("peso_min"));
                t.setPesoMax(resultado.getDouble("peso_max"));
                t.setPrecioKg(resultado.getDouble("precio_kg"));

                lista.add(t);
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }

        return lista;
    }

    public boolean crearGuiaEnvio(int idRemitente, int idDestinatario, String direccionOrigen,
            double costoTotal, String tiempoEntrega, String tipoEnvio,
            double peso, double largo, double ancho, double alto,
            String contenidoDeclarado, double valorAsegurado) {

        String sentenciaSQL1 = "{call sp_crear_guia_envio(?, ?, ?, ?, ?, ?, ?)}";

        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL1)) {

            // 1. Mapeo de parámetros de entrada (IN)
            ejecutar.setInt(1, idRemitente);
            ejecutar.setInt(2, idDestinatario);
            ejecutar.setString(3, direccionOrigen);
            ejecutar.setDouble(4, costoTotal);
            ejecutar.setString(5, tiempoEntrega);
            ejecutar.setString(6, tipoEnvio);

            // 2. Parámetro de salida (OUT id_ge)
            ejecutar.registerOutParameter(7, java.sql.Types.INTEGER);

            // 3. Ejecutar el Stored Procedure
            ejecutar.execute();

            // 4. Obtener el ID generado
            int idGeGenerado = ejecutar.getInt(7);
            this.ultimoIdGenerado = idGeGenerado;

            // 5. Guardar el detalle del paquete usando ese ID
            String sentenciaSQL2 = "{call sp_crear_detalle_paquete(?, ?, ?, ?, ?, ?, ?)}";
            try (CallableStatement ejecutar2 = conectado.prepareCall(sentenciaSQL2)) {
                ejecutar2.setInt(1, idGeGenerado);
                ejecutar2.setDouble(2, peso);
                ejecutar2.setDouble(3, largo);
                ejecutar2.setDouble(4, ancho);
                ejecutar2.setDouble(5, alto);
                ejecutar2.setString(6, contenidoDeclarado);
                ejecutar2.setDouble(7, valorAsegurado);
                ejecutar2.execute();
            }

            return true;

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
            return false;
        }
    }

    private int ultimoIdGenerado;

    public int getUltimoIdGenerado() {
        return ultimoIdGenerado;
    }

    public void exportarPDF(GuiaEnvio guia, String rutaDestino) {
        Exportable exportador = new PDFGuiaEnvio();
        exportador.generarPDF(guia, rutaDestino);
    }

    public ArrayList<Object[]> listarGuias() {
        ArrayList<Object[]> lista = new ArrayList<>();
        String sentenciaSQL = "{call sp_mostrar_guias()}";

        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {
            ResultSet resultado = ejecutar.executeQuery();

            while (resultado.next()) {
                Object[] fila = {
                    resultado.getInt("id_ge"),
                    resultado.getString("remitente"),
                    resultado.getString("destinatario"),
                    resultado.getString("estado"),
                    resultado.getDouble("costo_total"),
                    resultado.getDate("fecha_despacho")
                };
                lista.add(fila);
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }

        return lista;
    }

    public boolean actualizarEstadoGuia(int idGe, String nuevoEstado) {
        String sentenciaSQL = "{call sp_actualizar_estado_guias(?, ?)}";

        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {
            ejecutar.setInt(1, idGe);
            ejecutar.setString(2, nuevoEstado);
            ejecutar.execute();

            return true;

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<Object[]> listarGuiasPorRemitente(int idRemitente) {
        ArrayList<Object[]> lista = new ArrayList<>();
        String sentenciaSQL = "{call sp_mostrar_guias_remitente(?)}";

        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {
            ejecutar.setInt(1, idRemitente);
            ResultSet resultado = ejecutar.executeQuery();

            while (resultado.next()) {
                Object[] fila = {
                    resultado.getInt("id_ge"),
                    resultado.getString("destinatario"),
                    resultado.getString("estado"),
                    resultado.getDouble("costo_total"),
                    resultado.getDate("fecha_despacho"),
                    resultado.getString("tipo_envio")
                };
                lista.add(fila);
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }

        return lista;
    }
}
