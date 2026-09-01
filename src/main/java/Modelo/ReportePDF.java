/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import javax.imageio.ImageIO;
import org.jfree.chart.JFreeChart;

/**
 *
 * @author SUPERTRONICA
 */
public class ReportePDF {

    public void generarPDF(ArrayList<Object[]> datos, JFreeChart grafico, String nombreRemitente, String rutaDestino) {
        Document documento = new Document();

        try {
            PdfWriter.getInstance(documento, new FileOutputStream(rutaDestino));
            documento.open();

            documento.add(new Paragraph("=== REPORTE DE ENVIOS ==="));
            documento.add(new Paragraph("Remitente: " + nombreRemitente));
            documento.add(new Paragraph(" "));

            // Tabla con los datos
            PdfPTable tabla = new PdfPTable(2);
            tabla.addCell(new PdfPCell(new Paragraph("Tipo de Envío")));
            tabla.addCell(new PdfPCell(new Paragraph("Cantidad")));

            for (Object[] fila : datos) {
                tabla.addCell(String.valueOf(fila[0]));
                tabla.addCell(String.valueOf(fila[1]));
            }
            documento.add(tabla);
            documento.add(new Paragraph(" "));

            // Gráfico convertido a imagen
            BufferedImage imagenGrafico = grafico.createBufferedImage(500, 300);
            ByteArrayOutputStream salida = new ByteArrayOutputStream();
            ImageIO.write(imagenGrafico, "png", salida);
            Image imagenPdf = Image.getInstance(salida.toByteArray());
            documento.add(imagenPdf);

            documento.close();

            System.out.println("PDF generado con éxito en: " + rutaDestino);

        } catch (Exception e) {
            System.out.println("Error al generar el PDF: " + e.getMessage());
        }
    }

}
