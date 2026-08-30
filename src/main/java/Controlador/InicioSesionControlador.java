/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Administrador;
import Modelo.Remitente;
import Modelo.Usuario;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

/**
 *
 * @author SUPERTRONICA
 */
public class InicioSesionControlador {
    //  EX CONTRALADOR 
    //INSTANCIAR LA CONEXIÓN A LA BASE DE DATOS

    ConexionBDD conectar = new ConexionBDD();
    //CLASE QUE ME PERMITA CONECTARME DIRECTAMENTE A MYSQL
    Connection conectado = (Connection) conectar.conectar();
    //CLASE QUE ME PERMITE EJECUTAR MI SENTENCIA SQL
    PreparedStatement ejecutar;
    //OBTENER RESULTADOS DE LA CONSULTA
    ResultSet resultado;
    
    public Usuario iniciarSesion(String usuario, String clave) {
        String sentenciaSQL = "{call sp_inicio_sesion(?, ?)}";

        // USO DE TRY-WITH-RESOURCES:
        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {

            ejecutar.setString(1, usuario);
            ejecutar.setString(2, clave);

            ResultSet resultado = ejecutar.executeQuery();

            if (resultado.next()) {
                String rolUsuario = resultado.getString("rol");
                Usuario u;

                if (rolUsuario.equals("Administrador")) {
                    u = new Administrador();
                } else {
                    u = new Remitente();
                }

                u.setId(resultado.getInt("id_usuario"));
                u.setNombre(resultado.getString("nombre"));
                u.setEmail(resultado.getString("email"));
                u.setTelefono(resultado.getString("telefono"));
                u.setRol(rolUsuario);

                return u;
            } else {
                return null;
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
            return null;
        }
    }
}
