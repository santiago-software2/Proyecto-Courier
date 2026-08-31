/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileOutputStream;
import com.itextpdf.text.Document;

/**
 *
 * @author SUPERTRONICA
 */
public class PDFGuiaEnvio implements Exportable {

    @Override
    public void generarPDF(GuiaEnvio guia, String rutaDestino) {
        Document documento = new Document();

        try {
            PdfWriter.getInstance(documento, new FileOutputStream(rutaDestino));
            documento.open();

            documento.add(new Paragraph("=== GUIA DE ENVIO ==="));
            documento.add(new Paragraph("ID: " + guia.getIdGe()));
            java.text.SimpleDateFormat formatoFecha = new java.text.SimpleDateFormat("yyyy-MM-dd");
            documento.add(new Paragraph("Fecha: " + formatoFecha.format(guia.getFechaDespacho())));
            documento.add(new Paragraph("Direccion de origen: " + guia.getDireccionOrigen()));
            documento.add(new Paragraph("Tipo de envio: " + guia.getTipoEnvio()));
            documento.add(new Paragraph("Tiempo de entrega: " + guia.getTiempoEntrega()));
            documento.add(new Paragraph("Estado: " + guia.getEstado()));
            documento.add(new Paragraph("Costo total: $" + guia.getCostoTotal()));

            documento.close();

            System.out.println("PDF generado con éxito en: " + rutaDestino);

        } catch (Exception e) {
            System.out.println("Error al generar el PDF: " + e.getMessage());
        }
    }
}
