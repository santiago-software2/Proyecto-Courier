/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Usuario;
import Vista.UsuarioVista;
import java.util.ArrayList;

/**
 *
 * @author SUPERTRONICA
 */
public class UsuarioControlador {

    // REFERENCIA AL MODELO Y A LA VISTA
    private Usuario umodelo;
    private UsuarioVista uvista;
    int cont = 1;

    // CONSTRUCTORES
    public UsuarioControlador() {
    }

    public UsuarioControlador(Usuario umodelo, UsuarioVista uvista) {
        this.umodelo = umodelo;
        this.uvista = uvista;
    }

    //CARGAR LA TABLA EN LA VISTA
    public void cargarDatosTabla() {
        uvista.getModelo().setRowCount(0);
//        cont = 1;

        ArrayList<String[]> lUsuarios = umodelo.obtenerUsuarios();
        for (String[] ur : lUsuarios) {
            Object[] fila = {ur[0], ur[1], ur[2], ur[3], ur[4], ur[5], ur[6], ur[7]};
            uvista.getModelo().addRow(fila);
            cont++;
        }
    }

    // RECUPERAR LOS DATOS DE LA VISTA E INSERTAR
    public void agregarUsuario() {
        String nombre = uvista.getTxtNombres();
        String email = uvista.getTxtEmail();
        String telefono = uvista.getTxtTelefono();
        String usuario = uvista.getTxtUsuario();
        String contraseña = uvista.getTxtContraseña();
        String rol = uvista.getCmbRol().toString();

        if (!nombre.isEmpty() && !email.isEmpty() && !telefono.isEmpty() && !usuario.isEmpty() && !contraseña.isEmpty()
                && !rol.isEmpty()) {

            umodelo.setNombre(nombre);
            umodelo.setEmail(email);
            umodelo.setTelefono(telefono);
            umodelo.setUsername(usuario);
            umodelo.setContraseña(contraseña);

            int idGenerado = umodelo.insertarUsuarios(rol);

            if (idGenerado > -1) {
                cargarDatosTabla();
//                Object[] fila = {cont, umodelo.getNombre(), umodelo.getEmail(), umodelo.getTelefono(),
//                    umodelo.getUsername(), contraseña, rol, "Activo"};
//                uvista.getModelo().addRow(fila);
//                cont++;
            }

        } else {
            System.out.println("Por favor complete todos los campos.");
        }
    }

    public void seleccionarFila() {
        int filaSeleccionada = uvista.getTblUsuarios().getSelectedRow();
        if (filaSeleccionada != -1) {
            String nombre = uvista.getModelo().getValueAt(filaSeleccionada, 1).toString();
            String email = uvista.getModelo().getValueAt(filaSeleccionada, 2).toString();
            String telefono = uvista.getModelo().getValueAt(filaSeleccionada, 3).toString();

            uvista.setTxtNombres(nombre);
            uvista.setTxtEmail(email);
            uvista.setTxtTelefono(telefono);
        }
    }

    // ACTUALIZAR USUARIO SELECCIONADO
    public void actualizarUsuario() {
        int filaSeleccionada = uvista.getTblUsuarios().getSelectedRow();
        if (filaSeleccionada == -1) {
            System.out.println("Seleccione un usuario de la tabla para actualizar.");
            return;
        }

        int id = Integer.parseInt(uvista.getModelo().getValueAt(filaSeleccionada, 0).toString());
        String nombre = uvista.getTxtNombres();
        String email = uvista.getTxtEmail();
        String telefono = uvista.getTxtTelefono();
        String rol = uvista.getCmbRol().toString();

        if (!nombre.isEmpty() && !email.isEmpty() && !telefono.isEmpty() && !rol.isEmpty()) {
            umodelo.setId(id);
            umodelo.setNombre(nombre);
            umodelo.setEmail(email);
            umodelo.setTelefono(telefono);
            umodelo.setRol(rol);

            boolean actualizado = umodelo.actualizarUsuario();

            if (actualizado) {
                cargarDatosTabla(); // recarga la tabla con los datos ya actualizados
            }
        } else {
            System.out.println("Por favor complete todos los campos.");
        }
    }

// INHABILITAR USUARIO SELECCIONADO
    public void inhabilitarUsuario() {
        int filaSeleccionada = uvista.getTblUsuarios().getSelectedRow();
        if (filaSeleccionada == -1) {
            System.out.println("Seleccione un usuario de la tabla para inhabilitar.");
            return;
        }

        int id = Integer.parseInt(uvista.getModelo().getValueAt(filaSeleccionada, 0).toString());
        umodelo.setId(id);

        boolean inhabilitado = umodelo.inhabilitarUsuario();

        if (inhabilitado) {
            cargarDatosTabla(); // recarga la tabla reflejando el nuevo estado
        }
    }

    public void iniciar() {
        uvista.getBtnCrear().addActionListener(e -> agregarUsuario());
        uvista.getBtnMostrar().addActionListener(e -> cargarDatosTabla());
        uvista.getBtnActualizar().addActionListener(e -> actualizarUsuario());
        uvista.getBtnInhabilitar().addActionListener(e -> inhabilitarUsuario());
        uvista.getTblUsuarios().getSelectionModel().addListSelectionListener(e -> seleccionarFila());
        uvista.setVisible(true);
        this.cargarDatosTabla();
    }
}
