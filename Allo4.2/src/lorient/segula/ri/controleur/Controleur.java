package lorient.segula.ri.controleur;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.ConstList;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4compiler.ast.Command;
import edu.mit.csail.sdg.alloy4compiler.ast.Expr;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Solution;
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod;

public class Controleur extends AbstractControleur{

	public Controleur(String File) throws Err {
		super(File);
		// TODO Auto-generated constructor stub
	}
	/**
	 * @return  retourne liste de commandes non modifiables contenu dans le module world
	 */
	public void LectureCommande(){
		super.setCommandes(super.getWorld().getAllCommands()) ;
	}
	/**
	 * 
	 * @return retourne la premiere comande de la liste 
	 */
	public Command ExtractCommande(){
		
		return super.getCommandes().get(0);
	}
	/**
	 * modifie l'attribut resultat et insert le resultat de l'evalutation
	 * @param formulaTocheck contient la formule à évaluer sur le module en cours
	 * @return retourne un boolean qui vaut "true" si l'evaluation n'a generé aucune erreur et "false" au cas contraire
	 */
	public boolean EvaluationChecking(String formulaTocheck){
	 	A4Solution sol= null;
    	 try {
			sol = TranslateAlloyToKodkod.execute_command(super.getRep(), super.getWorld().getAllReachableSigs(), ExtractCommande(), super.getOptions());
			if(!(sol.satisfiable()))return false;
			//System.out.println("Results Checking:");
			Expr e1 = CompUtil.parseOneExpression_fromString(super.getWorld(), formulaTocheck);
			super.setResultat(sol.eval(e1).toString());
			return true;
		} catch (Err e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    		return false;
    }
     
	/**
	 *  separe les contre-exemples contenu dans une chaine et les mets dans un tableau de string
	 * @return 
	 */
	public String[] CounterExample(){
		if (super.getResultat()!= null){
    	String parseResultat = super.getResultat().substring(1, super.getResultat().length()-1);	
    	return  parseResultat.split(",");
    	}
		return null;
    }
    
    
    
	
/**
 * le but de cette methode est d'afficher les contre exemples sur une autre
 *  formes afin de facilirer leurs exploitations le fichier visio du sypnotique
 */
	public void affichage() {
		int inSup;
		String  chNew = ""; 
		for (int i=0 ; i< CounterExample().length; i++){
			inSup = CounterExample()[i].indexOf("$");
			if(inSup >= 0)
	         {
	            chNew = CounterExample()[i].substring(0,inSup) + CounterExample()[i].substring(inSup +1);
	         }else 
	        	 chNew = CounterExample()[i];
			System.out.print( chNew.replaceAll(" ", ""));// retire les espaces qui se trouvent dans les contre-exemples trouvés 
			if(i != CounterExample().length - 1)
		    System.out.print(";"); // separe les elements par des ";", afin de faciliter la lecture par la macro Visio 
		}
}
	
	
	public Command GetOneCommand(int i){
		if (super.getCommandes().get(i)!= null)
			return super.getCommandes().get(i);
		return null;
		
	}
	
	
	
	

}
