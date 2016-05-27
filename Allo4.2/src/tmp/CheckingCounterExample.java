package tmp;

import java.util.logging.Level;
import java.util.logging.Logger;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4compiler.ast.Command;
import edu.mit.csail.sdg.alloy4compiler.ast.Expr;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Solution;
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod;

public class CheckingCounterExample {

	private static String outputfilename = "TraceXML.xml";
	private static String outputfilename2 = "TraceXML2.xml";

	public static void main(String[] args)throws Exception {
		
		A4Reporter rep = new A4Reporter();
		
		//creation d'un monde grace a un model issu d'une chaine de caractere et du reporter associé 
		Module world = CompUtil.parseEverything_fromFile(rep, null, "ceilingsAndFloors.als");
		
		//options
		A4Options options = new A4Options();
		options.solver = A4Options.SatSolver.SAT4J;
		options.skolemDepth = 2;
		
        //recuperation de chaque commande du fichier  world.getAllCommands() dans ce cas, on a juste le check... c'est pouquoi on a un seul fichier de sortie
		 for (Command command : world.getAllCommands()) {
			 	System.out.println("============ Informations ============");
			    System.out.println("Solver chosen: "+ options.solver);
	        	System.out.println("SkolemDepth: "+ options.skolemDepth);
	        	System.out.println("Command executed: "+ command);
	        	System.out.println("");
	        	
	            A4Solution sol= null;
	            try {
	            	 //calcul solution et retour dans sol
	                sol = TranslateAlloyToKodkod.execute_command(rep, world.getAllReachableSigs(), command, options);
	                System.out.println(sol);
	                if(!(sol.satisfiable()))return;
	  
	                System.out.println("Results Checking:");
	                //sol = sol.next().next();
	                Expr e1 = CompUtil.parseOneExpression_fromString(world, " some m1: Man |  not Geometry and (all n: Man | m1.Above[n])");
	                System.out.println("\n"+e1);
		            System.out.println(sol.eval(e1));
		            System.out.println("----------------------------------------------------------------------");
		            
		           /* Expr e2 = CompUtil.parseOneExpression_fromString(world, "some St1:St , St2: St| isTransfertPossible[St1, HP,St2] ");
	                System.out.println(e2);
		            System.out.println(sol.eval(e2));*/
		            
	                sol.writeXML(outputfilename);
	                sol.next().next().writeXML(outputfilename2);
	            } catch (Err ex) {
	                Logger.getLogger(AlloyTest.class.getName()).log(Level.SEVERE, null, ex);
	            }
	        }

	}

}
