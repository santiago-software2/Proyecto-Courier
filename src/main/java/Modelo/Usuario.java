/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import Controlador.ConexionBDD;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

/**
 *
 * @author SUPERTRONICA
 */
public class Usuario {

    private int idUsuario;
    private String nombre;
    private String email;
    private String telefono;
    private String username;
    private String contraseña;
    private String rol;
    private String estado;
    
    public static Usuario usuarioActual;

    public Usuario() {
    }

    public Usuario(int idUsuario, String nombre, String email, String telefono, String username, String contraseña, String rol, String estado) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.email = email;
        this.telefono = telefono;
        this.username = username;
        this.contraseña = contraseña;
        this.rol = rol;
        this.estado = estado;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public String getEmail() {
        return email;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getUsername() {
        return username;
    }

    public String getContraseña() {
        return contraseña;
    }

    public String getRol() {
        return rol;
    }

    public String getEstado() {
        return estado;
    }

    public void setId(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    //  EX CONTRALADOR 
    //INSTANCIAR LA CONEXIÓN A LA BASE DE DATOS
    ConexionBDD conectar = new ConexionBDD();
    //CLASE QUE ME PERMITA CONECTARME DIRECTAMENTE A MYSQL
    Connection conectado = (Connection) conectar.conectar();
    //CLASE QUE ME PERMITE EJECUTAR MI SENTENCIA SQL
    PreparedStatement ejecutar;
    //OBTENER RESULTADOS DE LA CONSULTA
    ResultSet resultado;

    //MÉTODOS DE TRANSACCIONABILIDAD
    public int insertarUsuarios(String rol) {
        int idGenerado = -1;
        String sentenciaSQL = "{call sp_crear_usuario(?, ?, ?, ?, ?, ?, ?)}";
        // USO DE TRY-WITH-RESOURCES: 
        // El CallableStatement se cerrará automáticamente al finalizar la ejecución.
        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {
            // 1. Mapeo de parámetros de entrada (IN)          
            ejecutar.setString(1, nombre);
            ejecutar.setString(2, email);
            ejecutar.setString(3, telefono);
            ejecutar.setString(4, username);
            ejecutar.setString(5, contraseña);
            ejecutar.setString(6, rol);

            // 2. Parámetro de salida (OUT idCliente)
            ejecutar.registerOutParameter(7, Types.INTEGER);

            // 3. Ejecutar el Stored Procedure
            ejecutar.execute();

            // 4. Recuperar la Primary Key recién insertada
            idGenerado = ejecutar.getInt(7);

            if (idGenerado > -1) {
                System.out.println("Usuario creado en la BDD");
            } else {
                System.out.println("El usuario no se pudo crear. Verifique los datos ingresados.");
            }

        } catch (SQLException e) {
            System.out.println("Comuníquese con el Administrador para solicitar ayuda.");
            System.err.println("Error en el conector MySQL JDBC: " + e.getMessage());
        }

        return idGenerado;

    }

    public ArrayList<String[]> obtenerUsuarios() {
        ArrayList<String[]> lregistros = new ArrayList<>();

        try {
            String sentenciaSQL = "{call sp_mostrar_usuarios()};";
            ejecutar = conectado.prepareCall(sentenciaSQL);
            ResultSet res = ejecutar.executeQuery();

            while (res.next()) {
                String[] listaUsaurios = new String[8];
                listaUsaurios[0] = res.getInt("id_usuario") + "";
                listaUsaurios[1] = res.getString("nombre");
                listaUsaurios[2] = res.getString("email");
                listaUsaurios[3] = res.getString("telefono");
                listaUsaurios[4] = res.getString("username");
                listaUsaurios[5] = res.getString("contrasena");
                listaUsaurios[6] = res.getString("rol");
                listaUsaurios[7] = res.getString("estado");
                lregistros.add(listaUsaurios);

            }
            ejecutar.close();
//            conectado.close();
            return lregistros;
        } catch (SQLException e) {
            System.out.println("------" + e);
        }
        return lregistros;
    }

    public boolean actualizarUsuario() {
        int filasA = 0;
        String sentenciaSQL = "{call sp_actualizar_usuario(?, ?, ?, ?, ?, ?)}";
        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {

            ejecutar.setInt(1, idUsuario);
            ejecutar.setString(2, nombre);
            ejecutar.setString(3, email);
            ejecutar.setString(4, telefono);
            ejecutar.setString(5, rol);
            ejecutar.registerOutParameter(6, Types.INTEGER);

            ejecutar.execute();
            filasA = ejecutar.getInt(6);

            if (filasA > 0) {
                System.out.println("Usuario actualizado en la BDD");
            } else {
                System.out.println("No se encontró el usuario a actualizar.");
            }
        } catch (SQLException e) {
            System.out.println("Error al actualizar usuario: " + e.getMessage());
        }
        return filasA > 0;
    }

    public boolean inhabilitarUsuario() {
        int filasI = 0;
        String sentenciaSQL = "{call sp_inhabilitar_usuario(?, ?)}";
        try (CallableStatement ejecutar = conectado.prepareCall(sentenciaSQL)) {

            ejecutar.setInt(1, idUsuario);
            ejecutar.registerOutParameter(2, Types.INTEGER);

            ejecutar.execute();
            filasI = ejecutar.getInt(2);

            if (filasI > 0) {
                System.out.println("Usuario inhabilitado en la BDD");
            } else {
                System.out.println("No se encontró el usuario a inhabilitar.");
            }
        } catch (SQLException e) {
            System.out.println("Error al inhabilitar usuario: " + e.getMessage());
        }
        return filasI > 0;
    }
}
