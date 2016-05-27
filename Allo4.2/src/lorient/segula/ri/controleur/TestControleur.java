package lorient.segula.ri.controleur;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import edu.mit.csail.sdg.alloy4.Err;
import lorient.segula.ri.controleur.Controleur;

public class TestControleur {

	private static String chaine;

	public static void main(String[] args){

		Controleur controleur;
		//String file = "ASM.als";

		try {
			//fichier lecture
			InputStream ips =  new FileInputStream(args[1]);
			InputStreamReader ipsr = new InputStreamReader(ips);
			BufferedReader br = new BufferedReader(ipsr);
			//second ligne du ficher sortie 
			chaine = br.readLine();
			br.close();
		}catch(Exception e){
			System.out.println(e.toString());
			
		}
	
		try {
			controleur = new Controleur(args[0]);
			controleur.LectureCommande(); 
			//System.out.println(chaine);
			switch (chaine){ 
					
					case "IsolatedComponent":
							controleur.EvaluationChecking("{t:TRCH+St+HP| not NotIsolatedComponent[t]}");	
							controleur.affichage();
							break;
							
					case "isTransfertPossible":
							controleur.EvaluationChecking("{t:TRCH+St+HP| not NotIsolatedComponent[t]}");
							controleur.affichage();
							break;
							
					case "isBrassagePossible":
							controleur.EvaluationChecking("{t:TRCH+St+HP| not NotIsolatedComponent[t]}");
							controleur.affichage();
							break;
					default:
							System.out.println("aucune commande trouver");
					
			}
		} catch (Err e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		

	}

}
