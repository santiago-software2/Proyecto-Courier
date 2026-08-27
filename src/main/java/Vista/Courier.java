/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package Vista;

import Controlador.ConexionBDD;
import Controlador.UsuarioControlador;
import Modelo.Usuario;

/**
 *
 * @author SUPERTRONICA
 */
public class Courier {

    public static void main(String[] args) {
        ConexionBDD conx = new ConexionBDD();
        conx.conectar();

        Usuario usumodelo = new Usuario();
        UsuarioVista uvista = new UsuarioVista();
        UsuarioControlador usucontrolador = new UsuarioControlador(usumodelo, uvista);
        usucontrolador.iniciar();
    }
}
