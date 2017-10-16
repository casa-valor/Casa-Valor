package org.fluttercode.datafactory.impl;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Math.abs;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.Date;
import java.util.Random;

/**
 *
 * @author calos
 */
public class CasaValor {
    @SuppressWarnings("empty-statement")
    public static void main(String[] args) throws IOException{
        
        DataFactory df = new DataFactory();
        
        //imoveis
        
        FileWriter arq = new FileWriter("imovel.sql");
        PrintWriter gravarArq = new PrintWriter(arq);
        Random random = new Random();
        gravarArq.printf("INSERT INTO Imovel (preco, area, data_insercao, data_publicacao) VALUES\n");
        
        for (int i=1; i<=1500000; i++){
            Integer um = random.nextInt(1000000)+1;
            Integer dois = random.nextInt(1001)+1;
            LocalDate tres = LocalDate.now();
            LocalDate quatro = LocalDate.now();
            
            gravarArq.printf("("+um+","+dois+",'" +tres+ "','"+quatro+"'),\n");
        }
     arq.close();
     
     //Bairro
     
        arq = new FileWriter("Bairro.sql");
        gravarArq = new PrintWriter(arq);
        gravarArq.printf("INSERT INTO bairro (nome, cep ,FK_Cidade_id) VALUES\n");
        
        for (int i=1; i<=5000; i++){
            String nome = df.getCity();
            Integer cep = random.nextInt(29000000);
            Integer fkCidade = random.nextInt(50000)+1;
            
            gravarArq.printf("('"+nome+"',"+cep+","+fkCidade+"),\n");
        }
     arq.close();
     
     //cidades
     
        arq = new FileWriter("cidade.sql");
        gravarArq = new PrintWriter(arq);
        gravarArq.printf("INSERT INTO cidade (nome, FK_Estado_id) VALUES\n");
        
        for (int i=1; i<=500000; i++){
            String nome = df.getCity();
            Integer fkEstado = random.nextInt(26)+1;
            
            gravarArq.printf("('"+nome+"',"+fkEstado+"),\n");
        }
     arq.close();
     
     
     //estados
     
     arq = new FileWriter("estado.sql");
        gravarArq = new PrintWriter(arq);
        gravarArq.printf("INSERT INTO Estado (nome, FK_Pais_id) VALUES\n");
        
        for (int i=1; i<=26; i++){
            String nome = df.getCity().substring(0, 2);
            Integer fkPais = random.nextInt(193)+1;
            
            gravarArq.printf("('"+nome.toUpperCase()+"',"+fkPais+"),\n");
        }
     arq.close();
     
     //Pais
     
        arq = new FileWriter("pais.sql");
        gravarArq = new PrintWriter(arq);
        gravarArq.printf("INSERT INTO Pais (nome) VALUES\n");
        //193 são os paises registrados na ONU
        for (int i=1; i<=193; i++){
            String nome = df.getCity().substring(0, 3);
            gravarArq.printf("('"+nome.toUpperCase()+"' ),\n");
        }
     arq.close();
     
      //Categoria
      //fazer na mão.
     
    }
}