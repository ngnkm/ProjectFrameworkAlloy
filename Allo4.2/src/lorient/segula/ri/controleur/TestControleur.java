package lorient.segula.ri.controleur;

import edu.mit.csail.sdg.alloy4.Err;
import lorient.segula.ri.controleur.AbstractControleur;
import lorient.segula.ri.controleur.Controleur;

public class TestControleur {

	public static void main(String[] args) throws Err {

		AbstractControleur controleur;
		String file = "ASM.als";
		controleur = new Controleur(file);
		controleur.LectureCommande();
		controleur.EvaluationChecking("{t:TRCH+St+HP| not NotIsolatedComponent[t]}");
		controleur.affichage();
		
		

	}

}
